return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
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
          saturation = 0.8,
          colors = {
            fg = "#D7D3BF",
          },
          overrides = function(colors)
            return {
              TabLine = { fg = colors.fg, bg = colors.bgHighlight },
              TabLineFill = { fg = colors.grey, bg = colors.bg },
              TabLineSel = { fg = colors.bgAlt, bg = colors.green },

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
              ["@type"] = { bold = true, fg = "#FFC700" },
              ["@keyword"] = { fg = "#f38ba8", italic = true },
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
