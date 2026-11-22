local loader = require("loader")

local M = {}

function M.setup()
  loader.packadd("tokyonight.nvim")
  require("tokyonight").setup({
    style = "storm",
    styles = {
      comments = { italic = true },
      keywords = { bold = true, italic = false },
    },
    day_brightness = 0.4,
  })
end

return M
