local ui = require("core.ui")

return {
  "oonamo/ef-themes.nvim",
  opts = {
    light = "ef-trio-light",
    dark = "ef-autumn",
    transparent = vim.g.transparent,
    styles = {
      comments = { italic = true },
      keywords = { bold = true, italic = false },
      functions = {},
      variables = {},
      classes = { bold = true },
      types = { bold = true },

      diagnostic = "full", -- Can be "full"
      pickers = "borderless", -- Can be "borderless"
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
      -- theme colors
      for k, v in pairs(ui.theme_colors.gruvbox_soft) do
        colors[k] = v
      end

      -- colors.menu_sel_bg = colors.fg_main
      -- colors.menu_sel_fg = "#504945"

      colors.syn_interface = "#FF9644" -- "#F075AE" --"#C68EFD" --"#D78FEE" --"#B37800"
    end,

    on_highlights = function(_, colors, _)
      return {
        Comment = { fg = colors.fg_comment, italic = true },
        StatusBorder = { link = "Comment" },
        LineNr = { link = "Comment" },

        CursorLine = { bg = colors.bg_hl_line, underline = false },
        CursorLineNr = { fg = colors.accent_0, bold = true },

        MatchParenCur = { bg = colors.bg_dim, bold = true, reverse = true },
        MatchParen = { bg = colors.bg_dim, bold = true, reverse = true },
        BlinkPairsMatchParen = { link = "MatchParen" },

        LspReferenceRead = { bg = colors.bg_dim, bold = true }, -- used for highlighting "read" references
        LspReferenceText = { bg = colors.bg_dim, bold = true }, -- used for highlighting "text" references
        LspReferenceWrite = { bg = colors.bg_dim, bold = true }, -- used for highlighting "write" references

        DiagnosticDeprecated = { bg = colors.bg_info, sp = colors.info, strikethrough = true },

        MiniFilesNormal = { bg = colors.bg_dim },

        WhichKeyNormal = { bg = colors.bg_dim },
        WhichKeyGroup = { fg = colors.accent_1, bold = true },

        RenderMarkdownCode = { bg = colors.rm_code },

        lessClass = { fg = colors.accent_0 },
        ["@tag.tsx"] = { bold = true, italic = false },
        ["@operator"] = { fg = colors.fg_comment, bold = true },
        ["@punctuation.delimiter"] = { fg = "#A39B8E", bold = false },

        -- ["@keyword.import"] = { fg = "#00FFAB", bold = true, italic = true },
        -- ["@keyword.import"] = { fg = "#00CAFF", bold = true, italic = true },
        ["@keyword.import"] = { fg = "#41C9E2", bold = false, italic = false },
        -- ["@keyword.import"] = { fg = "#34CB7D", bold = true, italic = true },
        -- ["@keyword.import"] = { fg = "#71B8FF", bold = true, italic = true },
        -- ["@keyword.import"] = { fg = "#6AECE1", bold = true, italic = true },
        ["@keyword.export"] = { link = "@keyword.import" },

        SnacksPickerMatch = { fg = colors.accent_2, bg = colors.bg_match, bold = true },
        SnacksPickerListCursorLine = { bg = colors.bg_hl_line, bold = true },

        FzfLuaTitle = { link = "FloatTitle" },
        FzfLuaPreviewTitle = { link = "SnacksPickerPreviewTitle" },
        FzfLuaFzfMatch = { link = "SnacksPickerMatch" },

        BlinkCmpSource = { fg = colors.fg_dim, bold = true },
        -- BlinkCmpLabelMatch = { fg = nil, bg = "NONE", bold = true },

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
