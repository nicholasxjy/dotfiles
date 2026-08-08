local function build_gruvbox_contrast(colors)
  colors.bg = "#242322"
  colors.bg_dark = "#151718"
  colors.bg_dark1 = "#0c0e0f"
  colors.bg_highlight = "#504943"
  -- Keep the blue ramp muted and warm while spreading its lightness for clearer separation.
  colors.blue = "#8db9eb"
  colors.blue0 = "#477fbd"
  colors.blue1 = "#c1daf0"
  colors.blue2 = "#65a7df"
  colors.blue5 = "#d9e9f5"
  colors.blue6 = "#f5f9fc"
  colors.blue7 = "#2c6498"
  colors.comment = "#b8a68e"
  colors.cyan = "#9bd7d2"
  colors.dark3 = "#8d7d70"
  colors.dark5 = "#a49380"
  colors.fg = "#f8edc7"
  colors.fg_dark = "#cbbca1"
  colors.fg_gutter = "#69605a"
  colors.green = "#d0d447"
  colors.green1 = "#c4e7b5"
  colors.green2 = "#88bd88"
  colors.magenta = "#ecaabe"
  colors.magenta2 = "#be6d9c"
  colors.orange = "#ffa33f"
  colors.purple = "#b187d4"
  colors.red = "#ff6b59"
  colors.red1 = "#e04639"
  colors.teal = "#68aa9a"
  colors.terminal_black = "#98877a"
  colors.yellow = "#ffd35c"

  colors.black = "#111314"
  colors.border = colors.fg_gutter
  colors.border_highlight = "#c5aa8b"
  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.bg_dark
  colors.bg_sidebar = colors.bg_dark
  colors.bg_float = colors.bg
  colors.bg_visual = "#4c684f"
  colors.bg_search = "#96751f"
  colors.fg_sidebar = colors.fg_dark
  colors.fg_float = colors.fg
  colors.error = colors.red
  colors.warning = colors.yellow
  colors.info = colors.blue2
  colors.hint = colors.teal
  colors.diff = {
    add = "#475a27",
    change = "#285755",
    delete = "#5d312c",
    text = colors.blue2,
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
    green = "#b3b326",
    green_bright = colors.green,
    yellow = "#e9ac31",
    yellow_bright = colors.yellow,
    blue = colors.blue0,
    blue_bright = colors.blue,
    magenta = colors.purple,
    magenta_bright = colors.magenta,
    cyan = colors.green2,
    cyan_bright = colors.cyan,
    white = colors.fg_dark,
    white_bright = colors.fg,
  }
end
local function build_gruvbox(colors)
  colors.bg = "#32302f"
  colors.bg_dark = "#1d2021"
  colors.bg_dark1 = "#141617"
  colors.bg_highlight = "#3c3836"
  -- Blue shades share a muted hue while keeping stronger contrast across TokyoNight's slots.
  colors.blue = "#729eca"
  colors.blue0 = "#366ba1"
  colors.blue1 = "#a1bdd9"
  colors.blue2 = "#4f8ac4"
  colors.blue5 = "#bcd1e6"
  colors.blue6 = "#d9e6f2"
  colors.blue7 = "#1b4d7e"
  colors.comment = "#928374"
  colors.cyan = "#7cc0c0"
  colors.dark3 = "#665c54"
  colors.dark5 = "#7c6f64"
  colors.fg = "#ebdbb2"
  colors.fg_dark = "#a89984"
  colors.fg_gutter = "#504945"
  colors.green = "#b8bb26"
  colors.green1 = "#acd49a"
  colors.green2 = "#689d6a"
  colors.magenta = "#B7B1F2"
  colors.magenta2 = "#924f79"
  colors.orange = "#fe8019"
  colors.purple = "#b16286"
  colors.red = "#fb4934"
  colors.red1 = "#cc241d"
  colors.teal = "#427b70"
  colors.terminal_black = "#74675e"
  colors.yellow = "#fabd2f"

  colors.black = "#1b1d2b"
  colors.border = colors.fg_gutter
  colors.border_highlight = "#a08e78"
  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.bg_dark
  colors.bg_sidebar = colors.bg_dark
  colors.bg_float = colors.bg
  colors.bg_visual = "#3b4b42"
  colors.bg_search = "#6b531c"
  colors.fg_sidebar = colors.fg_dark
  colors.fg_float = colors.fg
  colors.error = colors.red
  colors.warning = colors.yellow
  colors.info = colors.blue2
  colors.hint = colors.teal
  colors.diff = {
    add = "#35421e",
    change = "#1b3b3a",
    delete = "#432522",
    text = colors.blue2,
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
    green = "#98971a",
    green_bright = colors.green,
    yellow = "#d79921",
    yellow_bright = colors.yellow,
    blue = colors.blue0,
    blue_bright = colors.blue,
    magenta = colors.purple,
    magenta_bright = colors.magenta,
    cyan = colors.green2,
    cyan_bright = colors.cyan,
    white = colors.fg_dark,
    white_bright = colors.fg,
  }
end

local function build_tokyonight(colors)
  colors.bg = "#222436"
  colors.bg_dark = "#1e2030"
  colors.bg_dark1 = "#191b29"
  colors.bg_highlight = "#2f334d"
  colors.blue = "#00CAFF"
  -- Keep blue's HSLuv hue and saturation while spreading lightness for clearer contrast.
  colors.blue0 = "#007C9E"
  colors.blue1 = "#92DBFF"
  colors.blue2 = "#00A5D1"
  colors.blue5 = "#C7EAFF"
  colors.blue6 = "#EDF8FF"
  colors.blue7 = "#004D63"
  colors.comment = "#7a88cf"
  colors.dark3 = "#6873a6"
  colors.dark5 = "#8992bd"
  colors.fg = "#c8d3f5"
  colors.fg_dark = "#a9b4dc"
  colors.fg_gutter = "#545c7e"
  colors.green = "#6cce47"
  colors.green1 = "#5AAE3B"
  colors.green2 = "#44862B"
  colors.magenta = "#c099ff"
  colors.magenta2 = "#ff007c"
  colors.purple = "#fca7ea"
  colors.red1 = "#c53b53"
  colors.terminal_black = "#545c7e"
  colors.red = "#ef5849"
  colors.yellow = "#e8c300"
  colors.orange = "#e88b2d"
  colors.cyan = "#6FE6FC"
  colors.teal = "#769826"
  colors.black = colors.bg
  colors.border = colors.fg_gutter
  colors.border_highlight = "#589ed7"
  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.bg_dark
  colors.bg_sidebar = colors.bg_dark
  colors.bg_float = colors.bg
  colors.bg_visual = "#2d3f76"
  colors.bg_search = colors.blue0
  colors.fg_sidebar = colors.fg_dark
  colors.fg_float = colors.fg
  colors.error = colors.red
  colors.warning = colors.yellow
  colors.info = colors.blue
  colors.hint = colors.teal
  colors.diff = {
    add = "#2a4556",
    change = "#252a3f",
    delete = "#4b2a3d",
    text = colors.blue7,
  }
  colors.git = {
    add = "#b8db87",
    change = "#7ca1f2",
    delete = "#e26a75",
    ignore = colors.comment,
  }
  colors.terminal = {
    black = colors.black,
    black_bright = colors.comment,
    red = colors.red,
    red_bright = "#ff8d94",
    green = colors.green,
    green_bright = "#c7fb6d",
    yellow = colors.yellow,
    yellow_bright = "#ffd8ab",
    blue = colors.blue,
    blue_bright = "#9ab8ff",
    magenta = colors.magenta,
    magenta_bright = "#caabff",
    cyan = colors.cyan,
    cyan_bright = "#b2ebff",
    white = colors.fg_dark,
    white_bright = colors.fg,
  }
end

require("loader").packadd("tokyonight.nvim")

local Util = require("tokyonight.util")

require("tokyonight").setup({
  style = "moon", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
  light_style = "day", -- The theme is used when the background is set to light
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = false, bold = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "normal", -- style for floating windows
  },
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  on_colors = build_gruvbox_contrast,
  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights table<string, any>
  ---@param colors table<string, any>
  on_highlights = function(highlights, colors)
    highlights["FloatBorder"] = { fg = colors.magenta }
    highlights["LspInlayHint"] = { fg = colors.dark3, bg = Util.blend_bg(colors.bg, 0.6) }
    highlights["@keyword.import"] = { fg = "#80aa9e", italic = false }
    highlights["@keyword.export"] = { link = "@keyword.import" }
    highlights["@tag.tsx"] = { bold = true }
    highlights["@tag.attribute"] = { fg = colors.blue2, italic = true }
    highlights["@lsp.type.interface"] = { fg = colors.yellow }
    highlights["@type.builtin"] = { fg = colors.red1 }

    highlights["SnacksPickerDir"] = { fg = colors.dark3, bg = Util.blend_bg(colors.bg, 0.6), italic = false }
    highlights["SnacksPickerMatch"] = { fg = colors.red, bold = true }

    highlights["SnacksPickerPreviewBorder"] = { fg = colors.blue }
    highlights["SnacksPickerListBorder"] = { fg = colors.green }
    highlights["SnacksPickerInput"] = { fg = colors.red, bold = true }

    highlights["FzfLuaDirPart"] = { link = "SnacksPickerDir" }
    highlights["FzfLuaBorder"] = { link = "FloatBorder" }
    highlights["FzfLuaPreviewBorder"] = { link = "SnacksPickerPreviewBorder" }

    highlights["BlinkCmpLabelDescription"] = { fg = colors.dark3, bg = Util.blend_bg(colors.bg, 0.6), italic = false }
    highlights["BlinkCmpLabelDetail"] = { fg = colors.dark3, bg = Util.blend_bg(colors.bg, 0.6), italic = false }

    highlights["BlinkCmpMenuBorder"] = { link = "FloatBorder" }
    highlights["BlinkCmpDocBorder"] = { fg = colors.blue }
    highlights["BlinkCmpSignatureHelpBorder"] = { fg = colors.yellow }

    highlights["BlinkPairsBlue"] = { link = "RainbowDelimiterBlue" }
    highlights["BlinkPairsCyan"] = { link = "RainbowDelimiterCyan" }
    highlights["BlinkPairsGreen"] = { link = "RainbowDelimiterGreen" }
    highlights["BlinkPairsOrange"] = { link = "RainbowDelimiterOrange" }
    highlights["BlinkPairsRed"] = { link = "RainbowDelimiterRed" }
    highlights["BlinkPairsViolet"] = { link = "RainbowDelimiterViolet" }
    highlights["BlinkPairsYellow"] = { link = "RainbowDelimiterYellow" }

    highlights["BlinkIndentBlue"] = { link = "RainbowDelimiterBlue" }
    highlights["BlinkIndentCyan"] = { link = "RainbowDelimiterCyan" }
    highlights["BlinkIndentGreen"] = { link = "RainbowDelimiterGreen" }
    highlights["BlinkIndentOrange"] = { link = "RainbowDelimiterOrange" }
    highlights["BlinkIndentRed"] = { link = "RainbowDelimiterRed" }
    highlights["BlinkIndentViolet"] = { link = "RainbowDelimiterViolet" }
    highlights["BlinkIndentYellow"] = { link = "RainbowDelimiterYellow" }
  end,

  cache = true, -- When set to true, the theme will be cached for better performance

  ---@type table<string, boolean|{enabled:boolean}>
  plugins = {
    -- enable all plugins when not using lazy.nvim
    -- set to false to manually enable/disable plugins
    all = true,
    -- uses your plugin manager to automatically enable needed plugins
    -- currently only lazy.nvim is supported
    auto = true,
    -- add any plugins here that you want to enable
    -- for all possible plugins, see:
    --   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
    -- telescope = true,
  },
})

vim.cmd.colorscheme("tokyonight")
