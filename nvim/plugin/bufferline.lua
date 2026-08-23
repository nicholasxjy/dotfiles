local loader = require("loader")

local setup = function()
  loader.packadd("bufferline.nvim")

  require("bufferline").setup({})
end

loader.defer_buffer("bufferline", setup, { schedule = true })
