local excluded_last_loc_filetypes = {
  gitcommit = true,
}

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
  local non_active = vim
    .iter(vim.pack.get())
    :filter(function(x)
      return not x.active
    end)
    :map(function(x)
      return x.spec.name
    end)
    :totable()

  if #non_active == 0 then
    vim.notify("🆗 No non-active plugins found!", vim.log.levels.INFO)
    return
  end

  vim.print("😴 Non-active plugins :")
  print(" ")
  -- vim.print(non_active)
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
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "shell", "bash", "sh", "java" },
  callback = function()
    vim.b.autoformat = false
  end,
})
-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "DiffviewFiles",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})
-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
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

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local buf = event.buf
    local buf_vars = vim.b[buf]
    if excluded_last_loc_filetypes[vim.bo[buf].filetype] or buf_vars.lazyvim_last_loc then
      return
    end

    buf_vars.lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    if mark[1] == 0 or mark[1] > vim.api.nvim_buf_line_count(buf) then
      return
    end

    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_get_current_buf() == buf then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
        vim.cmd("normal! zz")
      end
    end)
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
