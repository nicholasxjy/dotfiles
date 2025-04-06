return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = true, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true, bold = true },
        statementStyle = { bold = true },
        typeStyle = { bold = true },
        transparent = false, -- do not set background color
        dimInactive = true, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
              -- ui = {
              --   bg_gutter = "none",
              -- },
            },
          },
        },
        overrides = function(colors) -- add/modify highlights
          local theme = colors.theme
          local palette = colors.palette

          return {
            ["@tag"] = { bold = true },
            ["@tag.attribute.tsx"] = { italic = true },

            ["@keyword.import"] = { italic = true, bold = true, fg = palette.waveRed },
            ["@keyword.export"] = { italic = true, bold = true, fg = palette.waveRed },

            ["@operator"] = { bold = true, fg = theme.syn.operator },
            ["@module"] = { fg = palette.carpYellow },
            ["@keyword.modifier"] = { fg = palette.sakuraPink, italic = true, bold = true },

            ["@lsp.type.enum"] = { fg = palette.springGreen, bold = true },
            ["@lsp.type.enumMember"] = { fg = "#04d1f9", bold = true, italic = true },
            ["@lsp.type.interface"] = { fg = "#9D5C0D", italic = true, bold = true },

            BlinkPairsRed = { fg = palette.peachRed },
            BlinkPairsOrange = { fg = palette.surimiOrange },
            BlinkPairsYellow = { fg = palette.carpYellow },
            BlinkPairsGreen = { fg = palette.springGreen },
            BlinkPairsBlue = { fg = palette.springBlue },
            BlinkPairsPurple = { fg = palette.oniViolet },
            BlinkPairsCyan = { fg = palette.lightBlue },

            FzfLuaBorder = { fg = theme.ui.bg_dim },
            FzfLuaTitle = { fg = theme.ui.bg_p1, bg = palette.peachRed },
            FzfLuaPreviewTitle = { fg = theme.ui.bg_p1, bg = palette.springGreen },
            FzfLuaNormal = { bg = "NONE", blend = vim.o.pumblend },

            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            -- SnacksDashboard
            SnacksDashboardHeader = { fg = theme.vcs.removed },
            SnacksDashboardFooter = { fg = theme.syn.comment },
            SnacksDashboardDesc = { fg = theme.syn.identifier },
            SnacksDashboardIcon = { fg = theme.ui.special },
            SnacksDashboardKey = { fg = theme.syn.special1 },
            SnacksDashboardSpecial = { fg = theme.syn.comment },
            SnacksDashboardDir = { fg = theme.syn.identifier },
            -- SnacksNotifier
            SnacksNotifierBorderError = { link = "DiagnosticError" },
            SnacksNotifierBorderWarn = { link = "DiagnosticWarn" },
            SnacksNotifierBorderInfo = { link = "DiagnosticInfo" },
            SnacksNotifierBorderDebug = { link = "Debug" },
            SnacksNotifierBorderTrace = { link = "Comment" },
            SnacksNotifierIconError = { link = "DiagnosticError" },
            SnacksNotifierIconWarn = { link = "DiagnosticWarn" },
            SnacksNotifierIconInfo = { link = "DiagnosticInfo" },
            SnacksNotifierIconDebug = { link = "Debug" },
            SnacksNotifierIconTrace = { link = "Comment" },
            SnacksNotifierTitleError = { link = "DiagnosticError" },
            SnacksNotifierTitleWarn = { link = "DiagnosticWarn" },
            SnacksNotifierTitleInfo = { link = "DiagnosticInfo" },
            SnacksNotifierTitleDebug = { link = "Debug" },
            SnacksNotifierTitleTrace = { link = "Comment" },
            SnacksNotifierError = { link = "DiagnosticError" },
            SnacksNotifierWarn = { link = "DiagnosticWarn" },
            SnacksNotifierInfo = { link = "DiagnosticInfo" },
            SnacksNotifierDebug = { link = "Debug" },
            SnacksNotifierTrace = { link = "Comment" },
            -- SnacksProfiler
            SnacksProfilerIconInfo = { bg = theme.ui.bg_search, fg = theme.syn.fun },
            SnacksProfilerBadgeInfo = { bg = theme.ui.bg_visual, fg = theme.syn.fun },
            SnacksScratchKey = { link = "SnacksProfilerIconInfo" },
            SnacksScratchDesc = { link = "SnacksProfilerBadgeInfo" },
            SnacksProfilerIconTrace = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
            SnacksProfilerBadgeTrace = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
            SnacksIndent = { fg = theme.ui.bg_p2, nocombine = true },
            SnacksIndentScope = { fg = theme.ui.pmenu.bg, nocombine = true },
            SnacksZenIcon = { fg = theme.syn.statement },
            SnacksInputIcon = { fg = theme.ui.pmenu.bg },
            SnacksInputBorder = { fg = theme.syn.identifier },
            SnacksInputTitle = { fg = theme.syn.identifier },
            -- SnacksPicker
            SnacksPickerInputBorder = { fg = theme.syn.constant },
            SnacksPickerInputTitle = { fg = theme.syn.constant },
            SnacksPickerBoxTitle = { fg = theme.syn.constant },
            SnacksPickerSelected = { fg = theme.syn.number },
            SnacksPickerToggle = { link = "SnacksProfilerBadgeInfo" },
            SnacksPickerPickWinCurrent = { fg = theme.ui.fg, bg = theme.syn.number, bold = true },
            SnacksPickerPickWin = { fg = theme.ui.fg, bg = theme.ui.bg_search, bold = true },
          }
        end,
        theme = "lotus", -- Load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus",
        },
      })
    end,
  },
}
