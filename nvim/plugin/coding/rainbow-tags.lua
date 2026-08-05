local loader = require("loader")

local setup = function()
  loader.packadd("rainbow-tags.nvim")
  local rainbow_tags = require("rainbow-tags")

  rainbow_tags.setup({
    enabled = true,
    filetypes = { "typescriptreact", "javascriptreact", "tsx" },
    lang = "tsx",
    include_intrinsic = true,
    strategy = "name",
    create_default_highlights = true,
    highlight_groups = {
      "RainbowDelimiterRed",
      "RainbowDelimiterCyan",
      "RainbowDelimiterYellow",
      "RainbowDelimiterGreen",
      "RainbowDelimiterOrange",
      "RainbowDelimiterViolet",
      "RainbowDelimiterBlue",
    },
  })
end

loader.defer_buffer("rainbow-tags", setup)
