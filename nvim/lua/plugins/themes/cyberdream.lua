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
          -- saturation = 0.8,
          colors = {
            fg = "#cdd6f4",
          },
          overrides = function(colors)
            return {
              SnacksIndentChunk1 = { link = "RainbowDelimiterRed" },
              SnacksIndentChunk2 = { link = "RainbowDelimiterYellow" },
              SnacksIndentChunk3 = { link = "RainbowDelimiterBlue" },
              SnacksIndentChunk4 = { link = "RainbowDelimiterOrange" },
              SnacksIndentChunk5 = { link = "RainbowDelimiterGreen" },
              SnacksIndentChunk6 = { link = "RainbowDelimiterViolet" },
              SnacksIndentChunk7 = { link = "RainbowDelimiterCyan" },

              FzfLuaTitle = { fg = colors.bgHighlight, bg = colors.red },
              FzfLuaPreviewTitle = { fg = colors.bgHighlight, bg = colors.green },

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
              ["@type"] = { bold = true, fg = "#FFA62F" },
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
