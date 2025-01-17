return {
  {
    "scottmckendry/cyberdream.nvim",
    config = function()
      require("cyberdream").setup({
        transparent = true,
        italic_comments = true,
        hide_fillchars = false,
        terminal_colors = true,
        cache = false,
        borderless_telescope = { border = false, style = "flat" },
        theme = {
          variant = "auto",
          colors = {
            fg = "#cdd6f4",
            bg = "#1e1e2e",
          },
          overrides = function(colors)
            return {
              Pmenu = { fg = colors.fg, bg = "#11111b" },
              NormalFloat = { fg = colors.fg, bg = "#11111b" },

              FzfLuaTitle = { fg = colors.bgHighlight, bg = colors.red },
              FzfLuaPreviewTitle = { fg = colors.bgHighlight, bg = colors.green },

              SnacksPickerBoxTitle = { fg = colors.bgHighlight, bg = colors.red },
              SnacksPickerPreviewTitle = { fg = colors.bgHighlight, bg = colors.green },

              TelescopePromptTitle = {
                bg = colors.red,
                fg = colors.bg,
              },
              TelescopePreviewTitle = {
                bg = colors.yellow,
                fg = colors.bg,
              },
              TelescopeResultsTitle = {
                bg = colors.green,
                fg = colors.bg,
              },
              ["lessClass"] = { fg = "#56b7c3" },
              ["@tag"] = { bold = true },
              ["@type"] = { bold = true, fg = "#DA498D" },
              ["@keyword"] = { fg = "#C30E59", italic = true },
              ["@tag.attribute"] = { italic = true, fg = "#789DBC" },
              ["@keyword.import"] = { italic = true, fg = "#94e2d5" },
              ["@keyword.export"] = { italic = true, fg = "#94e2d5" },
              ["@lsp.type.enum"] = { fg = "#677D6A" },
              ["@lsp.type.enumMember"] = { fg = "#C08B5C" },
              ["@lsp.type.interface"] = { fg = "#9D5C0D" },
              ["@lsp.type.property"] = { fg = "#BEADFA" },
            }
          end,
        },
      })
    end,
  },
}
