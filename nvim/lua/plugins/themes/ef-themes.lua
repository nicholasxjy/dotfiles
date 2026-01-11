return {
  "oonamo/ef-themes.nvim",
  opts = {
    light = "ef-spring", -- Ef-theme to select for light backgrounds
    dark = "ef-night", -- Ef-theme to select for dark backgrounds
    transparent = vim.g.transparent,
    styles = {
      comments = { italic = true },
      keywords = { bold = false },
      functions = {},
      variables = {},
      classes = { bold = true },
      types = { bold = true },

      diagnostic = "full", -- Can be "full"
      pickers = "default", -- Can be "borderless"
    },

    modules = {
      blink = true,
      fzf = true,
      mini = true,
      semantic_tokens = true,
      snacks = true,
      treesitter = true,
      gitsigns = true,
      which_key = true,
      render_markdown = true,
    },

    on_colors = function(colors)
      -- colors.bg_main = "#18252A" -- "#101825"
      -- colors.bg_dim = "#1A2D33" -- "#1A283F"
      -- colors.bg_alt = "#172328" -- "#0F1522"
      -- -- colors.bg_active = "#534A3F"
      -- colors.bg_inactive = "#2A3F46" --"#22385C"

      colors.fg_main = "#E8E5DA"
      colors.fg_dim = "#636363"
      colors.fg_alt = "#EDE8AF"
    end,

    on_highlights = function(_, colors, _)
      return {
        NormalFloat = { bg = colors.bg_main },
        -- PmenuSel = { bg = "#335668" }, --#2B4A46 --#5A3824 --#5A324B --#335668
        Comment = { fg = "#8A7663", italic = true },
        MatchParenCur = { fg = "#F4E36B", bg = "#5A3824", bold = true },
        MatchParen = { fg = "#F17D62", bg = "#5A3824", bold = true },
        BlinkPairsMatchParen = { link = "MatchParen" },

        DiagnosticDeprecated = { bg = colors.bg_info, sp = colors.info, strikethrough = true },
        WhichKeyNormal = { bg = colors.bg_main },

        DartVisible = { fg = colors.fg_dim },
        DartVisibleLabel = { fg = colors.fg_dim },
        MiniTablineFill = { bg = colors.bg_main },
        MiniTablineCurrent = { fg = colors.fg_alt, bg = colors.bg_info, bold = true },
        MiniTablineHidden = { fg = colors.fg_dim, bg = colors.bg_main },
        MiniTablineModifiedCurrent = { fg = colors.warning, bg = colors.bg_warning, bold = true },

        lessClass = { fg = colors.accent_0 },
        ["@operator"] = { fg = "#4D4D66", bold = false },
        ["@punctuation.delimiter"] = { fg = "#4D5566", bold = false },
        -- Include = { fg = "#1CA0FD" }, --"#7FBB82"
        ["@keyword.import"] = { fg = "#34CB7D", bold = true },
        ["@keyword.export"] = { fg = "#34CB7D", bold = true },
        -- ["@lsp.type.namespace"] = { link = "@module" },
        ["@lsp.type.interface"] = { fg = "#B37800", bold = true },
        ["@lsp.type.enum"] = { fg = "#33CCCC", bold = true, italic = false },
        ["@lsp.type.enumMember"] = { fg = "#61BB4D", bold = true, italic = false },
        ["@lsp.typemod.enum"] = { fg = "#33CCCC", bold = true, italic = false },
        ["@lsp.typemod.enumMember"] = { fg = "#61BB4D", bold = true, italic = false },
        FloatTitle = { fg = "#ED7777", bold = true },
        FloatBorder = { fg = colors.accent_0, bg = colors.bg_main },

        SnacksPickerTitle = { link = "FloatTitle" },
        SnacksPickerInputTitle = { fg = "#94E97C", bold = true },
        SnacksPickerPreviewTitle = { fg = "#3AACFD", bold = true },
        SnacksPickerPreview = { bg = colors.bg_main },
        SnacksPickerInputBorder = { fg = colors.accent_2, bg = colors.bg_main },

        FzfLuaTitle = { link = "FloatTitle" },
        FzfLuaPreviewTitle = { link = "SnacksPickerPreviewTitle" },
        SnacksPickerMatch = { fg = colors.accent_0, bold = true, reverse = true },

        BlinkCmpSource = { fg = colors.fg_dim, bold = true },
        BlinkCmpMenu = { bg = colors.bg_main },
        BlinkCmpMenuBorder = { fg = colors.accent_0, bg = colors.bg_main },
        BlinkCmpDoc = { link = "BlinkCmpMenu" },
        BlinkCmpDocBorder = { link = "BlinkCmpMenuBorder" },
        BlinkCmpSignatureHelp = { link = "BlinkCmpMenu" },
        BlinkCmpSignatureHelpBorder = { link = "BlinkCmpMenuBorder" },
        BlinkCmpKindProperty = { fg = "#D5CAB9" },
        BlinkCmpKindText = { fg = "#8890A5" },
        BlinkCmpKindSnippet = { fg = "#736FDF", italic = true },

        NoiceCmdlinePopupBorder = { link = "FloatBorder" },
        NoiceCmdlinePopupBorderSearch = { link = "FloatBorder" },

        BlinkPairsRed = { link = "RainbowDelimiterRed" },
        BlinkPairsOrange = { link = "RainbowDelimiterOrange" },
        BlinkPairsYellow = { link = "RainbowDelimiterYellow" },
        BlinkPairsGreen = { link = "RainbowDelimiterGreen" },
        BlinkPairsCyan = { link = "RainbowDelimiterCyan" },
        BlinkPairsBlue = { link = "RainbowDelimiterBlue" },
        BlinkPairsViolet = { link = "RainbowDelimiterViolet" },

        BlinkIndentRed = { link = "RainbowDelimiterRed" },
        BlinkIndentOrange = { link = "RainbowDelimiterOrange" },
        BlinkIndentYellow = { link = "RainbowDelimiterYellow" },
        BlinkIndentGreen = { link = "RainbowDelimiterGreen" },
        BlinkIndentCyan = { link = "RainbowDelimiterCyan" },
        BlinkIndentBlue = { link = "RainbowDelimiterBlue" },
        BlinkIndentViolet = { link = "RainbowDelimiterViolet" },

        BlinkIndentRedUnderline = { link = "RainbowDelimiterRed" },
        BlinkIndentOrangeUnderline = { link = "RainbowDelimiterOrange" },
        BlinkIndentYellowUnderline = { link = "RainbowDelimiterYellow" },
        BlinkIndentGreenUnderline = { link = "RainbowDelimiterGreen" },
        BlinkIndentCyanUnderline = { link = "RainbowDelimiterCyan" },
        BlinkIndentBlueUnderline = { link = "RainbowDelimiterBlue" },
        BlinkIndentVioletUnderline = { link = "RainbowDelimiterViolet" },

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

        SnacksIndentChunkRed = { link = "RainbowDelimiterRed" },
        SnacksIndentChunkOrange = { link = "RainbowDelimiterOrange" },
        SnacksIndentChunkYellow = { link = "RainbowDelimiterYellow" },
        SnacksIndentChunkGreen = { link = "RainbowDelimiterGreen" },
        SnacksIndentChunkCyan = { link = "RainbowDelimiterCyan" },
        SnacksIndentChunkBlue = { link = "RainbowDelimiterBlue" },
        SnacksIndentChunkViolet = { link = "RainbowDelimiterViolet" },
      }
    end,

    options = {
      compile = true,
      compile_path = vim.fn.stdpath("cache") .. "/ef-themes",
    },
  },
}
