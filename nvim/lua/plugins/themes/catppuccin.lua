return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,
      term_colors = true,
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = {
        comments = { "italic" },
        conditionals = {},
        constants = {},
        keywords = { "bold" },
        loops = {},
        numbers = {},
        booleans = { "bold" },
        operators = {},
      },
      color_overrides = {},
      custom_highlights = function(C)
        return {

          FzfLuaBorder = { fg = C.mantle },
          FzfLuaTitle = { fg = C.base, bg = C.red },
          FzfLuaPreviewTitle = { fg = C.base, bg = C.green },
          SnacksPickerBoxTitle = { fg = C.base, bg = C.green },

          ["@tag"] = { bold = true },
          ["@keyword.import"] = { fg = C.sky, italic = true, bold = true },
          ["@keyword.export"] = { fg = C.sky, italic = true, bold = true },

          ["@keyword.modifier"] = { fg = C.teal, italic = true, bold = true },
          -- ["@lsp.type.enum"] = { fg = "#677D6A" },
          -- ["@lsp.type.enumMember"] = { fg = "#C08B5C", bold = true },

          ["@lsp.type.interface"] = { fg = "#9D5C0D", bold = true },
        }
      end,
      default_integration = true,
      integrations = {
        semantic_tokens = true,
        telescope = {
          enabled = false,
        },
        flash = true,
        fzf = true,
        gitsigns = true,
        neotree = true,
        neotest = true,
        mason = true,
        noice = true,
        notify = true,
        which_key = true,
        mini = {
          enabled = true,
        },
        cmp = false,
        dap = true,
        dap_ui = true,
        treesitter_context = true,
        treesitter = true,
        rainbow_delimiters = true,
        symbols_outline = false,
        illuminate = {
          enabled = true,
          lsp = false,
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
        blink_cmp = true,
        snacks = true,
      },
    },
  },
}
