local function build_gruvbox(colors)
  colors.bg = "#32302f"
  colors.bg_dark = "#282828"
  colors.bg_dark1 = "#1d2021"
  colors.bg_highlight = "#3c3836"
  -- Extend Gruvbox's blue and aqua ramps so every TokyoNight semantic slot stays distinct.
  colors.blue = "#83a598"
  colors.blue0 = "#458588"
  colors.blue1 = "#8ab39a"
  colors.blue2 = "#6f9f8b"
  colors.blue5 = "#96afa4"
  colors.blue6 = "#a8bba9"
  colors.blue7 = "#3f6665"
  colors.comment = "#928374"
  colors.cyan = "#7fb5a3"
  colors.dark3 = "#665c54"
  colors.dark5 = "#7c6f64"
  colors.fg = "#ebdbb2"
  colors.fg_dark = "#a89984"
  colors.fg_gutter = "#504945"
  colors.green = "#b8bb26"
  colors.green1 = "#a9b665"
  colors.green2 = "#78965e"
  colors.magenta = "#d3869b"
  colors.magenta2 = "#c76f91"
  colors.orange = "#fe8019"
  colors.purple = "#a06f9c"
  colors.red = "#fb4934"
  colors.red1 = "#cc241d"
  colors.teal = "#5f9f85"
  colors.terminal_black = "#5b534d"
  colors.yellow = "#fabd2f"

  colors.black = "#181a1b"
  colors.border = "#554d46"
  colors.border_highlight = "#9c8b7a"
  colors.bg_popup = "#292725"
  colors.bg_statusline = "#2c2927"
  colors.bg_sidebar = "#262422"
  -- colors.bg_float = "#35312f"
  colors.bg_float = colors.bg

  colors.bg_visual = "#45403d"
  colors.bg_search = "#3f777b"
  colors.fg_sidebar = "#a39582"
  colors.fg_float = "#e4d4ad"
  colors.error = "#e44535"
  colors.todo = "#d99a28"
  colors.warning = "#e8b334"
  colors.info = "#75a092"
  colors.hint = "#68a28a"
  colors.diff = {
    add = "#32361a",
    change = "#0d3138",
    delete = "#3c1f1e",
    text = "#2e3b3b",
  }
  colors.git = {
    add = "#9faa22",
    change = "#6f9790",
    delete = "#dc3b2f",
    ignore = "#88796c",
  }
  colors.rainbow = {
    "#88a79b",
    "#f2b934",
    "#b0b62d",
    "#67a58c",
    "#cf8299",
    "#ad688b",
    "#f27b22",
    "#f14d3d",
  }
  colors.terminal = {
    black = "#202221",
    black_bright = "#62594f",
    red = "#c93428",
    red_bright = "#ff5945",
    green = "#98971a",
    green_bright = "#c1c53a",
    yellow = "#d79921",
    yellow_bright = "#ffc13a",
    blue = "#45807f",
    blue_bright = "#8eaaa0",
    magenta = "#ad5d81",
    magenta_bright = "#dd91a4",
    cyan = "#679b78",
    cyan_bright = "#93c38b",
    white = "#b4a58f",
    white_bright = "#f2e5bc",
  }
end

return build_gruvbox
