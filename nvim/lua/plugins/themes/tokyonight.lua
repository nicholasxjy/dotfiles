return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "storm",
    transparent = false,
    styles = {
      comments = { italic = true },
      keywords = { bold = true, italic = true },
    },
    dim_inactive = true,
    lualine_bold = true,
    on_highlights = function(highlights, colors)
      highlights["@type"] = { fg = colors.blue1, bold = true }
      highlights["@tag"] = { bold = true }
      highlights["@tag.attribute"] = { italic = true, fg = "#5f7e97" }
      highlights["@constructor"] = { fg = colors.red1 }
      highlights["@keyword.import"] = { bold = true, italic = true, fg = "#94e2d5" }
      highlights["@keyword.export"] = { bold = true, italic = true, fg = "#94e2d5" }
      highlights["@operator"] = { fg = colors.blue5, bold = true }

      highlights["@lsp.type.enum"] = { fg = "#507687", bold = true }
      highlights["@lsp.type.enumMember"] = { fg = "#A9907E" }
      highlights["@lsp.type.interface"] = { fg = "#9D5C0D", bold = true }
    end,
    cache = true,
    plugins = {
      all = true,
      auto = true,
    },
  },
}
