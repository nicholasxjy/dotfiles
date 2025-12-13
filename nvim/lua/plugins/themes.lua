return {
  {
    "uhs-robert/oasis.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      local c = require("oasis.color_palettes.oasis_desert").dark
      local palette = require("oasis.palette")
      local float_border = "#B68973" --palette.sapphire[900]    --"#3B38A0"
      local opts = {
        style = "desert",
        dark_style = "auto", -- Style to use when vim.o.background is "dark"
        light_style = "auto", -- Style to use when vim.o.background is "light"
        use_legacy_comments = false,
        themed_syntax = true,

        styles = {
          bold = true, -- Enable bold text (keywords, functions, etc.)
          italic = true, -- Enable italics (comments, certain keywords)
          underline = true, -- Enable underlined text (matching words)
          undercurl = true, -- Enable undercurl for diagnostics/spelling
          strikethrough = true, -- Enable strikethrough text (deprecations)
        },

        transparent = vim.g.transparent,
        terminal_colors = true,
        contrast = {
          min_ratio = 5.8, -- Clamp 4.5–7.0; target contrast for syntax/terminal colors. Increase for more contrast, decrease for more pop.
          force_aaa = false, -- When true, forces AAA (7.0) wherever possible; as a result some colors will appear muddy (bye bye non-primary colors).
        },
        palette_overrides = {},
        highlight_overrides = {

          MoreMsg = { fg = c.fg.dim, bold = true, italic = true },
          Cursor = { bg = "#00FF7F" },
          NormalFloat = { bg = c.bg.mantle },
          FloatBorder = { fg = float_border, bg = c.bg.core },
          FloatTitle = { fg = "#CB4251", bold = true },
          PmenuMatch = { fg = c.ui.match.bg, bold = true },

          MiniFilesNormal = { bg = c.bg.core, fg = c.fg.core },
          MiniClueDescSingle = { bg = c.bg.core, fg = c.fg.dim },
          MiniClueNextKey = { bg = c.bg.core, fg = c.fg.comment, bold = true },
          MiniClueSeparator = "FloatBorder",

          SnacksPicker = { bg = c.bg.core },
          SnacksPickerFile = { fg = c.fg.core },
          SnacksPickerDir = { fg = c.fg.comment, italic = true },
          SnacksPickerMatch = { fg = c.ui.match.bg, bg = c.fg.dim, bold = true },
          SnacksPickerInput = { bg = c.bg.core },
          SnacksPickerInputBorder = { bg = c.bg.core, fg = float_border },
          SnacksPickerPreview = { bg = c.bg.core },
          SnacksPickerPrompt = "Special",
          SnacksPickerListCursorLine = { bg = c.bg.mantle, bold = true },
          --
          FzfLuaFzfMatch = "SnacksPickerMatch",
          FzfLuaTitle = "FloatTitle",
          FzfLuaPreviewTitle = { fg = palette.lagoon[600], bold = true },
          --
          BlinkCmpMenu = { bg = c.bg.mantle },
          BlinkCmpDoc = "BlinkCmpMenu",
          BlinkCmpMenuBorder = "FloatBorder",
          BlinkCmpDocBorder = "FloatBorder",
          BlinkCmpSignatureHelpBorder = "FloatBorder",
          BlinkCmpLabelMatch = "PmenuMatch",
          BlinkCmpMenuSelection = "PmenuSel",
          BlinkCmpKind = "Special",
          -- --
          Type = { fg = palette.gold[500], bold = true },
          Function = { fg = palette.lagoon[300] },
          ["@module"] = { fg = palette.rose[500], bold = false, italic = false },
          ["@operator"] = { fg = palette.gold[800], bold = false },
          ["@keyword"] = { fg = palette.lavender[300] },
          ["@punctuation.delimiter"] = { fg = palette.gold[800] },
          ["@parameter"] = { fg = palette.sunshine[200] },
          ["@variable.parameter"] = "@parameter",
          ["@type.builtin"] = { fg = palette.sunset[400] },
          ["@keyword.import"] = { fg = palette.cyan[500], bold = true },
          ["@keyword.export"] = "@keyword.import",
          ["@keyword.return"] = { fg = palette.lavender[400], bold = true, italic = false },
          ["@keyword.modifier"] = { fg = palette.lavender[200] },
          ["@lsp.type.keyword"] = "Keyword",
          ["@lsp.type.modifier"] = "@keyword.modifier",
          ["@lsp.type.interface"] = { fg = palette.sunshine[700], bold = true },
          ["@lsp.type.namespace"] = "@module",
          ["@lsp.type.enum"] = { fg = palette.sapphire[700], bold = true, italic = false },
          ["@lsp.type.enumMember"] = { fg = palette.palm[600], bold = true },

          BlinkCmpKindMethod = "Function",
          BlinkCmpKindFunction = "Function",
          BlinkCmpKindVariable = "Identifier",
          BlinkCmpKindProperty = "Identifier",

          BlinkCmpKindClass = "Type",
          BlinkCmpKindStruct = "Type",
          BlinkCmpKindTypeParameter = "Type",

          BlinkCmpKindConstructor = { fg = c.syntax.builtinFunc },

          BlinkCmpKindEnum = "@lsp.type.enum",
          BlinkCmpKindEnumMember = "@lsp.type.enumMember",
          BlinkCmpKindInterface = "@lsp.type.interface",

          BlinkCmpKindModule = "@module",
          BlinkCmpKindPackage = "@module",
          BlinkCmpKindNameSpace = "@module",

          BlinkCmpKindNumber = "Number",
          BlinkCmpKindBoolean = "Boolean",
          BlinkCmpKindConstant = "Constant",
          BlinkCmpKindKeyword = "Keyword",
          BlinkCmpKindBuffer = "String",
          BlinkCmpKindString = "String",
          BlinkCmpKindOperator = "Operator",
          BlinkCmpKindSnippet = { fg = palette.lavender[600] },
          BlinkCmpKindField = { fg = palette.rose[700] },

          --
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
        },
      }
      require("oasis").setup(opts)
    end,
  },
}
