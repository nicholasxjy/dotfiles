return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local use_italic = false

      require("kanagawa").setup({
        compile = true, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = use_italic, bold = true },
        statementStyle = { bold = true },
        typeStyle = { bold = true },
        transparent = true, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
        overrides = function(colors) -- add/modify highlights
          local theme = colors.theme
          local palette = colors.palette

          return {
            ["@tag"] = { bold = true },
            ["@tag.attribute.tsx"] = { italic = use_italic },
            ["@keyword.import"] = { italic = use_italic, fg = palette.peachRed },
            ["@keyword.export"] = { italic = use_italic, fg = palette.peachRed },
            ["@lsp.type.enum"] = { fg = "#808836" },
            ["@lsp.type.enumMember"] = { fg = "#C08B5C" },
            ["@lsp.type.interface"] = { fg = "#9D5C0D" },

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
          }
        end,
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus",
        },
      })
    end,
  },
}
