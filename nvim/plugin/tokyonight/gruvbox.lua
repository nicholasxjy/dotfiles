return function(colors)
  -- Warm Gruvbox neutral ramp, from the deepest surface to primary text.
  colors.bg_dark1 = "#151515"
  colors.black = "#1D2021"
  colors.bg_dark = "#1F1F1F"
  colors.bg = "#282828"
  colors.border = "#3C3836"
  colors.bg_highlight = "#504945"
  colors.fg_gutter = "#665E58"
  colors.dark3 = "#7D736A"
  colors.comment = "#91857A"
  colors.dark5 = "#A09589"
  colors.fg_dark = "#C0B5A5"
  colors.fg = "#F1E6CA"
  colors.terminal_black = colors.dark3

  -- Vivid blue counterpoint with a monotonic lightness ramp.
  colors.blue = "#30AFFF"
  colors.blue0 = "#5CC1FF"
  colors.blue1 = "#85D0FF"
  colors.blue2 = "#ADE0FF"
  colors.blue5 = "#D6EFFF"
  colors.blue6 = "#E8F6FF"
  colors.blue7 = "#246A9C"

  -- Gruvbox-inspired accents share softer chroma and balanced perceived contrast.
  colors.red = "#F06A5A"
  colors.red1 = "#D84D42"
  colors.orange = "#E99542"
  colors.yellow = "#E6C54A"
  colors.green = "#C6CF4F"
  colors.green1 = "#93CC73"
  colors.green2 = "#6FA369"
  colors.teal = "#65AD91"
  colors.cyan = "#70D6CE"
  colors.magenta = "#BF91CE"
  colors.magenta2 = "#B76F99"
  colors.purple = "#E1A3B7"

  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.bg_dark
  colors.bg_sidebar = colors.bg_dark
  colors.bg_float = colors.bg
  colors.bg_visual = colors.bg_highlight
  colors.bg_search = "#7C6424"
  colors.fg_sidebar = colors.fg_dark
  colors.fg_float = colors.fg
  colors.border_highlight = colors.blue
  colors.error = colors.red
  colors.warning = colors.yellow
  colors.info = colors.blue2
  colors.hint = colors.teal
  colors.diff = {
    add = "#384224",
    change = "#243947",
    delete = "#442925",
    text = "#34536B",
  }
  colors.git = {
    add = colors.green,
    change = colors.blue,
    delete = colors.red,
    ignore = colors.comment,
  }
  colors.terminal = {
    black = colors.black,
    black_bright = colors.terminal_black,
    red = colors.red1,
    red_bright = colors.red,
    green = "#89933F",
    green_bright = colors.green,
    yellow = "#B79238",
    yellow_bright = colors.yellow,
    blue = colors.blue,
    blue_bright = colors.blue0,
    magenta = "#9D72AA",
    magenta_bright = colors.magenta,
    cyan = colors.teal,
    cyan_bright = colors.cyan,
    white = colors.fg_dark,
    white_bright = colors.fg,
  }
end
