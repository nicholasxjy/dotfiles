return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- do not set background color
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
          local makeDiagnosticColor = function(color)
            local c = require("kanagawa.lib.color")
            return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
          end
          return {
            ["@keyword.import"] = { italic = true, fg = palette.peachRed },
            ["@keyword.export"] = { italic = true, fg = palette.peachRed },

            -- ["@keyword.repeat"] = { italic = true, bold = true, fg = "#FF8E00" },
            -- ["@keyword.coroutine"] = { italic = true, bold = true, fg = "#B51B75" },
            -- ["@keyword.exception"] = { italic = true, bold = true, fg = "#F94C10" },

            ["@lsp.type.enum"] = { fg = "#0D7C66" },
            ["@lsp.type.enumMember"] = { fg = "#C08B5C" },
            ["@lsp.type.interface"] = { fg = "#9D5C0D" },

            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            TelescopeTitle = { bg = palette.peachRed, fg = theme.ui.bg_p1, bold = true, italic = true },
            TelescopePreviewTitle = { bg = palette.lightBlue, fg = theme.ui.bg_p1, bold = true, italic = true },
            TelescopeResultsTitle = { bg = palette.springGreen, fg = theme.ui.bg_p1, bold = true, italic = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
            DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
            DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
            DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),

            -- blink.cmp
            BlinkCmpMenu = { link = "Pmenu" },
            BlinkCmpMenuSelection = { fg = "NONE", bg = theme.ui.pmenu.bg_sel },
            BlinkCmpMenuBorder = { fg = theme.ui.bg_search, bg = theme.ui.pmenu.bg },
            BlinkCmpScrollBarThumb = { link = "PmenuThumb" },
            BlinkCmpScrollBarGutter = { link = "PmenuSbar" },
            BlinkCmpLabel = { fg = theme.ui.pmenu.fg },
            BlinkCmpLabelMatch = { fg = theme.syn.fun },
            BlinkCmpLabelDeprecated = { fg = theme.syn.comment, strikethrough = true },
            BlinkCmpGhostText = { fg = theme.syn.comment },
            BlinkCmpDoc = { link = "NormalFloat" },
            BlinkCmpDocBorder = { link = "FloatBorder" },
            BlinkCmpDocCursorLine = { link = "Visual" },
            BlinkCmpSignatureHelp = { link = "NormalFloat" },
            BlinkCmpSignatureHelpBorder = { link = "FloatBorder" },
            BlinkCmpSignatureHelpActiveParameter = { link = "LspSignatureActiveParameter" },

            BlinkCmpItemKindText = { fg = theme.ui.fg },
            BlinkCmpItemKindMethod = { link = "@function.method" },
            BlinkCmpItemKindFunction = { link = "Function" },
            BlinkCmpItemKindConstructor = { link = "@constructor" },
            BlinkCmpItemKindField = { link = "@variable.member" },
            BlinkCmpItemKindVariable = { fg = theme.ui.fg_dim },
            BlinkCmpItemKindClass = { link = "Type" },
            BlinkCmpItemKindInterface = { link = "Type" },
            BlinkCmpItemKindModule = { link = "@module" },
            BlinkCmpItemKindProperty = { link = "@property" },
            BlinkCmpItemKindUnit = { link = "Number" },
            BlinkCmpItemKindValue = { link = "String" },
            BlinkCmpItemKindEnum = { link = "Type" },
            BlinkCmpItemKindKeyword = { link = "Keyword" },
            BlinkCmpItemKindSnippet = { link = "Special" },
            BlinkCmpItemKindColor = { link = "Special" },
            BlinkCmpItemKindFile = { link = "Directory" },
            BlinkCmpItemKindReference = { link = "Special" },
            BlinkCmpItemKindFolder = { link = "Directory" },
            BlinkCmpItemKindEnumMember = { link = "Constant" },
            BlinkCmpItemKindConstant = { link = "Constant" },
            BlinkCmpItemKindStruct = { link = "Type" },
            BlinkCmpItemKindEvent = { link = "Type" },
            BlinkCmpItemKindOperator = { link = "Operator" },
            BlinkCmpItemKindTypeParameter = { link = "Type" },
            BlinkCmpItemKindCopilot = { link = "String" },
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
