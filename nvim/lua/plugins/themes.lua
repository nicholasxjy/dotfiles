return {
  {
    "oonamo/ef-themes.nvim",
    opts = {
      light = "ef-trio-light",
      dark = "ef-winter",
      transparent = true,
      styles = {
        -- Set specific styles for specific highlight groups
        -- Can be any valid attr-list value. See `:h nvim_set_hl`
        comments = { italic = true },
        keywords = { bold = true },
        functions = {},
        variables = {},

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
      },
      on_highlights = function(_, colors)
        return {

          BlinkPairsRed = { fg = colors.red },
          BlinkPairsOrange = { fg = colors.yellow_warmer },
          BlinkPairsYellow = { fg = colors.yellow },
          BlinkPairsGreen = { fg = colors.green },
          BlinkPairsBlue = { fg = colors.blue },
          BlinkPairsPurple = { fg = colors.magenta },
          BlinkPairsCyan = { fg = colors.cyan },

          Comment = { fg = "#8b8693", italic = true },
          LspInlayHint = { bg = "NONE", fg = "#8b8693", italic = true }, --colors.bg_inactive

          FzfLuaTitle = { fg = colors.bg_alt, bg = colors.red },
          FzfLuaPreviewTitle = { fg = colors.bg_alt, bg = colors.green },

          SnacksPickerBoxTitle = { fg = colors.bg_alt, bg = colors.red_cooler },
          SnacksPickerPreviewTitle = { fg = colors.bg_alt, bg = colors.green_cooler },

          Function = { fg = "#66d9ef", bold = true },
          ["@function"] = { link = "Function" },

          ["@tag.tsx"] = { bold = true },
          ["@tag.attribute.tsx"] = { italic = true },

          ["@operator"] = { bold = true, fg = colors.yellow_faint },

          ["@keyword.import"] = { fg = "#94e2d5", italic = true, bold = true },
          ["@keyword.export"] = { fg = "#94e2d5", italic = true, bold = true },

          ["@keyword.modifier"] = { fg = colors.blue_warmer, italic = true, bold = true },
          ["@keyword.coroutine"] = { fg = colors.red, italic = true, bold = true },
          ["@keyword.exception"] = { fg = colors.red, italic = true, bold = true },

          ["@lsp.type.enum"] = { fg = colors.green_warmer, bold = true },
          ["@lsp.type.enumMember"] = { fg = "#04d1f9", bold = true, italic = true },
          ["@lsp.type.interface"] = { fg = "#9D5C0D", italic = true, bold = true },
        }
      end,
    },
  },
  -- kanagawa
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
  -- cyberdream
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "dark",
      transparent = true,
      saturation = 1, -- accepts a value between 0 and 1. 0 will be fully desaturated (greyscale) and 1 will be the full color (default)
      italic_comments = true,
      hide_fillchars = false,
      borderless_pickers = true,
      terminal_colors = true,
      cache = true,
      highlights = {},
      overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
        local custom_red = "#F94C10"
        local custom_purple = "#af85ff"
        local custom_yellow = "#cf9f8f"
        return {
          FzfLuaTitle = { fg = colors.bgHighlight, bg = colors.red },
          FzfLuaPreviewTitle = { fg = colors.bgHighlight, bg = colors.green },

          SnacksPickerBoxTitle = { fg = colors.bg, bg = colors.red },
          SnacksPickerPreviewTitle = { fg = colors.bg, bg = colors.green },

          ["@tag"] = { bold = true },
          ["@type"] = { bold = true, italic = false, fg = "#EC7FA9" },

          ["@keyword"] = { fg = custom_purple, italic = true, bold = true },
          ["@operator"] = { fg = custom_yellow, bold = true },

          ["@property"] = { fg = "#F9C0AB" },
          ["@lsp.type.property"] = { fg = "#F9C0AB" },

          ["@tag.attribute"] = { italic = true, fg = "#9EC6F3" },
          ["@keyword.import"] = { bold = true, italic = true, fg = "#94e2d5" },
          ["@keyword.export"] = { bold = true, italic = true, fg = "#94e2d5" },

          ["@keyword.coroutine"] = { bold = true, italic = true, fg = custom_red },
          ["@keyword.exception"] = { bold = true, italic = true, fg = custom_red },
          ["@keyword.conditional"] = { bold = true, italic = true, fg = custom_red },

          ["@lsp.type.enum"] = { fg = "#706233", italic = false, bold = true },
          ["@lsp.type.enumMember"] = { fg = "#39B5E0", bold = true, italic = false },
          ["@lsp.type.interface"] = { bold = true, italic = false, fg = "#9D5C0D" },
        }
      end,

      colors = {
        fg = "#C6E7FF",
      },
    },
  },
  -- aurora
  {
    "nicholasxjy/aurora",
    init = function()
      vim.g.aurora_italic = 1
      vim.g.aurora_bold = 1
      vim.g.aurora_darker = 1
      vim.g.aurora_transparent = 1
    end,
  },
}
