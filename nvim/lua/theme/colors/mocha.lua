-- Catppuccin Mocha accents on Frappe surfaces: https://github.com/catppuccin/catppuccin
local function build_mocha(colors)
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
  colors.blue0 = "#445a8c" -- search background; keeps light text above AA contrast
  colors.blue1 = "#74c7ec" -- sapphire
  colors.blue2 = "#6fb7c5"
  colors.blue5 = "#b4befe" -- lavender
  colors.blue6 = "#c3d0f5"
  colors.blue7 = "#585b70" -- surface2

  colors.comment = "#a5adce" -- subtext0
  colors.dark3 = "#838ba7" -- overlay1
  colors.dark5 = "#b5bfe2" -- subtext1
  colors.fg = "#cdd6f4" -- text
  colors.fg_dark = "#adb6d0"
  colors.fg_gutter = "#737994" -- overlay0; visible secondary UI without competing with text

  colors.green = "#a6e3a1" -- green
  colors.green1 = "#9ED3DC"
  colors.green2 = "#64ac85"
  colors.magenta = "#cba6f7" -- mauve
  colors.magenta2 = "#f5c2e7" -- pink
  colors.purple = "#a99df5"
  colors.red = "#f38ba8" -- red
  colors.red1 = "#eba0ac" -- maroon
  colors.yellow = "#f9e2af" -- yellow
  colors.orange = "#fab387" -- peach
  colors.cyan = "#89dceb" -- sky
  colors.teal = "#94e2d5" -- teal
  colors.terminal_black = "#626880" -- subdued UI text and inline-code backgrounds

  colors.black = "#202030"
  colors.border = colors.dark3
  colors.border_highlight = colors.purple
  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.bg_dark
  colors.bg_sidebar = colors.bg_dark
  colors.bg_float = colors.bg_dark
  colors.bg_visual = "#41466b"
  colors.bg_search = colors.blue0
  colors.fg_sidebar = colors.fg_dark
  colors.fg_float = colors.fg
  colors.error = "#f6a9bb"
  colors.todo = colors.orange
  colors.warning = "#fbe8bc"
  colors.info = "#a8c8ff"
  colors.hint = "#a2e6e2"
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
    black_bright = colors.terminal_black,
    red = colors.red,
    red_bright = colors.error,
    green = colors.green,
    green_bright = colors.green1,
    yellow = colors.yellow,
    yellow_bright = colors.warning,
    blue = colors.blue,
    blue_bright = colors.info,
    magenta = colors.magenta,
    magenta_bright = colors.magenta2,
    cyan = colors.cyan,
    cyan_bright = colors.hint,
    white = colors.fg_dark,
    white_bright = colors.fg,
  }
end

return build_mocha
