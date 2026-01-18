local colors = {
  black = "#000000",
  dark_gray = "#161616",
  gray = "#212121",
  light_gray = "#565656",
  darker_white = "#808080",
  dark_white = "#cacaca",
  white = "#f0f0f0",
  red = "#ed505e",

  dark_green = "#0b1b10",
  lime = "#2ed592",
  green = "#2ed563",
  dark_yellow = "#1d190d",
  orange = "#fa8a49",
  yellow = "#f0be42",
  blue = "#5088ed",
  pink = "#f45ab4",
  dark_cyan = "#0c1918",
  cyan = "#37c3b5",
  light_cyan = "#6ad8ed",

  lavender = "#9C5FEB",

  ts_operator = "#4D4A1B",
  ts_delimiter = "#807C37",
  ts_comment = "#4D5566",

  syn_keyword = "#736FDF",
  syn_import = "#60B5FF",
  syn_interface = "#B37800",
  syn_property = "#BCBDF5",
  syn_parameter = "#FD8A6B",
  syn_builtin = "#FF8080",
  syn_modifier = "#6AECE1",

  syn_enum = "#33CCCC",
  syn_enum_member = "#94E97C",

  blink_source = "#4D4D66",
}
return {
  "nicholasxjy/Lemons.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    colors_override = colors,
    undercurl = true,       -- Use undercurl instead of underline
    terminal_colors = true, -- Set terminal colors
    italic_comments = true, -- Italicize comments
    lighter_float = false,  -- Use ligher color for floating window background
  },
}
