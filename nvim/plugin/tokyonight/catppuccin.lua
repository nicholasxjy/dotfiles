return function(colors)
  -- Catppuccin Mocha neutrals, ordered from Crust to Text.
  colors.bg_dark1 = "#11111B"
  colors.black = "#181825"
  colors.bg_dark = "#181825"
  colors.bg = "#1E1E2E"
  colors.bg_highlight = "#313244"
  colors.border = "#585B70"
  colors.fg_gutter = "#585B70"
  colors.dark3 = "#6C7086"
  colors.comment = "#9399B2"
  colors.dark5 = "#A6ADC8"
  colors.fg_dark = "#BAC2DE"
  colors.fg = "#CDD6F4"
  colors.terminal_black = colors.dark3

  -- Mocha's blue accents, extended at both ends for TokyoNight's extra blue roles.
  colors.blue = "#89B4FA"
  colors.blue0 = "#5F82C5"
  colors.blue1 = "#74C7EC"
  colors.blue2 = "#89DCEB"
  colors.blue5 = "#B4BEFE"
  colors.blue6 = "#D2E1FF"
  colors.blue7 = "#35466B"

  -- Direct Mocha accents, plus same-hue variants for TokyoNight's numbered roles.
  colors.red = "#F38BA8"
  colors.red1 = "#EBA0AC"
  colors.orange = "#FAB387"
  colors.yellow = "#F9E2AF"
  colors.green = "#A6E3A1"
  colors.green1 = "#7FCB7B"
  colors.green2 = "#5FAF68"
  colors.teal = "#94E2D5"
  colors.cyan = "#89DCEB"
  colors.magenta = "#F5C2E7"
  colors.magenta2 = "#D98BC6"
  colors.purple = "#CBA6F7"

  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.bg_dark
  colors.bg_sidebar = colors.bg_dark
  colors.bg_float = colors.bg
  colors.bg_visual = "#414D72"
  colors.bg_search = "#65512F"
  colors.fg_sidebar = colors.fg_dark
  colors.fg_float = colors.fg
  colors.border_highlight = colors.blue
  colors.error = colors.red
  colors.warning = colors.yellow
  colors.info = colors.blue2
  colors.hint = colors.teal
  colors.diff = {
    add = "#263A2C",
    change = "#283750",
    delete = "#442735",
    text = "#3B5275",
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
    green = "#78B978",
    green_bright = colors.green,
    yellow = "#C9AA70",
    yellow_bright = colors.yellow,
    blue = "#6F92CF",
    blue_bright = colors.blue,
    magenta = "#9F7BC4",
    magenta_bright = colors.magenta,
    cyan = "#69B0BC",
    cyan_bright = colors.cyan,
    white = colors.fg_dark,
    white_bright = colors.fg,
  }
end
