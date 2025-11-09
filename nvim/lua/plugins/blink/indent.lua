return {
  "saghen/blink.indent",
  event = "VeryLazy",
  opts = {
    blocked = {
      -- default: 'terminal', 'quickfix', 'nofile', 'prompt'
      buftypes = { include_defaults = true },
      -- default: 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'gitcommit', 'dashboard', ''
      filetypes = { include_defaults = true },
    },
    static = {
      enabled = false,
      char = "▎",
      priority = 1,
      highlights = {
        "BlinkIndentRed",
        "BlinkIndentOrange",
        "BlinkIndentYellow",
        "BlinkIndentGreen",
        "BlinkIndentCyan",
        "BlinkIndentBlue",
        "BlinkIndentViolet",
      },
    },
    scope = {
      enabled = true,
      char = "║",
      -- char = "┊",
      priority = 1000,
      highlights = {
        "BlinkIndentRed",
        "BlinkIndentOrange",
        "BlinkIndentYellow",
        "BlinkIndentGreen",
        "BlinkIndentCyan",
        "BlinkIndentBlue",
        "BlinkIndentViolet",
      },
      underline = {
        enabled = true,
        highlights = {
          "BlinkIndentRedUnderline",
          "BlinkIndentOrangeUnderline",
          "BlinkIndentYellowUnderline",
          "BlinkIndentGreenUnderline",
          "BlinkIndentCyanUnderline",
          "BlinkIndentBlueUnderline",
          "BlinkIndentVioletUnderline",
        },
      },
    },
  },
}
