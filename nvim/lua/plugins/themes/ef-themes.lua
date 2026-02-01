return {
  "oonamo/ef-themes.nvim",
  opts = {
    light = "ef-trio-light",
    dark = "ef-autumn",
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
      -- colors.bg_main = "#333c43"
      -- colors.bg_alt = "#3a464c"
      -- colors.bg_dim = "#434f55"
      -- colors.bg_inactive = "#555f66"
      -- colors.fg_main = "#d3c6aa"
      -- colors.fg_dim = "#7a8478"
      -- colors.fg_comment = "#A39B8E"
      -- colors.bg_hl_line = "#48584e" --"#59464c" "#48584e" "#3f5865" "#55544a" "#4e4953"
      -- colors.bg_completion = "#55544a"
      -- colors.bg_match = "#3c4841" --"#493b40" "#3c4841" "#384b55"  "#45443c" "#463f48"
      -- colors.rm_code = "#293136"

      -- colors.bg_main = "#272e33"
      -- colors.bg_alt = "#2e383c"
      -- colors.bg_dim = "#374145"
      -- colors.bg_inactive = "#4f5b58"
      -- colors.fg_main = "#d3c6aa"
      -- colors.fg_dim = "#7a8478"
      -- colors.fg_comment = "#A39B8E"
      -- colors.bg_hl_line = "#3c4841" --"#493b40" "#3c4841" "#384b55"  "#45443c" "#463f48"
      -- colors.bg_completion = "#4c3743"
      -- colors.bg_match = "#425047" --"#514045" "#425047" "#3a515d" "#4d4c43" "#4a444e"
      -- colors.rm_code = "#1e2326"
      --
      colors.bg_main = "#32302f"
      colors.bg_alt = "#3c3836"
      colors.bg_dim = "#504945"
      colors.bg_inactive = "#665c54"
      colors.fg_main = "#d4be98"
      colors.fg_dim = "#928374"
      colors.fg_comment = "#7c6f64"
      -- colors.bg_hl_line = "#543937"
      colors.bg_hl_line = "#3c4841"
      colors.bg_completion = "#574833"
      colors.bg_match = "#333e34" --"#333e34" --#442e2d --#473c29 --#2e3b3b --#3c333b
      colors.rm_code = "#252423"
    end,

    on_highlights = function(_, colors, _)
      return {
        CursorLine = { bg = colors.bg_hl_line, underline = true },
        PmenuMatchSel = { fg = colors.accent_0, bold = true },
        -- PmenuSel = { fg = colors.bg_alt, bg = "#00F7FF" },
        PmenuSel = { fg = colors.bg_inactive, bg = colors.fg_main },

        FloatTitle = { fg = "#3AACFD", bold = true },
        FloatBorder = { fg = colors.accent_2, bg = colors.bg_main },
        NormalFloat = { bg = vim.g.bordered and colors.bg_main or colors.bg_dim },
        Comment = { fg = colors.fg_comment, italic = true },
        MatchParenCur = { bg = "#5A3824", bold = true, underline = true },
        MatchParen = { bg = "#5A3824", bold = true, underline = true },
        BlinkPairsMatchParen = { link = "MatchParen" },

        LspReferenceRead = { bg = colors.bg_dim, bold = true }, -- used for highlighting "read" references
        LspReferenceText = { bg = colors.bg_dim, bold = true }, -- used for highlighting "text" references
        LspReferenceWrite = { bg = colors.bg_dim, bold = true }, -- used for highlighting "write" references

        DiagnosticDeprecated = { bg = colors.bg_info, sp = colors.info, strikethrough = true },
        WhichKeyNormal = { bg = colors.bg_main },
        WhichKeyGroup = { fg = colors.blue, bold = true },

        DartMarked = { fg = colors.fg_dim, bg = colors.bg_main },
        DartMarkedLabel = { fg = colors.accent_2, bg = "NONE" },
        DartVisible = { fg = colors.fg_dim, bg = colors.bg_main },
        DartMarkedModified = { fg = colors.fg_changed, bg = colors.bg_changed, bold = true },
        DartMarkedLabelModified = { link = "DartMarkedLabel" },

        MiniFilesNormal = { bg = colors.bg_main },
        MiniTablineFill = { bg = colors.bg_main },
        MiniTablineCurrent = { fg = colors.fg_alt, bg = colors.bg_hover, bold = true },
        MiniTablineVisible = { fg = colors.fg_dim, bg = colors.bg_main },
        MiniTablineHidden = { fg = colors.fg_dim, bg = colors.bg_main },
        MiniTablineModifiedCurrent = { fg = colors.fg_changed, bg = colors.bg_changed, bold = true },
        MiniTablineModifiedVisible = { link = "MiniTablineModifiedCurrent" },
        MiniTablineModifiedHidden = { link = "MiniTablineModifiedCurrent" },

        NoiceCmdlinePopupBorder = { link = "FloatBorder" },
        NoiceCmdlinePopupBorderSearch = { link = "FloatBorder" },

        RenderMarkdownCode = { bg = colors.rm_code },

        lessClass = { fg = colors.accent_0 },
        ["@operator"] = { fg = "#807C37", bold = true },
        ["@punctuation.delimiter"] = { fg = "#A39B8E", bold = false },

        -- ["@property"] = { link = "@variable.member" },
        -- ["@keyword.import"] = { fg = "#56DFCF", bold = true, italic = true },
        ["@keyword.import"] = { fg = "#00CAFF", bold = true, italic = true },
        -- ["@keyword.import"] = { fg = "#34CB7D", bold = true, italic = true },
        -- ["@keyword.import"] = { fg = "#71B8FF", bold = true, italic = true },
        ["@keyword.export"] = { link = "@keyword.import" },

        -- ["@keyword.export"] = { fg = "#34CB7D", bold = true },
        -- ["@keyword.export"] = { fg = "#6AECE1", bold = true },
        ["@lsp.type.interface"] = { fg = "#B37800", bold = true },
        ["@lsp.type.enum"] = { fg = "#33CCCC", bold = true, italic = false },
        ["@lsp.type.enumMember"] = { fg = "#61BB4D", bold = true, italic = false },
        ["@lsp.typemod.enum"] = { fg = "#33CCCC", bold = true, italic = false },
        ["@lsp.typemod.enumMember"] = { fg = "#61BB4D", bold = true, italic = false },

        SnacksPicker = { bg = colors.bg_dim },
        SnacksPickerPrompt = { fg = colors.cyan_cooler, bold = true },
        SnacksPickerTitle = { link = "FloatTitle" },
        SnacksPickerInputTitle = { fg = "#68C0B6", bold = true },
        SnacksPickerPreviewTitle = { fg = "#3AACFD", bold = true },
        SnacksPickerPreview = { bg = colors.bg_main },

        SnacksPickerInput = { fg = colors.accent_3, bg = colors.bg_dim, bold = true },
        SnacksPickerInputBorder = { fg = colors.accent_2, bg = colors.bg_dim },

        SnacksPickerMatch = { fg = colors.accent_2, bg = colors.bg_match, bold = true },
        SnacksPickerListCursorLine = { bg = colors.bg_hl_line, bold = true },

        FzfLuaTitle = { link = "FloatTitle" },
        FzfLuaPreviewTitle = { link = "SnacksPickerPreviewTitle" },
        FzfLuaMatch = { link = "SnacksPickerMatch" },

        BlinkCmpSource = { fg = colors.fg_dim, bold = true },
        BlinkCmpMenu = { bg = vim.g.bordered and colors.bg_main or colors.bg_dim },
        BlinkCmpLabelMatch = { fg = colors.accent_2, bg = "NONE", bold = true },
        BlinkCmpMenuBorder = { fg = colors.accent_2, bg = colors.bg_main },
        BlinkCmpDoc = { link = "BlinkCmpMenu" },
        BlinkCmpDocBorder = { link = "BlinkCmpMenuBorder" },
        BlinkCmpSignatureHelp = { link = "BlinkCmpMenu" },
        BlinkCmpSignatureHelpBorder = { link = "BlinkCmpMenuBorder" },
        BlinkCmpKindProperty = { fg = colors.green_cooler },
        BlinkCmpKindText = { fg = colors.fg_dim },
        BlinkCmpKindSnippet = { fg = colors.magenta_cooler },

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
