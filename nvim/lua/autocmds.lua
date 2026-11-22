vim.filetype.add({
  filename = {
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
  },
})

local function augroup(name)
  return vim.api.nvim_create_augroup("sjvim_" .. name, { clear = true })
end

-- NOTE: pack add
vim.api.nvim_create_user_command("PackAdd", function(opts)
  vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins (PackAdd user/repo)" })

-- NOTE: pack update
vim.api.nvim_create_user_command("PackUpdate", function(opts)
  if opts.args ~= "" then
    -- update specific plugins
    local plugins = vim.split(opts.args, "%s+", { trimempty = true })
    vim.pack.update(plugins)
  else
    -- update all
    vim.pack.update()
  end
end, { desc = "Update all plugins or specific ones", nargs = "*" })

-- NOTE: pack del
vim.api.nvim_create_user_command("PackDel", function(opts)
  vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins (space separated)" })

-- NOTE: pack nonactive - show all non active plugins on disk but removed from pack.lua
vim.api.nvim_create_user_command("PackCheck", function()
  local non_active = {}

  for _, plugin in ipairs(vim.pack.get()) do
    if not plugin.active then
      non_active[#non_active + 1] = plugin.spec.name
    end
  end

  if #non_active == 0 then
    vim.notify("🆗 No non-active plugins found!", vim.log.levels.INFO)
    return
  end

  vim.print("😴 Non-active plugins :")
  print(" ")
  for _, name in ipairs(non_active) do
    print(name)
  end

  print(" ")

  local choice = vim.fn.confirm(
    "Delete ALL non-active plugins from disk?",
    "&Yes\n&No",
    2 -- default = No
  )

  if choice == 1 then
    vim.pack.del(non_active)
    vim.notify("🗑️  Deleted " .. #non_active .. " non-active plugin(s)", vim.log.levels.INFO)
    print("Non-active plugins deleted!")
    vim.api.nvim_exec_autocmds("User", { pattern = "PackChanged" })
  else
    vim.notify("Cancelled. No plugins were deleted!", vim.log.levels.INFO)
  end
end, { desc = "List non active plugins and select to delete" })
-- not autoformat for some filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("disable_autoformat"),
  pattern = { "bash", "sh", "java" },
  callback = function()
    vim.b.autoformat = false
  end,
})
-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "checkhealth",
    "gitsigns-blame",
    "grug-far",
    "help",
    "qf",
  },
  callback = function(event)
    local bufnr = event.buf
    vim.bo[bufnr].buflisted = false
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end

      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
      end, {
        buffer = bufnr,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})
-- Check if we need to reload files changed outside Nvim
local last_hold_check = 0
local pending_all = false
local pending_bufs = {}

local function flush_checktime()
  local check_all = pending_all
  local bufs = pending_bufs
  pending_all = false
  pending_bufs = {}

  if vim.fn.mode() == "c" then
    return
  end

  if check_all then
    pcall(vim.cmd.checktime)
    return
  end

  for bufnr in pairs(bufs) do
    if
      vim.api.nvim_buf_is_valid(bufnr)
      and vim.api.nvim_buf_is_loaded(bufnr)
      and vim.bo[bufnr].buftype == ""
      and vim.api.nvim_buf_get_name(bufnr) ~= ""
    then
      pcall(vim.cmd.checktime, tostring(bufnr))
    end
  end
end

local function schedule_checktime(bufnr)
  if bufnr ~= nil then
    if
      not vim.api.nvim_buf_is_valid(bufnr)
      or vim.bo[bufnr].buftype ~= ""
      or vim.api.nvim_buf_get_name(bufnr) == ""
    then
      return
    end
  end

  local needs_schedule = not pending_all and next(pending_bufs) == nil
  if bufnr == nil then
    pending_all = true
  else
    pending_bufs[bufnr] = true
  end

  if needs_schedule then
    -- Let the triggering event finish before checking so autoread can reload clean buffers.
    vim.schedule(flush_checktime)
  end
end

local checktime_group = augroup("checktime")

-- Focus and terminal transitions check all loaded file buffers regardless of the
-- current buffer's buftype (e.g. leaving a terminal or returning while in Neo-tree/Oil).
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = checktime_group,
  callback = function()
    schedule_checktime()
  end,
})

-- Buffer-scoped events only stat the current buffer. CursorHold/CursorHoldI act as
-- a throttled fallback on Neovim < 0.13 (no built-in file watcher) and when Nvim's
-- watcher is inactive (e.g. deleted-and-recreated files or BufNewFile).
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = checktime_group,
  callback = function(args)
    if args.event ~= "BufEnter" then
      local now = vim.uv.now()
      if now - last_hold_check < 500 then
        return
      end
      last_hold_check = now
    end
    schedule_checktime(args.buf)
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})
