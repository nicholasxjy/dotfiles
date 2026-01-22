return {
  "oonamo/ef-themes.nvim",
  opts = {
    light = "ef-trio-light",
    dark = "ef-tint",
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
      -- colors.bg_main = "#24283b"
      -- colors.bg_dim = "#292e42"
      -- colors.bg_alt = "#1f2335"

      colors.bg_main = "#222436"
      colors.bg_dim = "#2f334d"
      colors.bg_alt = "#1e2030"
      -- colors.fg_main = "#E8E5DA"
      -- colors.fg_dim = "#B3BAC7"
      colors.fg_dim = "#4D5566"
      -- colors.fg_alt = "#EDE8AF"
    end,

    on_highlights = function(_, colors, _)
      return {

        PmenuMatchSel = { fg = colors.accent_0, bold = true },
        PmenuSel = { fg = "#2D2D3D", bg = "#00F7FF" },

        FloatTitle = { fg = "#3AACFD", bold = true },
        FloatBorder = { fg = "#3338A0", bg = colors.bg_main },
        NormalFloat = { bg = vim.g.bordered and colors.bg_main or colors.bg_dim },
        -- PmenuSel = { bg = "#335668" }, --#2B4A46 --#5A3824 --#5A324B --#335668
        Comment = { fg = "#4D5566", italic = true },
        MatchParenCur = { bg = "#5A3824", bold = true },
        MatchParen = { bg = "#5A3824", bold = true },
        BlinkPairsMatchParen = { link = "MatchParen" },

        DiagnosticDeprecated = { bg = colors.bg_info, sp = colors.info, strikethrough = true },
        WhichKeyNormal = { bg = colors.bg_main },
        WhichKeyGroup = { fg = colors.blue, bold = true },
        DartVisible = { fg = colors.fg_dim },
        DartVisibleLabel = { fg = colors.fg_dim },

        MiniFilesNormal = { bg = colors.bg_main },
        MiniTablineFill = { bg = colors.bg_main },
        MiniTablineCurrent = { fg = colors.fg_alt, bg = colors.bg_info, bold = true },
        MiniTablineHidden = { fg = colors.fg_dim, bg = colors.bg_main },
        MiniTablineModifiedCurrent = { fg = colors.warning, bg = colors.bg_warning, bold = true },

        NoiceCmdlinePopupBorder = { link = "FloatBorder" },
        NoiceCmdlinePopupBorderSearch = { link = "FloatBorder" },

        lessClass = { fg = colors.accent_0 },
        ["@operator"] = { fg = "#807C37", bold = true },
        ["@punctuation.delimiter"] = { fg = "#A39B8E", bold = false },

        -- ["@property"] = { link = "@variable.member" },
        -- ["@keyword.import"] = { fg = "#56DFCF", bold = true, italic = true },
        ["@keyword.import"] = { fg = "#00CAFF", bold = true, italic = true },
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
        SnacksPickerInputBorder = { fg = colors.accent_0, bg = colors.bg_dim },
        SnacksPickerInput = { fg = colors.yellow, bg = colors.bg_dim, bold = true },
        SnacksPickerMatch = { fg = colors.accent_1, bold = true, reverse = true },
        -- SnacksPickerListCursorLine = { bg = "#4D4528", bold = true },

        FzfLuaTitle = { link = "FloatTitle" },
        FzfLuaPreviewTitle = { link = "SnacksPickerPreviewTitle" },

        BlinkCmpSource = { fg = colors.fg_dim, bold = true },
        BlinkCmpMenu = { bg = vim.g.bordered and colors.bg_main or colors.bg_dim },
        BlinkCmpLabelMatch = { fg = colors.accent_0, bg = "NONE", bold = true },
        BlinkCmpMenuBorder = { fg = colors.accent_0, bg = colors.bg_main },
        BlinkCmpDoc = { link = "BlinkCmpMenu" },
        BlinkCmpDocBorder = { link = "BlinkCmpMenuBorder" },
        BlinkCmpSignatureHelp = { link = "BlinkCmpMenu" },
        BlinkCmpSignatureHelpBorder = { link = "BlinkCmpMenuBorder" },
        BlinkCmpKindProperty = { fg = "#7FBB82" },
        BlinkCmpKindText = { fg = "#8890A5" },
        BlinkCmpKindSnippet = { fg = "#736FDF", italic = true },

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
