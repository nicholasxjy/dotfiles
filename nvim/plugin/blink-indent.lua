require("blink.indent").setup({
  blocked = {
    -- default: 'terminal', 'quickfix', 'nofile', 'prompt'
    buftypes = { include_defaults = true },
    -- default: 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'gitcommit', 'dashboard', ''
    filetypes = { include_defaults = true, "fyler", "Fyler" },
  },
  static = {
    enabled = false,
    char = "▎",
    whitespace_char = nil, -- inherits from `vim.opt.listchars:get().space` when `nil` (see `:h listchars`)
    priority = 1,
    highlights = {
      "BlinkIndentRed",
      "BlinkIndentOrange",
      "BlinkIndentYellow",
      "BlinkIndentGreen",
      "BlinkIndentViolet",
      "BlinkIndentCyan",
    },
  },
  scope = {
    enabled = false,
    char = "▎",
    priority = 1000,
    highlights = {
      "BlinkIndentRed",
      "BlinkIndentCyan",
      "BlinkIndentYellow",
      "BlinkIndentGreen",
      "BlinkIndentOrange",
      "BlinkIndentViolet",
      "BlinkIndentBlue",
    },
    underline = {
      enabled = false,
      highlights = {
        "BlinkIndentRedUnderline",
        "BlinkIndentCyanUnderline",
        "BlinkIndentYellowUnderline",
        "BlinkIndentGreenUnderline",
        "BlinkIndentOrangeUnderline",
        "BlinkIndentVioletUnderline",
        "BlinkIndentBlueUnderline",
      },
    },
  },
})
