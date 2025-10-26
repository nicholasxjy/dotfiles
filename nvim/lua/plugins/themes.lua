local ui = require("core.ui")

return {
  {
    "nicholasxjy/bamboo.nvim",
    lazy = false,
    priority = 1000,
    branch = "dev",
    opts = {
      style = "multiplex", -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
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
        keywords = { bold = true, italic = true },
        functions = {},
        namespaces = { italic = true },
        parameters = { italic = true },
        strings = {},
        variables = {},
        types = { bold = true },
      },

      lualine = {
        transparent = true, -- lualine center bar transparency
      },

      -- Custom Highlights --
      colors = {
        rainbows = ui.rainbow_colors,
      }, -- Override default colors
      highlights = {
        CursorLineNr = { fg = "$yellow", fmt = "bold" },
        PmenuSel = { bg = "#2f2a7a", fmt = "bold" }, --#2f2a7a --"#2f447f" -- "#503240"
        FloatBorder = { fg = vim.g.transparent and "#3B38A0" or "none" },
        FloatTitle = { fg = "#D92C54", fmt = "bold,italic" },
        SnacksPickerTitle = { link = "FloatTitle" },
        SnacksPickerList = { bg = vim.g.transparent and "none" or "$bg0" },
        SnacksPickerPreview = { bg = vim.g.transparent and "none" or "$bg0" },
        SnacksPickerInput = { bg = vim.g.transparent and "none" or "$bg0" },
        SnacksPickerInputBorder = { fg = "#3B38A0" },
        SnacksPickerBorder = { fg = vim.g.transparent and "#3B38A0" or "$bg0" },
        SnacksPickerPreviewTitle = { fg = "$cyan", fmt = "bold,italic" },
        SnacksPickerMatch = { fg = "$orange", fmt = "italic,bold,underline" },
        SnacksPickerCursorLine = { link = "PmenuSel" },
        SnacksPickerListCursorLine = { link = "PmenuSel" },
        SnacksPickerDir = { fg = "$light_grey", fmt = "italic" },

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
    "rebelot/kanagawa.nvim",
    opts = {
      compile = false, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors) -- add/modify highlights
        -- local theme = colors.theme
        return {
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
        }
      end,
      theme = "wave", -- Load "wave" theme
      background = { -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus",
      },
    },
  },
}
