return {
  {
    "catppuccin/nvim",
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
        conditionals = {},
        constants = {},
        keywords = { "bold" },
        loops = {},
        numbers = {},
        booleans = { "bold" },
        operators = {},
      },
      color_overrides = {
        mocha = {
          text = "#F4CDE9",
          subtext1 = "#DEBAD4",
          subtext0 = "#C8A6BE",
          overlay2 = "#B293A8",
          overlay1 = "#9C7F92",
          overlay0 = "#866C7D",
          surface2 = "#705867",
          surface1 = "#5A4551",
          surface0 = "#44313B",

          base = "#352939",
          mantle = "#211924",
          crust = "#1a1016",
        },
      },
      custom_highlights = function(C)
        return {

          FzfLuaBorder = { fg = C.mantle },
          FzfLuaTitle = { fg = C.base, bg = C.red },
          FzfLuaPreviewTitle = { fg = C.base, bg = C.green },
          SnacksPickerBoxTitle = { fg = C.base, bg = C.green },

          ["@tag"] = { bold = true },
          ["@keyword.import"] = { fg = C.sky, bold = true },
          ["@keyword.export"] = { fg = C.sky, bold = true },
          ["@lsp.type.enum"] = { fg = "#677D6A" },
          ["@lsp.type.enumMember"] = { fg = "#C08B5C", bold = true },
          ["@lsp.type.interface"] = { fg = "#9D5C0D", bold = true },
        }
      end,
      default_integration = true,
      integrations = {
        semantic_tokens = false,
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
