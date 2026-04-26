require("smart-splits").setup({
  ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
  ignored_buftypes = { "nofile" },
})

vim.keymap.set("n", "<c-h>", function()
  require("smart-splits").move_cursor_left()
end, { desc = "Focus Left" })

vim.keymap.set("n", "<c-j>", function()
  require("smart-splits").move_cursor_down()
end, { desc = "Focus Down" })

vim.keymap.set("n", "<c-k>", function()
  require("smart-splits").move_cursor_up()
end, { desc = "Focus Up" })

vim.keymap.set("n", "<c-l>", function()
  require("smart-splits").move_cursor_right()
end, { desc = "Focus Right" })
