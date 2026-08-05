local loader = require("loader")

local setup = function()
  loader.packadd("nvim-ts-autotag")
  local ts_autotag = require("nvim-ts-autotag")
  ts_autotag.setup()
end

loader.defer_buffer("coding", setup)
