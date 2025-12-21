local ui = require("core.ui")

return {
  {
    "uhs-robert/oasis.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      local c = require("oasis.color_palettes.oasis_night").dark
      local palette = require("oasis.palette")
      local float_border = palette.sky[900] --palette.soil[900] --palette.lagoon[900]   --"#B68973" --palette.sunshine[800]   --palette.cyan[900] --palette.sapphire[900]  --"#3B38A0"

      local bg_core = vim.g.transparent and "NONE" or c.bg.core

      local opts = {
        style = "night",
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
          min_ratio = 6.6, -- Clamp 4.5–7.0; target contrast for syntax/terminal colors. Increase for more contrast, decrease for more pop.
          force_aaa = false, -- When true, forces AAA (7.0) wherever possible; as a result some colors will appear muddy (bye bye non-primary colors).
        },
        palette_overrides = {},
        highlight_overrides = {

          MoreMsg = { fg = c.fg.dim, bold = true, italic = true },
          Cursor = { bg = "#00FF7F" },
          NormalFloat = { bg = bg_core },
          FloatBorder = { fg = float_border, bg = bg_core },
          FloatTitle = { fg = "#CB4251", bold = true },
          PmenuMatch = { fg = c.ui.match.bg, bold = true },

          DartCurrent = { fg = c.theme.primary, bg = c.bg.core, bold = true, italic = true },
          DartCurrentLabel = { fg = c.theme.light_primary, bg = c.bg.core, bold = true },
          DartVisible = { fg = c.fg.muted, bg = c.bg.core },
          DartVisibleLabel = { fg = c.fg.muted, bg = c.bg.core },

          NoiceCmdlinePopupBorder = "FloatBorder",
          NoiceCmdlinePopupBorderSearch = "FloatBorder",
          MiniFilesNormal = { bg = bg_core, fg = c.fg.core },
          MiniClueDescSingle = { bg = bg_core, fg = c.fg.dim },
          MiniClueNextKey = { bg = bg_core, fg = c.fg.comment, bold = true },
          MiniClueSeparator = "FloatBorder",

          SnacksPicker = { bg = bg_core },
          SnacksPickerFile = { fg = c.fg.core },
          SnacksPickerDir = { fg = c.fg.comment, italic = true },
          SnacksPickerMatch = { fg = c.ui.match.bg, bg = c.fg.dim, bold = true },
          SnacksPickerInput = { bg = bg_core },
          SnacksPickerInputBorder = { bg = bg_core, fg = float_border },
          SnacksPickerPreview = { bg = bg_core },
          SnacksPickerPrompt = "Special",
          SnacksPickerListCursorLine = { bg = c.bg.mantle, bold = true },
          SnacksPickerTitle = "FloatTitle",
          SnacksPickerInputTitle = { fg = palette.palm[600], bold = true },
          SnacksPickerPreviewTitle = { fg = palette.lagoon[600], bold = true },
          --
          FzfLuaFzfMatch = "SnacksPickerMatch",
          FzfLuaTitle = "FloatTitle",
          FzfLuaPreviewTitle = { fg = palette.lagoon[600], bold = true },
          --
          BlinkCmpMenu = { bg = bg_core },
          BlinkCmpDoc = "BlinkCmpMenu",
          BlinkCmpMenuBorder = "FloatBorder",
          BlinkCmpDocBorder = "FloatBorder",
          BlinkCmpSignatureHelpBorder = "FloatBorder",
          BlinkCmpLabelMatch = { fg = palette.rose[700], bold = true },
          BlinkCmpMenuSelection = { bg = palette.visual.pink },
          BlinkCmpKind = "Special",

          SidekickDiffContext = "DiffChange",
          SidekickDiffAdd = "DiffAdd",
          SidekickDiffDelete = "DiffDelete",
          SidekickSignAdd = { fg = c.diff.add },
          SidekickSignChange = { fg = c.diff.change },
          SidekickSignDelete = { fg = c.diff.delete },

          Type = { fg = palette.gold[600], bold = true },
          Function = { fg = palette.horizon[400] },
          ["@module"] = { fg = palette.sapphire[200], bold = false, italic = true },
          ["@operator"] = { fg = palette.gold[800], bold = false },
          ["@keyword"] = { fg = palette.lavender[500], italic = true },
          ["@attribute"] = { fg = palette.sapphire[300], italic = true },
          ["@punctuation.delimiter"] = { fg = palette.gold[800] },
          ["@punctuation.bracket"] = { fg = palette.stone[700] },
          ["@parameter"] = { fg = palette.sunshine[200] },
          ["@variable.parameter"] = "@parameter",
          ["@type.builtin"] = { fg = palette.sunset[400] },
          ["@keyword.import"] = { fg = palette.cyan[600], bold = true },
          ["@keyword.export"] = "@keyword.import",
          ["@keyword.return"] = { fg = palette.peach[700], bold = true, italic = false },
          ["@keyword.modifier"] = { fg = palette.sapphire[400], bold = true },
          ["@lsp.type.keyword"] = "Keyword",
          ["@lsp.type.modifier"] = "@keyword.modifier",
          ["@lsp.type.interface"] = { fg = palette.sunset[700], bold = true, italic = true },
          ["@lsp.type.namespace"] = "@module",
          ["@lsp.type.enum"] = { fg = palette.horizon[600], bold = true, italic = false },
          ["@lsp.type.enumMember"] = { fg = palette.moss[700], bold = true },
          ["@lsp.typemod.enum.defaultLibrary"] = { fg = palette.horizon[600], bold = true, italic = false },
          ["@lsp.typemod.enumMember.defaultLibrary"] = { fg = palette.moss[700], bold = true },
          ["@lsp.typemod.class.defaultLibrary"] = "Type",
          ["@lsp.typemod.function.defaultLibrary"] = "@function.builtin",
          ["@lsp.typemod.macro.defaultLibrary"] = "@function.builtin",
          ["@lsp.typemod.method.defaultLibrary"] = "Function",
          ["@lsp.typemod.struct.defaultLibrary"] = "Type",
          ["@lsp.typemod.variable.defaultLibrary"] = "@variable.builtin",

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
          BlinkCmpKindSnippet = { fg = palette.lavender[300] },
          BlinkCmpKindField = { fg = palette.rose[700] },

          RainbowDelimiterRed = { fg = ui.rainbow_colors.red },
          RainbowDelimiterOrange = { fg = ui.rainbow_colors.orange },
          RainbowDelimiterYellow = { fg = ui.rainbow_colors.yellow },
          RainbowDelimiterGreen = { fg = ui.rainbow_colors.green },
          RainbowDelimiterCyan = { fg = ui.rainbow_colors.cyan },
          RainbowDelimiterBlue = { fg = ui.rainbow_colors.blue },
          RainbowDelimiterViolet = { fg = ui.rainbow_colors.purple },

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

          SnacksIndentChunkRed = { link = "RainbowDelimiterRed" },
          SnacksIndentChunkOrange = { link = "RainbowDelimiterOrange" },
          SnacksIndentChunkYellow = { link = "RainbowDelimiterYellow" },
          SnacksIndentChunkGreen = { link = "RainbowDelimiterGreen" },
          SnacksIndentChunkCyan = { link = "RainbowDelimiterCyan" },
          SnacksIndentChunkBlue = { link = "RainbowDelimiterBlue" },
          SnacksIndentChunkViolet = { link = "RainbowDelimiterViolet" },
        },
      }
      require("oasis").setup(opts)
    end,
  },
}
