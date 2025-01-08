return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    opts = {
      flavour = "frappe",
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
        local prompt = C.mantle
        return {
          FzfLuaNormal = { bg = C.mantle, fg = C.fg },
          FzfLuaBorder = { fg = C.mantle },
          FzfLuaTitle = { fg = C.base, bg = C.red },
          FzfLuaPreviewTitle = { fg = C.base, bg = C.green },

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

          SnacksIndent = { link = "LineNr" },
          SnacksIndentBlank = { link = "LineNr" },
          ["lessClass"] = { fg = "#56b7c3" },
          ["@tag"] = { bold = true },
          -- ["@type"] = { bold = true, fg = "#FCC737" },
          -- ["@keyword"] = { fg = "#E178C5", italic = true },
          -- ["@tag.attribute"] = { italic = true, fg = "#789DBC" },
          -- ["@tag.attribute.tsx"] = { italic = true, fg = "#789DBC" },
          -- ["@keyword.import"] = { italic = true, fg = C.sky },
          -- ["@keyword.export"] = { italic = true, fg = C.sky },
          ["@lsp.type.enum"] = { fg = "#677D6A" },
          ["@lsp.type.enumMember"] = { fg = "#C08B5C" },
          ["@lsp.type.interface"] = { fg = "#9D5C0D" },
          -- ["@lsp.type.function"] = { fg = "#8B93FF" },
        }
      end,
      default_integration = true,
      integrations = {
        semantic_tokens = false,
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
  },
}
