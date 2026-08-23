local color_builders = require("theme.colors")

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
    floats = "dark", -- style for floating windows
  },
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  on_colors = color_builders.build_circadia,
  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights table<string, any>
  ---@param colors table<string, any>
  on_highlights = function(highlights, colors)
    -- `on_colors` replaces the palette after TokyoNight initializes `Util.bg`,
    -- so blend against the active palette explicitly instead of the stock one.
    local function blend_with_bg(color, amount)
      return Util.blend(color, amount, colors.bg)
    end

    -- Keep every floating UI on the same surface and border hierarchy.
    highlights.FloatBorder = { fg = colors.border_highlight, bg = colors.bg_float }
    highlights.LspInlayHint = { fg = colors.dark3, bg = blend_with_bg(colors.blue7, 0.1) }

    highlights["@keyword.import"] = { fg = colors.teal, italic = true }
    highlights["@keyword.export"] = { link = "@keyword.import" }
    highlights["@tag.tsx"] = { fg = colors.red, bold = true }
    highlights["@tag.attribute"] = { fg = colors.blue2, italic = true }

    -- Interfaces and builtin types keep TokyoNight's semantic type colors. Do
    -- not reuse the warning/error ramps for ordinary language constructs.

    highlights.SnacksPickerDir = { fg = colors.fg_dark, bg = blend_with_bg(colors.bg_dark1, 0.9) }
    highlights.SnacksPickerMatch = { fg = "#FB6C00", bg = nil, bold = true }
    highlights.SnacksPickerInput = { fg = colors.fg, bg = colors.bg_float }
    highlights.SnacksPickerPrompt = { fg = colors.orange, bold = true }
    highlights.SnacksPickerInputSearch = { fg = colors.blue1, bold = true }
    highlights.SnacksPickerPreviewBorder = { link = "FloatBorder" }
    highlights.SnacksPickerListBorder = { link = "FloatBorder" }
    highlights.SnacksPickerBoxBorder = { link = "FloatBorder" }

    highlights.FzfLuaDirPart = { link = "SnacksPickerDir" }
    highlights.FzfLuaBorder = { link = "FloatBorder" }
    highlights.FzfLuaPreviewBorder = { link = "FloatBorder" }

    highlights.BlinkCmpLabelDescription = { link = "NonText" }
    highlights.BlinkCmpLabelDetail = { link = "NonText" }
    highlights.BlinkCmpMenuBorder = { link = "FloatBorder" }
    highlights.BlinkCmpDocBorder = { link = "FloatBorder" }
    highlights.BlinkCmpSignatureHelpBorder = { link = "FloatBorder" }
    highlights.BlinkPairsUnmatched = { link = "DiagnosticError" }
    highlights.BlinkPairsMatchParen = { link = "MatchParen" }
    highlights.BlinkIndent = { link = "Whitespace" }
    highlights.BlinkIndentScope = { link = "Delimiter" }

    for _, name in ipairs({ "Blue", "Cyan", "Green", "Orange", "Red", "Violet", "Yellow" }) do
      local rainbow_group = "RainbowDelimiter" .. name
      highlights["BlinkPairs" .. name] = { link = rainbow_group }
      highlights["BlinkIndent" .. name] = { link = rainbow_group }
    end
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
