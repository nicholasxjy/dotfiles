local M = {}

local loaded = {}
local groups = {}
local packadded = {}
local very_lazy_fired = false

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
    vim.schedule(function()
      M.load(name, setup)
    end)
    return
  end

  M.defer(name, setup, "User", { pattern = "VeryLazy" })
end

--- Run `setup` when a real file buffer is first read.
---
--- With `opts.schedule`, the setup is pushed to the next tick while Nvim is
--- still starting up. That keeps it out of the `BufReadPre` that runs before the
--- first frame when a file is passed on the command line. Only use it for
--- plugins that either react to later events or attach to open buffers
--- themselves — anything that has to decorate the very first render must stay
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

      if schedule and vim.v.vim_did_enter == 0 then
        vim.schedule(function()
          M.load(name, setup)
        end)
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
