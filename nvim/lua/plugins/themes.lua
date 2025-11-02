local ui = require("core.ui")
local match_fg = "#EFBF04" --"#ff7f50" --"#F92772"
-- local blink_match_fg = "#77d507"

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
        conditionals = { italic = true, bold = true },
        keywords = { bold = false, italic = true },
        functions = { bold = true },
        namespaces = { italic = true },
        parameters = { italic = true },
        strings = {},
        variables = {},
        types = { bold = true },
      },

      lualine = {
        transparent = true, -- lualine center bar transparency
      },
      colors = {
        fg = "#dacfe4",
        bg0 = "#121212",
        bg1 = "#262626",
        red = "#B91C1C",
        green = "#059669",
        yellow = "#FBBF24",
        orange = "#F59E0B",
        blue = "#3B82F6",
        light_blue = "#6c67ea",
        cyan = "#1EA7A0",
        coral = "#DC2626",
        purple = "#ae81ef",
        rainbows = ui.rainbow_colors,
      }, -- Override default colors
      highlights = {
        ["@tag.attribute"] = { fg = "#b4b0e0", fmt = "italic" },
        ["@keyword.import"] = { fg = "#01d5f1", fmt = "bold" },
        ["@keyword.export"] = { fg = "#01d5f1", fmt = "bold" },
        ["@lsp.type.interface"] = { fg = "#99582a", fmt = "bold,italic" },
        ["@lsp.type.enum"] = { fg = "#9EC410", fmt = "bold" },
        ["@lsp.type.enumMember"] = { fg = "#BF9903", fmt = "italic" },
        ["@lsp.typemod.enum.readonly"] = { fg = "#9EC410", fmt = "bold" },
        ["@lsp.typemod.enumMember.readonly"] = { fg = "#BF9903", fmt = "italic" },
        ["@lsp.mod.readonly"] = { fg = "#D97706" },
        Comment = { fg = "#3f4060", fmt = "italic" },
        ["@comment"] = { fg = "#3f4060", fmt = "italic" },
        CursorLineNr = { fg = "$yellow", fmt = "bold" },
        PmenuSel = { bg = "#2f2a7a", fmt = "bold" }, --#2f2a7a --"#2f447f" -- "#503240"
        FloatBorder = { fg = "#3B38A0", bg = "none" },
        NormalFloat = { bg = vim.g.transparent and "none" or "$bg0" },
        FloatTitle = { fg = "#D92C54", fmt = "bold,italic" },
        MiniClueBorder = { link = "FloatBorder" },
        MiniClueDescGroup = { fg = "$yellow", fmt = "bold" },
        MiniClueTitle = { link = "FloatTitle" },
        MiniClueNextKey = { fg = "$coral", fmt = "bold" },
        MiniFilesBorder = { link = "FloatBorder" },
        MiniFilesNormal = { link = "NormalFloat" },
        MiniTablineCurrent = { fg = "$orange", bg = "$fg", fmt = "bold,underline" },
        MiniTablineFill = { bg = "$bg0" },
        MiniTablineHidden = { fg = "$light_grey", bg = "$bg0" },

        BlinkCmpLabelMatch = { fg = match_fg, fmt = "bold" },

        SnacksPickerTitle = { link = "FloatTitle" },
        SnacksPickerList = { bg = vim.g.transparent and "none" or "$bg0" },
        SnacksPickerPreview = { bg = vim.g.transparent and "none" or "$bg0" },
        SnacksPickerInput = { bg = vim.g.transparent and "none" or "$bg0" },
        SnacksPickerInputBorder = { fg = "#3B38A0" },
        SnacksPickerBorder = { fg = "#3B38A0", bg = "none" },
        SnacksPickerPreviewTitle = { fg = "$cyan", fmt = "bold,italic" },
        SnacksPickerMatch = { fg = match_fg, fmt = "bold,underline" },
        SnacksPickerCursorLine = { link = "PmenuSel" },
        SnacksPickerListCursorLine = { link = "PmenuSel" },
        SnacksPickerDir = { fg = "#616686", fmt = "italic,bold" },

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
}
