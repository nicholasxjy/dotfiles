local loader = require("loader")
local cond = vim.env.HERDR_ENV ~= "1"

local setup = function()
vim.cmd.packadd("smart-splits.nvim")

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
end

if cond then
  loader.defer("smart-splits", setup)
end
