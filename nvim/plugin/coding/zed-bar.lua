local loader = require("loader")

local setup = function()
  loader.packadd("zed-bar.nvim")
  local zed_bar = require("zed-bar")
  zed_bar.setup()
end

loader.on_very_lazy("zed-bar", setup)
