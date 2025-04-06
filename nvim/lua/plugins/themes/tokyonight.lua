return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        sidebars = "dark",
        floats = "dark",
      },
      dim_inactive = false,
      lualine_bold = true,
      cache = true,
      plugins = {
        all = true,
        auto = true,
      },
      on_colors = function(colors)
        -- colors.fg = "#cdd6f4"
        -- colors.fg_dark = "#ABB4DA"
        -- colors.fg_gutter = "#3b4261"
        -- colors.cyan = "#04d1f9"
        -- colors.magenta = "#bf4f8e"
        -- colors.magenta2 = "#722f55"
        -- colors.pink = "#f265b5"
        -- colors.purple = "#a48cf2"
        -- colors.orange = "#EF9C66"
        -- colors.yellow = "#e0af68"
        -- colors.red = "#f16c75"
        -- colors.red1 = "#f0313e"
        -- colors.green = "#37f499"
        -- colors.green1 = "#80C4E9"
        -- colors.green2 = "#1F4529"
      end,
      on_highlights = function(highlights, colors)
        highlights.FzfLuaNormal = { bg = colors.none }
        highlights.FzfLuaBorder = { fg = colors.bg_highlight }
        highlights.FzfLuaTitle = { fg = colors.bg_dark, bg = colors.red }
        highlights.FzfLuaPreviewTitle = { fg = colors.bg_dark, bg = colors.green }

        highlights.BlinkPairsRed = { fg = colors.red }
        highlights.BlinkPairsOrange = { fg = colors.orange }
        highlights.BlinkPairsYellow = { fg = colors.yellow }
        highlights.BlinkPairsGreen = { fg = colors.green }
        highlights.BlinkPairsBlue = { fg = colors.blue }
        highlights.BlinkPairsPurple = { fg = colors.magenta }
        highlights.BlinkPairsCyan = { fg = colors.cyan }

        highlights["@type"] = { fg = "#00a692", bold = true }
        highlights["@tag"] = { bold = true }
        highlights["lessClass"] = { italic = true, fg = colors.cyan }

        highlights["@tag.attribute"] = { italic = true, fg = colors.blue5 }

        highlights["@constructor"] = { fg = colors.red1 }

        highlights["@keyword.import"] = { italic = true, bold = true, fg = "#f16c75" }
        highlights["@keyword.export"] = { italic = true, bold = true, fg = "#f16c75" }

        highlights["@lsp.type.enum"] = { fg = "#04d1f9", bold = true }
        highlights["@lsp.type.enumMember"] = { fg = "#EF9C66" }
        highlights["@lsp.type.interface"] = { fg = "#9D5C0D", bold = true, italic = true }
      end,
    },
  },
}
