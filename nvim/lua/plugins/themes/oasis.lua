local ui = require("core.ui")

return {
  "uhs-robert/oasis.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    local c = require("oasis.color_palettes.oasis_desert").dark
    local palette = require("oasis.palette")
    local float_border = palette.soil[900] --"#B68973" --"#3B38A0"

    local bg_core = vim.g.transparent and "NONE" or c.bg.core

    local opts = {
      style = "desert",
      dark_style = "auto", -- Style to use when vim.o.background is "dark"
      light_style = "auto", -- Style to use when vim.o.background is "light"
      light_intensity = 3,
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
        min_ratio = 7,
        force_aaa = false,
      },
      palette_overrides = {},
      highlight_overrides = {

        MoreMsg = { fg = c.fg.muted, bold = false, italic = true, undercurl = true },
        Cursor = { bg = palette.visual.light_pink },
        NormalFloat = { bg = vim.g.bordered and bg_core or c.bg.mantle },
        FloatBorder = { fg = float_border, bg = bg_core },
        FloatTitle = { fg = palette.red[600], bold = true },
        PmenuMatch = { fg = c.ui.match.bg, bold = true },
        Statusline = { bg = bg_core },
        DiagnosticDeprecated = { fg = c.fg.muted, strikethrough = true },

        LspInlayHint = { fg = palette.slate[800], bg = c.bg.shadow, italic = false },

        DartCurrent = { fg = c.theme.primary, bg = bg_core, bold = true, italic = true },
        DartCurrentLabel = { fg = c.theme.light_primary, bg = bg_core, bold = true },
        DartVisible = { fg = c.fg.dim, bg = bg_core },
        DartVisibleLabel = { fg = c.fg.dim, bg = bg_core },

        NoiceCmdlinePopupBorder = "FloatBorder",
        NoiceCmdlinePopupBorderSearch = "FloatBorder",
        MiniFilesNormal = { bg = bg_core, fg = c.fg.core },
        MiniClueDescSingle = { bg = bg_core, fg = c.fg.dim },
        MiniClueNextKey = { bg = bg_core, fg = c.fg.comment, bold = true },
        MiniClueSeparator = "FloatBorder",

        SnacksPicker = { bg = bg_core },
        SnacksPickerFile = { fg = c.fg.core },
        SnacksPickerDir = { fg = c.fg.dim, italic = true },
        SnacksPickerPathIgnored = { fg = c.fg.muted, italic = true },
        SnacksPickerPathHidden = { fg = c.fg.muted, italic = true },
        SnacksPickerMatch = { fg = c.ui.match.bg, bg = c.fg.dim, bold = true },
        -- SnacksPickerInput = { bg = bg_core },
        SnacksPickerInputBorder = { bg = bg_core, fg = float_border },
        -- SnacksPickerPreview = { bg = bg_core },
        -- SnacksPickerList = { bg = bg_core },
        SnacksPickerPrompt = "Special",
        SnacksPickerListCursorLine = { bg = c.bg.surface, bold = true },
        SnacksPickerTitle = "FloatTitle",
        SnacksPickerInputTitle = { fg = palette.palm[600], bold = true },
        SnacksPickerPreviewTitle = { fg = palette.lagoon[600], bold = true },
        --
        FzfLuaFzfMatch = "SnacksPickerMatch",
        FzfLuaTitle = "FloatTitle",
        FzfLuaPreviewTitle = { fg = palette.lagoon[600], bold = true },
        --
        BlinkCmpMenu = { bg = vim.g.bordered and bg_core or c.bg.mantle, fg = c.fg.dim },
        BlinkCmpDoc = "BlinkCmpMenu",
        BlinkCmpMenuBorder = "FloatBorder",
        BlinkCmpDocBorder = "FloatBorder",
        BlinkCmpSignatureHelpBorder = "FloatBorder",
        BlinkCmpLabelMatch = { fg = "#FF4646", bold = true, underline = true },
        BlinkCmpMenuSelection = { bg = palette.visual.orange },
        BlinkCmpKind = "Special",
        BlinkCmpLabelDeprecated = { fg = c.fg.muted, strikethrough = true, italic = true },
        BlinkCmpSource = { fg = c.fg.muted },
        BlinkCmpLabelDescription = { fg = c.fg.muted },

        SidekickDiffContext = "DiffChange",
        SidekickDiffAdd = "DiffAdd",
        SidekickDiffDelete = "DiffDelete",

        SidekickSignAdd = { fg = c.diff.add },
        SidekickSignChange = { fg = c.diff.change },
        SidekickSignDelete = { fg = c.diff.delete, strikethrough = true },

        ["@punctuation.bracket"] = { fg = palette.grey[800], bold = false },

        Type = { fg = palette.gold[500], bold = true },
        Function = { fg = palette.cyan[600] },
        Keyword = { fg = palette.sapphire[800], bold = false, italic = true },
        ["@module"] = { fg = palette.grey[700], bold = false, italic = false },
        ["@keyword"] = "Keyword",
        ["@parameter"] = { fg = palette.lavender[300] },
        ["@variable.parameter"] = "@parameter",
        ["@type.builtin"] = { fg = palette.sunset[400] },
        ["@keyword.import"] = { fg = palette.cyan[500], bold = true },
        ["@keyword.export"] = "@keyword.import",
        ["@keyword.modifier"] = { fg = palette.cactus[600], bold = true },

        ["@lsp.type.keyword"] = "Keyword",
        ["@lsp.type.modifier"] = "@keyword.modifier",
        ["@lsp.type.interface"] = { fg = palette.sunshine[700], bold = true, italic = false },
        ["@lsp.type.namespace"] = "@module",
        ["@lsp.type.enum"] = { fg = palette.horizon[600], bold = true, italic = false },
        ["@lsp.type.enumMember"] = { fg = palette.moss[700], bold = true, italic = false },
        ["@lsp.typemod.enum.defaultLibrary"] = { fg = palette.horizon[600], bold = true, italic = false },
        ["@lsp.typemod.enumMember.defaultLibrary"] = { fg = palette.moss[700], bold = true, italic = false },
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
        BlinkIndentRed = "RainbowDelimiterRed",
        BlinkIndentOrange = "RainbowDelimiterOrange",
        BlinkIndentYellow = "RainbowDelimiterYellow",
        BlinkIndentGreen = "RainbowDelimiterGreen",
        BlinkIndentCyan = "RainbowDelimiterCyan",
        BlinkIndentBlue = "RainbowDelimiterBlue",
        BlinkIndentViolet = "RainbowDelimiterViolet",

        BlinkIndentRedUnderline = "RainbowDelimiterRed",
        BlinkIndentOrangeUnderline = "RainbowDelimiterOrange",
        BlinkIndentYellowUnderline = "RainbowDelimiterYellow",
        BlinkIndentGreenUnderline = "RainbowDelimiterGreen",
        BlinkIndentCyanUnderline = "RainbowDelimiterCyan",
        BlinkIndentBlueUnderline = "RainbowDelimiterBlue",
        BlinkIndentVioletUnderline = "RainbowDelimiterViolet",

        SnacksIndentRed = "RainbowDelimiterRed",
        SnacksIndentOrange = "RainbowDelimiterOrange",
        SnacksIndentYellow = "RainbowDelimiterYellow",
        SnacksIndentGreen = "RainbowDelimiterGreen",
        SnacksIndentCyan = "RainbowDelimiterCyan",
        SnacksIndentBlue = "RainbowDelimiterBlue",
        SnacksIndentViolet = "RainbowDelimiterViolet",

        SnacksIndentChunkRed = "RainbowDelimiterRed",
        SnacksIndentChunkOrange = "RainbowDelimiterOrange",
        SnacksIndentChunkYellow = "RainbowDelimiterYellow",
        SnacksIndentChunkGreen = "RainbowDelimiterGreen",
        SnacksIndentChunkCyan = "RainbowDelimiterCyan",
        SnacksIndentChunkBlue = "RainbowDelimiterBlue",
        SnacksIndentChunkViolet = "RainbowDelimiterViolet",
      },
    }
    require("oasis").setup(opts)
  end,
}
