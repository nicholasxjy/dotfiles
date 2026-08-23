local function build_mocha(colors)
  -- Catppuccin Mocha palette: https://github.com/catppuccin/catppuccin
  -- colors.bg = "#1e1e2e" -- base
  -- colors.bg_dark = "#181825" -- mantle
  -- colors.bg_dark1 = "#11111b" -- crust
  -- colors.bg_highlight = "#313244" -- surface0

  colors.bg = "#303446"
  colors.bg_dark = "#292c3c"
  colors.bg_dark1 = "#232634"
  colors.bg_highlight = "#414559"

  colors.blue = "#89b4fa" -- blue
  -- TokyoNight's numbered blue slots have no direct Catppuccin names. Keep
  -- them in the same cool range while preserving contrast between slots.
  colors.blue0 = "#4f73b4"
  colors.blue1 = "#74c7ec" -- sapphire
  colors.blue2 = "#6fb7c5"
  colors.blue5 = "#b4befe" -- lavender
  colors.blue6 = "#c3d0f5"
  colors.blue7 = "#585b70" -- surface2

  colors.comment = "#9399b2" -- overlay2
  colors.dark3 = "#7f849c" -- overlay1
  colors.dark5 = "#a6adc8" -- subtext0
  colors.fg = "#cdd6f4" -- text
  colors.fg_dark = "#adb6d0"
  colors.fg_gutter = "#45475a" -- surface1

  colors.green = "#a6e3a1" -- green
  colors.green1 = "#9ED3DC"
  colors.green2 = "#4f9d78"
  colors.magenta = "#cba6f7" -- mauve
  colors.magenta2 = "#f5c2e7" -- pink
  colors.purple = "#9587e8"
  colors.red = "#f38ba8" -- red
  colors.red1 = "#eba0ac" -- maroon
  colors.yellow = "#f9e2af" -- yellow
  colors.orange = "#fab387" -- peach
  colors.cyan = "#89dceb" -- sky
  colors.teal = "#94e2d5" -- teal
  colors.terminal_black = "#3d3f57"

  colors.black = "#202030"
  colors.border = colors.fg_gutter
  colors.border_highlight = colors.purple
  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.bg_dark
  colors.bg_sidebar = colors.bg_dark
  colors.bg_float = colors.bg
  colors.bg_visual = "#41466b"
  colors.bg_search = colors.blue0
  colors.fg_sidebar = colors.fg_dark
  colors.fg_float = colors.fg
  colors.error = colors.red
  colors.warning = colors.yellow
  colors.info = colors.blue1
  colors.hint = colors.teal
  colors.diff = {
    add = "#304b3b",
    change = colors.bg_highlight,
    delete = "#573640",
    text = colors.blue7,
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
    red = colors.red,
    red_bright = "#f6a9bb",
    green = colors.green,
    green_bright = colors.green1,
    yellow = colors.yellow,
    yellow_bright = "#fbe8bc",
    blue = colors.blue,
    blue_bright = "#a8c8ff",
    magenta = colors.magenta2,
    magenta_bright = "#f8d4ec",
    cyan = colors.cyan,
    cyan_bright = "#a2e6e2",
    white = colors.fg_dark,
    white_bright = colors.fg,
  }
end

return build_mocha
