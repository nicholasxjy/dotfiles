require("rainbow-tags").setup({
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
