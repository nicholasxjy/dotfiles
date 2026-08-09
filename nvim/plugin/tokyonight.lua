local function finalize_palette(colors)
  local util = require("tokyonight.util")
  local function muted(color)
    return util.blend(color, 0.7, colors.bg)
  end

  colors.todo = colors.blue
  colors.rainbow = {
    muted(colors.blue),
    muted(colors.yellow),
    muted(colors.green),
    muted(colors.teal),
    muted(colors.magenta),
    muted(colors.purple),
    muted(colors.orange),
    muted(colors.red),
  }

  -- TokyoNight derives blended highlights after on_colors, so keep its blend base in sync.
  util.bg = colors.bg
  util.fg = colors.fg
end

local palette = "catppuccin" -- "gruvbox" or "tokyonight"
local palette_path = ("%s/plugin/tokyonight/%s.lua"):format(vim.fn.stdpath("config"), palette)
local build_palette = assert(loadfile(palette_path))()

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
  lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

  on_colors = function(colors)
    build_palette(colors)
    finalize_palette(colors)
  end,
  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights table<string, any>
  ---@param colors table<string, any>
  on_highlights = function(highlights, colors)
    highlights["FloatBorder"] = { fg = colors.blue0, bg = colors.bg_float }
    highlights["LspInlayHint"] = { fg = colors.dark3, bg = Util.blend(colors.blue7, 0.1, colors.bg) }
    highlights["@keyword.import"] = { fg = colors.teal, italic = false }
    highlights["@keyword.export"] = { link = "@keyword.import" }
    highlights["@tag.tsx"] = { fg = colors.red, bold = true }
    highlights["@tag.attribute"] = { fg = colors.blue2, italic = true }
    highlights["@lsp.type.interface"] = { fg = colors.yellow }
    highlights["@type.builtin"] = { fg = colors.red }

    highlights["SnacksPickerDir"] = { fg = colors.dark3, italic = false }
    highlights["SnacksPickerMatch"] = { fg = colors.red, bold = true }

    highlights["SnacksPickerPrompt"] = { fg = colors.magenta, bold = true }
    highlights["SnacksPickerPreviewBorder"] = { fg = colors.blue, bg = colors.bg_float }
    highlights["SnacksPickerListBorder"] = { fg = colors.green, bg = colors.bg_float }
    highlights["SnacksPickerInput"] = { fg = colors.fg, bold = true }

    highlights["FzfLuaDirPart"] = { link = "SnacksPickerDir" }
    highlights["FzfLuaBorder"] = { link = "FloatBorder" }
    highlights["FzfLuaPreviewBorder"] = { link = "SnacksPickerPreviewBorder" }

    highlights["BlinkCmpLabelDescription"] = { fg = colors.dark3, italic = false }
    highlights["BlinkCmpLabelDetail"] = { fg = colors.dark3, italic = false }

    highlights["BlinkCmpMenuBorder"] = { link = "FloatBorder" }
    highlights["BlinkCmpDocBorder"] = { fg = colors.green, bg = colors.bg_float }
    highlights["BlinkCmpSignatureHelpBorder"] = { fg = colors.yellow, bg = colors.bg_float }

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
