local loader = require("loader")

local setup = function()
vim.cmd.packadd("zed-bar.nvim")
require("zed-bar").setup({})
end

loader.defer_buffer("zed-bar", setup)
