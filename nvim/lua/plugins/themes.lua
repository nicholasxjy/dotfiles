return {
  {
    "nicholasxjy/bamboo.nvim",
    lazy = false,
    branch = "dev",
    priority = 1000,
    config = function()
      local palette = require("bamboo.palette").yorumi

      local float_border_color = "#3B38A0"
      local float_title_fg = "#D92C54"
      local match_fg = "#e55285"
      local normal_bg = vim.g.transparent and "none" or palette.bg0
      local dim_bg = vim.g.transparent and "none" or "#1a1926" --palette.bg1
      local float_border_fg = vim.g.transparent and float_border_color or normal_bg

      require("bamboo").setup({
        style = "yorumi",
        toggle_style_key = nil,
        transparent = vim.g.transparent,
        dim_inactive = false,
        term_colors = true,
        ending_tildes = true,
        cmp_itemkind_reverse = false,
        code_style = {
          comments = { italic = true },
          conditionals = { italic = true, bold = true },
          keywords = { italic = false, bold = false },
          functions = {},
          namespaces = { italic = false },
          parameters = { italic = true },
          strings = {},
          variables = {},
        },
        lualine = {
          transparent = true,
        },
        colors = {
          green = "#059669",
          orange = "#D97706",
          yellow = "#FBBF24",
          blue = "#3B82F6",
          red = "#DC2626",
        },
        highlights = {

          -- CursorLine = { bg = "#2f447f" },
          FloatTitle = { fg = float_title_fg, fmt = "bold" },
          NormalFloat = { bg = dim_bg, fg = "$fg" },
          FloatBorder = { bg = dim_bg, fg = float_border_fg },
          PmenuSel = { bg = "#2f2a7a", fg = "NONE", fmt = "bold" }, --#2f2a7a --"#2f447f" -- "#503240"
          Slimline = { bg = "NONE", fg = "$fg" },
          StatusLine = { bg = "NONE" },

          SnacksPickerBorder = { fg = float_border_fg, bg = normal_bg },
          SnacksPickerList = { bg = normal_bg },
          SnacksPickerTitle = { link = "FloatTitle" },
          SnacksPickerPreview = { bg = dim_bg },
          SnacksPickerPreviewTitle = { fg = "$cyan", bg = dim_bg, fmt = "bold" },
          SnacksPickerInput = { bg = normal_bg, fg = "$fg" },
          SnacksPickerMatch = { fg = match_fg, fmt = "bold" },
          -- SnacksPickerMatch = { link = "IncSearch" },
          SnacksPickerCursorLine = { link = "PmenuSel" },
          SnacksPickerListCursorLine = { link = "PmenuSel" },
          SnacksPickerDirectory = { fg = "$light_grey" },

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

          FzfLuaTitle = { link = "FloatTitle" },
          FzfLuaPreviewTitle = { link = "SnacksPickerPreviewTitle" },
          FzfLuaCursorLine = { link = "PmenuSel" },
          BlinkCmpLabelMatch = { fg = match_fg },

          LspInlayHint = { fg = "$grey", fmt = "italic" },
          Lensline = { fg = "#57564F", fmt = "italic" },
        },
        diagnostics = {
          darker = true,
          undercurl = true,
          background = true,
        },
      })
    end,
  },
}
