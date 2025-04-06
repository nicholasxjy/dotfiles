return {
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
}
