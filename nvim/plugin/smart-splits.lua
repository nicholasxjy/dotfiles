local util = require("util")

local function smart_splits()
  util.ensure_plugin("smart-splits.nvim", function()
    require("smart-splits").setup({
      ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
      ignored_buftypes = { "nofile" },
    })
  end)

  return require("smart-splits")
end

vim.keymap.set("n", "<c-h>", function()
  smart_splits().move_cursor_left()
end, { desc = "Focus Left" })

vim.keymap.set("n", "<c-j>", function()
  smart_splits().move_cursor_down()
end, { desc = "Focus Down" })

vim.keymap.set("n", "<c-k>", function()
  smart_splits().move_cursor_up()
end, { desc = "Focus Up" })

vim.keymap.set("n", "<c-l>", function()
  smart_splits().move_cursor_right()
end, { desc = "Focus Right" })
