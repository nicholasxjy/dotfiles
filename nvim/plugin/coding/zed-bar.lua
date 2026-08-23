local loader = require("loader")

local setup = function()
  loader.packadd("zed-bar.nvim")

  local zed_bar = require("zed-bar")

  zed_bar.setup()
end

loader.defer_buffer("zed-bar", setup)
