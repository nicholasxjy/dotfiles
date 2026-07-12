vim.pack.add({
  "https://github.com/nicholasxjy/rainbow-tags.nvim",
})

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
