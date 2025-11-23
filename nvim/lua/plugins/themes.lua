return {
  {
    "ribru17/bamboo.nvim",
    opts = {
      style = "multiplex", -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
      transparent = vim.g.transparent,
      lualine = {
        transparent = true, -- lualine center bar transparency
      },
      code_style = {
        comments = { italic = true },
        conditionals = { italic = true },
        keywords = {},
        functions = {},
        namespaces = { italic = true },
        parameters = { italic = true },
        strings = {},
        variables = {},
      },
      colors = {
        bg0 = "#333333",
        red = "#CB4251",
        aqua = "#0fb9e0",
        lime = "#2ed592",
        green = "#2ed563",
        orange = "#F37A2E",
        yellow = "#EADD61", --"#f0be42",
        blue = "#38D0EF",
        pink = "#f45ab4",
        cyan = "#37c3b5",
        purple = "#be9af7",
      },
      highlights = {
        Comment = { fg = "#6D90A8", fmt = "italic" },
        ["@comment"] = { link = "Comment" },
        PmenuMatch = { bg = "#555555", fg = "#FFB870", fmt = "bold" },
        PmenuMatchSel = { bold = true, sp = "bg0" },
        FloatTitle = { fg = "$red", fmt = "bold" },
        FloatBorder = { fg = "#3B38A0" },
        Type = { fg = "$yellow", fmt = "bold" },
        TablineFill = { fg = "$grey", bg = "bg0" },
        MiniTablineFill = { fg = "$grey", bg = "bg0" },
        MiniTablineHidden = { fg = "$fg", bg = "$bg1" },
        ["@keyword.import"] = { fg = "#2ed592", fmt = "bold" },
        ["@keyword.export"] = { fg = "#2ed592", fmt = "bold" },

        ["@lsp.typemod.enum"] = { fg = "#61AEFF", fmt = "bold" },
        ["@lsp.typemod.enumMember"] = { fg = "#9EC410", fmt = "bold" },
        ["@lsp.typemod.enum.rust"] = { fg = "#61AEFF", fmt = "bold" },
        ["@lsp.typemod.enumMember.rust"] = { fg = "#9EC410", fmt = "bold" },

        ["@lsp.type.modifier"] = { link = "@keyword.modifier" },
        ["@lsp.type.interface"] = { fg = "#D4A017", fmt = "bold,italic" },

        BlinkCmpMenu = { bg = "$bg0" },
        BlinkCmpDoc = { bg = "$bg0" },

        SnacksPickerMatch = { link = "PmenuMatch" },

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
    },
  },
  {
    "uhs-robert/oasis.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      local c = require("oasis.color_palettes.oasis_desert")
      local palette = require("oasis.palette")
      local opts = {
        dark_style = "desert", -- Style to use when vim.o.background is "dark"
        light_style = "day", -- Style to use when vim.o.background is "light"
        style = nil, -- Optional: Set a single style to disable auto-switching (e.g., "lagoon", "desert")
        use_legacy_comments = false, -- Uses the legacy comment color from desert.vim for the "desert" style only (a bright sky blue)

        styles = {
          bold = true, -- Enable bold text (keywords, functions, etc.)
          italic = true, -- Enable italics (comments, certain keywords)
          underline = true, -- Enable underlined text (matching words)
          undercurl = true, -- Enable undercurl for diagnostics/spelling
          strikethrough = true, -- Enable strikethrough text (deprecations)
        },

        -- Display options
        transparent = vim.g.transparent, -- Set to true for transparent backgrounds (bye bye theme backgrounds)
        terminal_colors = true, -- Apply Oasis colors to Neovim's built-in terminal

        palette_overrides = {
          oasis_night = {
            ui = {
              border = c.ui.border,
            },
          },
        }, -- Override colors in specific palettes
        highlight_overrides = {

          FloatBorder = { fg = palette.lagoon[600], bg = vim.g.transparent and "NONE" or c.bg.core },
          NormalFloat = { fg = c.fg.strong, bg = c.bg.core },
          Type = { fg = palette.gold[300], bold = true },
          Function = { fg = palette.lagoon[600] },
          Keyword = { fg = palette.lavender[400] },
          PmenuMatch = { fg = c.ui.match.bg, bg = c.bg.surface, bold = true },

          --
          SnacksPickerInput = { link = "NormalFloat" },
          SnacksPickerInputBorder = { bg = c.bg.core, fg = palette.lagoon[600] },
          SnacksPickerPreview = { link = "NormalFloat" },
          SnacksPickerPreviewBorder = { bg = c.bg.core, fg = palette.lagoon[600] },
          SnacksPickerMatch = { link = "PmenuMatch" },
          --
          BlinkCmpMenu = { link = "NormalFloat" },
          BlinkCmpMenuBorder = { link = "FloatBorder" },
          BlinkCmpDocBorder = { link = "FloatBorder" },
          BlinkCmpSignatureHelpBorder = { link = "FloatBorder" },
          --
          ["@module"] = { fg = palette.coral[200], bold = false },
          ["@operator"] = { fg = palette.brown[400], bold = false },
          ["@keyword"] = { link = "Keyword" },
          ["@punctuation.delimiter"] = { fg = palette.brown[500] },
          ["@parameter"] = { fg = palette.red[800], italic = true },
          ["@variable.parameter"] = "@parameter",
          ["@type.builtin"] = { fg = palette.sunset[400] },
          ["@keyword.import"] = { fg = palette.cactus[700], bold = true },
          ["@keyword.export"] = { link = "@keyword.import" },
          ["@keyword.return"] = { fg = palette.sunrise[700], bold = true, italic = true },
          ["@keyword.modifier"] = { fg = palette.lavender[600] },
          ["@lsp.type.modifier"] = { link = "@keyword.modifier" },
          ["@lsp.type.interface"] = { fg = palette.dune[500], bold = true, italic = true },
          ["@lsp.type.property"] = { fg = palette.aloe[400] },
          ["@lsp.type.namespace"] = { link = "@module" },
          ["@lsp.type.enum"] = { fg = palette.azure[600], bold = true, italic = false },
          ["@lsp.type.enumMember"] = { fg = palette.moss[500], bold = true },

          BlinkCmpKindMethod = { link = "Function" },
          BlinkCmpKindFunction = { link = "Function" },
          BlinkCmpKindVariable = { link = "Identifier" },
          BlinkCmpKindProperty = { link = "Identifier" },

          BlinkCmpKindClass = { link = "Type" },
          BlinkCmpKindStruct = { link = "Type" },
          BlinkCmpKindTypeParameter = { link = "Type" },

          BlinkCmpKindConstructor = { fg = c.syntax.builtinFunc },

          BlinkCmpKindEnum = { link = "@lsp.type.enum" },
          BlinkCmpKindEnumMember = { link = "@lsp.type.enumMember" },
          BlinkCmpKindInterface = { link = "@lsp.type.interface" },

          BlinkCmpKindModule = { link = "@module" },
          BlinkCmpKindPackage = { link = "@module" },
          BlinkCmpKindNameSpace = { link = "@module" },

          BlinkCmpKindNumber = { link = "Number" },
          BlinkCmpKindBoolean = { link = "Boolean" },
          BlinkCmpKindConstant = { link = "Constant" },
          BlinkCmpKindKeyword = { link = "Keyword" },
          BlinkCmpKindString = { link = "String" },
          BlinkCmpKindOperator = { link = "Operator" },
          BlinkCmpKindSnippet = { fg = palette.lavender[400] },
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
        }, -- Override specific highlight groups
      }
      require("oasis").setup(opts)
    end,
  },
}
