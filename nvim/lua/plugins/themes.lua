local ui = require("core.ui")
local match_fg = "#F92772" --"#EFBF04" --"#ff7f50" --

local float_border_fg = "#3B38A0"
local import_export_fg = "#2ed592" --"#01d5f1"

return {
  {
    "nicholasxjy/bamboo.nvim",
    lazy = false,
    priority = 1000,
    branch = "dev",
    opts = {
      style = "vulgaris", -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
      toggle_style_key = nil, -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
      toggle_style_list = { "vulgaris", "multiplex", "light" }, -- List of styles to toggle between
      transparent = vim.g.transparent, -- Show/hide background
      dim_inactive = false, -- Dim inactive windows/buffers
      term_colors = true, -- Change terminal color as per the selected theme style
      ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

      -- Change code style ---
      -- Options are anything that can be passed to the `vim.api.nvim_set_hl` table
      -- You can also configure styles with a string, e.g. keywords = 'italic,bold'
      code_style = {
        comments = { italic = true },
        conditionals = { italic = false, bold = false },
        keywords = { bold = false },
        functions = { bold = false },
        namespaces = { italic = true },
        parameters = { italic = false },
        strings = { bold = false },
        variables = {},
        types = { bold = true },
      },

      lualine = {
        transparent = false,
      },
      colors = {
        fg = "#f0f0f0", --"#dacfe4",
        bg0 = "#040404",
        bg1 = "#161616",
        red = "#ed505e", --"#B91C1C",
        green = "#2ED563",
        yellow = "#F0BE42", --"#FBBF24",
        orange = "#fa8a49", -- "#F59E0B",
        blue = "#5088ed", --"#10aef8", --"#3B82F6",
        light_blue = "#6AD8ED", --"#6c67ea",
        cyan = "#37C3B5", --"#56DFCF", --"#1aad16", --"#1EA7A0",
        coral = "#DC2626",
        purple = "#f45ab4", --"#ae81ef",
        rainbows = ui.rainbow_colors,
      }, -- Override default colors
      highlights = {
        ["@tag.attribute"] = { fg = "#b4b0e0", fmt = "italic" },
        ["@keyword.import"] = { fg = import_export_fg, fmt = "bold" },
        ["@keyword.export"] = { fg = import_export_fg, fmt = "bold" },
        ["@lsp.type.interface"] = { fg = "#99582a", fmt = "bold,italic" },
        ["@lsp.type.enum"] = { fg = "#9EC410", fmt = "bold" },
        ["@lsp.type.enumMember"] = { fg = "#BF9903", fmt = "italic" },
        ["@lsp.typemod.enum.readonly"] = { fg = "#9EC410", fmt = "bold" },
        ["@lsp.typemod.enumMember.readonly"] = { fg = "#BF9903", fmt = "italic" },

        Comment = { fg = "#565656", fmt = "italic" },
        ["@comment"] = { fg = "#565656", fmt = "italic" },
        CursorLineNr = { fg = "$yellow", fmt = "bold" },
        -- PmenuSel = { bg = "#2f2a7a", fmt = "bold" }, --#2f2a7a --"#2f447f" -- "#503240"
        PmenuSel = { fg = "$bg0", bg = "$yellow" },
        PmenuMatch = { fg = match_fg, fmt = "bold" },
        PmenuMatchSel = { fmt = "bold" },

        FloatBorder = { fg = float_border_fg, bg = "none" },
        NormalFloat = { bg = vim.g.transparent and "none" or "$bg0" },
        FloatTitle = { fg = "#D92C54", fmt = "bold,italic" },
        MiniClueBorder = { link = "FloatBorder" },
        MiniClueDescGroup = { fg = "$yellow", fmt = "bold" },
        MiniClueTitle = { link = "FloatTitle" },
        MiniClueNextKey = { fg = "$coral", fmt = "bold" },
        MiniFilesBorder = { link = "FloatBorder" },
        MiniFilesNormal = { link = "NormalFloat" },
        MiniTablineCurrent = { fg = "$orange", fmt = "bold,underline" },
        MiniTablineFill = { bg = "$bg0" },
        MiniTablineHidden = { fg = "$light_grey", bg = "$bg0" },

        BlinkCmpLabelMatch = { link = "PmenuMatch" },
        BlinkCmpMenuSelection = { link = "PmenuSel" },
        BlinkCmpScrollBarThumb = { link = "PmenuThumb" },
        BlinkCmpScrollBarGutter = { link = "PmenuSbar" },
        -- BlinkCmpLabelMatch = { fg = match_fg, fmt = "bold" },

        SnacksPickerTitle = { link = "FloatTitle" },
        SnacksPickerList = { bg = vim.g.transparent and "none" or "$bg0" },
        SnacksPickerPreview = { bg = vim.g.transparent and "none" or "$bg0" },
        SnacksPickerInput = { bg = vim.g.transparent and "none" or "$bg0" },
        SnacksPickerInputBorder = { fg = float_border_fg },
        SnacksPickerBorder = { fg = float_border_fg, bg = "none" },
        SnacksPickerPreviewTitle = { fg = "$cyan", fmt = "bold,italic" },
        SnacksPickerMatch = { fg = match_fg, fmt = "bold,underline" },
        SnacksPickerCursorLine = { link = "PmenuSel" },
        SnacksPickerListCursorLine = { link = "PmenuSel" },
        SnacksPickerDir = { fg = "#616686", fmt = "italic" },

        FzfLuaNormal = { link = "SnacksPickerList" },
        FzfLuaPreviewNormal = { link = "SnacksPickerPreview" },
        FzfLuaTitle = { link = "FloatTitle" },
        FzfLuaPreviewTitle = { link = "SnacksPickerPreviewTitle" },
        FzfLuaCursorLine = { link = "PmenuSel" },

        SnacksIndentChunkRed = { link = "RainbowDelimiterRed" },
        SnacksIndentChunkOrange = { link = "RainbowDelimiterOrange" },
        SnacksIndentChunkYellow = { link = "RainbowDelimiterYellow" },
        SnacksIndentChunkGreen = { link = "RainbowDelimiterGreen" },
        SnacksIndentChunkCyan = { link = "RainbowDelimiterCyan" },
        SnacksIndentChunkBlue = { link = "RainbowDelimiterBlue" },
        SnacksIndentChunkViolet = { link = "RainbowDelimiterViolet" },
        SnacksIndentRed = { link = "RainbowDelimiterRed" },
        SnacksIndentOrange = { link = "RainbowDelimiterOrange" },
        SnacksIndentYellow = { link = "RainbowDelimiterYellow" },
        SnacksIndentGreen = { link = "RainbowDelimiterGreen" },
        SnacksIndentCyan = { link = "RainbowDelimiterCyan" },
        SnacksIndentBlue = { link = "RainbowDelimiterBlue" },
        SnacksIndentViolet = { link = "RainbowDelimiterViolet" },
        SnacksIndentScopeRed = { link = "RainbowDelimiterRed" },
        SnacksIndentScopeOrange = { link = "RainbowDelimiterOrange" },
        SnacksIndentScopeYellow = { link = "RainbowDelimiterYellow" },
        SnacksIndentScopeGreen = { link = "RainbowDelimiterGreen" },
        SnacksIndentScopeCyan = { link = "RainbowDelimiterCyan" },
        SnacksIndentScopeBlue = { link = "RainbowDelimiterBlue" },
        SnacksIndentScopeViolet = { link = "RainbowDelimiterViolet" },
      }, -- Override highlight groups

      -- Plugins Config --
      diagnostics = {
        darker = false, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
    },
  },
  {
    "nicholasxjy/Lemons.nvim",
    branch = "dev",
    lazy = false,
  },
}
