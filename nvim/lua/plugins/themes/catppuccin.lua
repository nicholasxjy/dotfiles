return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = false,
      term_colors = true,
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        constants = {},
        keywords = { "italic" },
        loops = { "italic" },
        numbers = {},
        booleans = { "bold" },
        operators = { "bold" },
      },
      color_overrides = {},
      custom_highlights = function(C)
        local prompt = C.surface0
        return {
          TelescopeNormal = {
            bg = prompt,
            fg = C.text,
          },
          TelescopeBorder = {
            bg = prompt,
            fg = prompt,
          },
          TelescopePromptNormal = {
            bg = prompt,
          },
          TelescopePromptBorder = {
            bg = prompt,
            fg = prompt,
          },
          TelescopePromptTitle = {
            bg = C.red,
            fg = C.bg,
          },
          TelescopePreviewTitle = {
            bg = C.sky,
            fg = C.bg,
          },
          TelescopeResultsTitle = {
            bg = C.green,
            fg = C.bg,
          },

          -- Comment = { italic = true, fg = C.surface2 },
          -- ["@type"] = { bold = true, fg = "#F0AA0B" },
          ["lessClass"] = { fg = "#56b7c3" },
          -- ["@keyword.function"] = { fg = "#A78CFA" },
          -- ["@keyword.return"] = { fg = "#FF6ABC" },
          -- ["@variable.builtin"] = { italic = true, fg = "#F02b77" },
          ["@tag"] = { bold = true },
          -- ["@constructor"] = { fg = "#E06c75" },
          -- ["@keyword.import"] = { italic = true, fg = "#c838c6" },
          -- ["@keyword.repeat"] = { italic = true, bold = true, fg = "#FF8E00" },
          -- ["@keyword.coroutine"] = { italic = true, bold = true, fg = "#B51B75" },
          -- ["@keyword.exception"] = { italic = true, bold = true, fg = "#F94C10" },
          -- ["@module"] = { fg = "#E06c75" },
          --
          ["@lsp.type.enum"] = { fg = "#0D7C66" },
          ["@lsp.type.enumMember"] = { fg = "#C08B5C" },
          ["@lsp.type.interface"] = { fg = "#9D5C0D" },
        }
      end,
      default_integration = true,
      integrations = {
        semantic_tokens = true,
        telescope = {
          enabled = true,
        },
        dropbar = {
          enabled = true,
          color_mode = true,
        },
        barbecue = {
          dim_dirname = true,
          bold_basename = true,
          dim_context = false,
          alt_background = false,
        },
        headlines = true,
        flash = true,
        fzf = true,
        barbar = true,
        gitsigns = true,
        leap = true,
        neotree = true,
        neotest = true,
        mason = true,
        noice = true,
        notify = true,
        which_key = true,
        mini = {
          enabled = true,
        },
        overseer = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        treesitter_context = true,
        treesitter = true,
        window_picker = true,
        rainbow_delimiters = true,
        symbols_outline = true,
        lsp_trouble = true,
        illuminate = {
          enabled = true,
          lsp = false,
        },
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        colorful_winsep = {
          enabled = true,
          color = "red",
        },
        blink_cmp = true,
      },
    },
    -- init = function()
    --   vim.cmd("colorscheme catppuccin")
    -- end,
  },
}
