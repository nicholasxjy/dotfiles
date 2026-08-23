-- Everforest Hard adapted for WCAG 2.1 AAA text contrast. Readable text and
-- syntax colors target 7:1; structural colors such as gutters target 3:1.
local function build_everforest(colors)
  colors.bg = "#272e33"
  colors.bg_dark = "#20282c"
  colors.bg_dark1 = "#192125"
  colors.bg_highlight = "#293236"

  -- Keep TokyoNight's overloaded blue slots semantically distinct: search
  -- backgrounds stay dark, while functions, types, and operators stay bright.
  colors.blue = "#a6ced2"
  colors.blue0 = "#273a42"
  colors.blue1 = "#a8cfe0"
  colors.blue2 = "#9fcdd2"
  colors.blue5 = "#bed0cf"
  colors.blue6 = "#bad9c8"
  colors.blue7 = "#2d4248"

  colors.comment = "#bec8c0"
  colors.cyan = "#a8cfd7"
  colors.dark3 = "#bcc6be"
  colors.dark5 = "#c8d0c8"
  colors.fg = "#e2d8c2"
  colors.fg_dark = "#c8cabd"
  colors.fg_gutter = "#74817b"
  colors.green = "#b8d59b"
  colors.green1 = "#a7d6b3"
  colors.green2 = "#abd0b8"
  colors.magenta = "#e2b5ce"
  colors.magenta2 = "#efb1cc"
  colors.orange = "#f0b89d"
  colors.purple = "#ceb9e0"
  colors.red = "#efb2b3"
  colors.red1 = "#e8b8b2"
  colors.teal = "#a0d2cd"
  colors.terminal_black = "#26312f"
  colors.yellow = "#e2c58e"

  colors.black = "#141a1d"
  colors.border = "#74817b"
  colors.border_highlight = "#b7d2ca"
  colors.bg_popup = "#20282c"
  colors.bg_statusline = "#1e262a"
  colors.bg_sidebar = "#222a2e"
  colors.bg_float = "#20282c"
  colors.bg_visual = "#352a33"
  colors.bg_search = colors.blue0
  colors.fg_sidebar = "#cbd0c2"
  colors.fg_float = colors.fg

  colors.error = "#f2b7b7"
  colors.todo = "#edc497"
  colors.warning = colors.yellow
  colors.info = "#a6cfd6"
  colors.hint = "#a8d5b0"

  -- Low-luminance state backgrounds preserve inherited syntax foregrounds.
  colors.diff = {
    add = "#26332b",
    change = "#263337",
    delete = "#35282c",
    text = "#283438",
  }
  colors.git = {
    add = "#b7d39b",
    change = colors.blue,
    delete = "#edb2b0",
    ignore = colors.comment,
  }
  colors.rainbow = {
    colors.blue,
    colors.yellow,
    colors.green,
    colors.teal,
    colors.magenta,
    colors.purple,
    colors.orange,
    colors.red,
  }
  colors.terminal = {
    black = colors.black,
    black_bright = "#bdc7bf",
    red = colors.red,
    red_bright = "#fac6c6",
    green = colors.green,
    green_bright = "#c9e3ae",
    yellow = colors.yellow,
    yellow_bright = "#f2d8a5",
    blue = colors.blue,
    blue_bright = "#bddde0",
    magenta = colors.magenta,
    magenta_bright = "#f2c8dc",
    cyan = colors.teal,
    cyan_bright = "#bce2dd",
    white = colors.fg_dark,
    white_bright = colors.fg,
  }
end

return build_everforest
