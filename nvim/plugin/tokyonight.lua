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

  colors.black = colors.bg
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
  colors.info = colors.blue
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
    black_bright = colors.comment,
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

-- local function build_tokyonight(colors)
--   colors.red = "#ef5849"
--   colors.green = "#6cce47"
--   colors.yellow = "#e8c300"
--   colors.orange = "#e88b2d"
--   colors.magenta = "#a07ae0"
--   colors.cyan = "#6FE6FC"
--   colors.teal = "#769826"
--   -- colors.blue1 = "#00E0BA" --"#4379F2" --"#006BFF"
--   colors.blue = "#00CAFF"
--   colors.green1 = "#26CCC2"
-- end

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

  on_colors = build_gruvbox,
  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights table<string, any>
  ---@param colors table<string, any>
  on_highlights = function(highlights, colors)
    highlights["FloatBorder"] = { fg = colors.cyan }
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
