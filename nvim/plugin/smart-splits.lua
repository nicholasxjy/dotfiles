local ss = require("smart-splits")

ss.setup({
  ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
  ignored_buftypes = { "nofile" },
})

vim.keymap.set("n", "<c-h>", function()
  ss.move_cursor_left()
end, { desc = "Focus Left" })

vim.keymap.set("n", "<c-j>", function()
  ss.move_cursor_down()
end, { desc = "Focus Down" })

vim.keymap.set("n", "<c-k>", function()
  ss.move_cursor_up()
end, { desc = "Focus Up" })

vim.keymap.set("n", "<c-l>", function()
  ss.move_cursor_right()
end, { desc = "Focus Right" })
