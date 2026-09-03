-- Circadia Warm Ember & Obsidian: https://tanmaymanojgandhi.github.io/circadia/

local function build_circadia(colors)
  -- colors.bg = "#2d293a" -- bg_canvas
  -- colors.bg_dark = "#211d28" -- bg_surface
  -- colors.bg_dark1 = "#100f15" -- derived from bg_canvas
  -- colors.bg_highlight = "#15141b" -- bg_element

  -- colors.bg = "#1a1b26"
  -- colors.bg_dark = "#16161e"
  -- colors.bg_dark1 = "#0C0E14"
  -- colors.bg_highlight = "#2d293a"

  -- colors.bg = "#222436"
  -- colors.bg_dark = "#1e2030"
  -- colors.bg_dark1 = "#191B29"
  -- colors.bg_highlight = "#2f334d"

  colors.bg = "#24283b"
  colors.bg_dark = "#1f2335"
  colors.bg_dark1 = "#1b1e2d"
  colors.bg_highlight = "#292e42"

  -- colors.bg = "#1e1e2e"
  -- colors.bg_dark = "#181825"
  -- colors.bg_dark1 = "#11111b"
  -- colors.bg_highlight = "#313244"

  -- colors.bg = "#1e1e2e"
  -- colors.bg_dark = "#181825"
  -- colors.bg_dark1 = "#11111b"
  -- colors.bg_highlight = "#313244"

  -- colors.bg = "#24273a"
  -- colors.bg_dark = "#1e2030"
  -- colors.bg_dark1 = "#181926"
  -- colors.bg_highlight = "#363a4f"

  -- colors.bg = "#303446"
  -- colors.bg_dark = "#292c3c"
  -- colors.bg_dark1 = "#232634"
  -- colors.bg_highlight = "#414559"
  --
  colors.blue = "#91cee7" -- syntax.function
  colors.blue0 = "#835539" -- search background; keeps light text above AA contrast
  colors.blue1 = "#f2c08a" -- syntax.type
  colors.blue2 = "#e9a052" -- accent / syntax.tag
  colors.blue5 = "#f8cb94" -- headings.h1
  colors.blue6 = "#f3b875" -- headings.h2
  colors.blue7 = "#5f4d66" -- subdued diff and state background

  colors.comment = "#8f867c" -- syntax.comment
  colors.dark3 = "#a0968b" -- text_faint
  colors.dark5 = "#bdb2a7" -- text_muted
  colors.fg = "#eee7dc" -- text_primary
  colors.fg_dark = "#ada49a" -- derived from text_muted
  colors.fg_gutter = "#807580" -- secondary text; keeps the primary hierarchy

  colors.green = "#addd7c" -- syntax.string
  colors.green1 = "#bce6d1" -- string + cyan, brighter mint
  colors.green2 = "#629d7d" -- string + teal, darker emerald
  colors.magenta = "#e5a3e6" -- syntax.keyword
  colors.magenta2 = "#f1c1ed" -- brighter keyword shade
  colors.purple = "#9FA1FF" -- muted blue-purple, balanced for the warm palette
  colors.red = "#f08a75" -- derived warm error hue
  colors.red1 = "#df6b62" -- darker error hue
  colors.terminal_black = "#756b76" -- subdued UI text and inline-code backgrounds
  colors.yellow = "#f4b258" -- syntax.number
  colors.orange = "#dc8e3d" -- headings.h4
  colors.cyan = "#5FACD3" -- derived function hue
  colors.teal = "#79c5b7" -- cooler cyan-green blend

  -- colors.black = "#0e0d12"
  colors.black = "#202030"
  colors.border = "#756681" -- visible separator with 3:1+ contrast
  colors.border_highlight = colors.blue2
  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.bg_dark
  colors.bg_sidebar = colors.bg_dark
  colors.bg_float = colors.bg_dark
  colors.bg_visual = "#4d3a4b" -- distinct selection without washing out syntax
  colors.bg_search = colors.blue0
  colors.fg_sidebar = colors.fg_dark
  colors.fg_float = colors.fg
  colors.error = "#ff9b85"
  colors.todo = colors.orange
  colors.warning = "#ffd28d"
  colors.info = "#b7e9f5"
  colors.hint = "#9ed8cd"

  colors.diff = {
    add = "#304b38",
    change = "#4b3847",
    delete = "#5a303a",
    text = colors.blue7,
  }
  colors.git = {
    add = colors.green,
    change = colors.blue2,
    delete = colors.red1,
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
    red_bright = "#ff9b85",
    green = colors.green,
    green_bright = colors.green1,
    yellow = colors.yellow,
    yellow_bright = "#ffd28d",
    blue = colors.blue,
    blue_bright = "#b7e9f5",
    magenta = colors.magenta,
    magenta_bright = colors.magenta2,
    cyan = colors.cyan,
    cyan_bright = "#d0f0f3",
    white = colors.fg_dark,
    white_bright = colors.fg,
  }
end

return build_circadia
