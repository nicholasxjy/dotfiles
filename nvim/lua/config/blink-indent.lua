require("blink.indent").setup({
  blocked = {
    buftypes = { include_defaults = true },
    filetypes = { include_defaults = true },
  },
  mappings = {
    -- which lines around the scope are included for 'ai': 'top', 'bottom', 'both', or 'none'
    border = "both",
    -- set to '' to disable
    -- textobjects (e.g. `y2ii` to yank current and outer scope)
    object_scope = "ii",
    object_scope_with_border = "ai",
    -- motions
    goto_top = "[i",
    goto_bottom = "]i",
  },
  static = {
    enabled = false,
    char = "▎",
    whitespace_char = nil, -- inherits from `vim.opt.listchars:get().space` when `nil` (see `:h listchars`)
    priority = 1,
    -- specify multiple highlights here for rainbow-style indent guides
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
    enabled = true, -- highlight highest level of indentation on the current line
    indent_at_cursor = true, -- clamp to indent level of cursor
    -- char = "▎",
    char = "│",
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
    -- enable to show underlines on the line above the current scope
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
