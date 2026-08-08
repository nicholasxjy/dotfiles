local M = {}

local loaded = {}
local groups = {}
local packadded = {}
local very_lazy_fired = false
local pending = {}
local pending_head = 1
local pending_scheduled = false

local function group(name)
  groups[name] = groups[name] or vim.api.nvim_create_augroup("sjvim_loader_" .. name, { clear = true })
  return groups[name]
end

local function clear_group(name)
  local id = groups[name]
  if id then
    groups[name] = nil
    pcall(vim.api.nvim_del_augroup_by_id, id)
  end
end

--- `:packadd` plugins at most once per session.
--- Repeated `:packadd` re-sources the plugin's `plugin/` files, so every caller
--- goes through this to keep shared dependencies from being sourced twice.
function M.packadd(...)
  for _, name in ipairs({ ... }) do
    if not packadded[name] then
      packadded[name] = true
      vim.cmd.packadd(name)
    end
  end
end

function M.load(name, setup)
  if loaded[name] then
    return true
  end

  -- Mark before running so a setup that re-enters (via autocmds it installs)
  -- cannot recurse.
  loaded[name] = true

  local ok, err = pcall(setup)
  if not ok then
    loaded[name] = false
    vim.notify(("Failed to load %s:\n%s"):format(name, err), vim.log.levels.ERROR)
    return false
  end

  return true
end

local function run_pending()
  local item = pending[pending_head]
  if not item then
    pending = {}
    pending_head = 1
    pending_scheduled = false
    return
  end

  pending_head = pending_head + 1
  M.load(item.name, item.setup)

  -- Give Nvim a chance to redraw and process input between unrelated plugin
  -- setups instead of turning every deferred load into one long pause.
  vim.defer_fn(run_pending, 1)
end

local function enqueue(name, setup)
  pending[#pending + 1] = { name = name, setup = setup }
  if pending_scheduled then
    return
  end

  pending_scheduled = true
  vim.defer_fn(run_pending, 1)
end

function M.defer(name, setup, events, opts)
  opts = vim.tbl_extend("force", {
    group = group(name),
    once = true,
    callback = function()
      M.load(name, setup)
      clear_group(name)
    end,
  }, opts or {})

  vim.api.nvim_create_autocmd(events or "VimEnter", opts)
end

--- Run `setup` once the UI has drawn its first frame.
--- Preferred over `defer` for anything not needed to display the first buffer.
function M.on_very_lazy(name, setup)
  if very_lazy_fired then
    enqueue(name, setup)
    return
  end

  vim.api.nvim_create_autocmd("User", {
    group = group(name),
    pattern = "VeryLazy",
    once = true,
    callback = function()
      clear_group(name)
      enqueue(name, setup)
    end,
  })
end

--- Run `setup` when a real file buffer is first read.
---
--- With `opts.schedule`, the setup is queued outside `BufReadPre`. Only use it
--- for plugins that either react to later events or attach to open buffers
--- themselves — anything that has to decorate the first render must stay
--- synchronous.
function M.defer_buffer(name, setup, opts)
  local schedule = opts and opts.schedule

  M.defer(name, setup, { "BufReadPre", "BufNewFile", "BufFilePost" }, {
    once = false,
    callback = function(args)
      local bufname = vim.api.nvim_buf_get_name(args.buf)
      if vim.bo[args.buf].buftype ~= "" or bufname == "" then
        return
      end

      clear_group(name)

      if schedule then
        enqueue(name, setup)
      else
        M.load(name, setup)
      end
    end,
  })
end

--- Emit `User VeryLazy` after startup finished and the first frame was drawn.
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("sjvim_loader_very_lazy", { clear = true }),
  once = true,
  nested = true,
  callback = function()
    vim.schedule(function()
      very_lazy_fired = true
      vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy", modeline = false })
    end)
  end,
})

return M
