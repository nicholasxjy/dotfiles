return {
  "saghen/blink.indent",
  event = "VeryLazy",
  opts = {
    blocked = {
      -- default: 'terminal', 'quickfix', 'nofile', 'prompt'
      buftypes = { include_defaults = true },
      -- default: 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'gitcommit', 'dashboard', ''
      filetypes = {
        include_defaults = true,
        "snacks_picker_input",
        "snacks_picker_list",
        "snacks_picker_preview",
        "snacks_terminal",
        "mason",
        "lazy",
        "fzf",
        "oil",
      },
    },
    static = {
      enabled = true,
      -- char = "▎",
      -- char = "⋮",
      char = "",
      -- char = "┊",
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
