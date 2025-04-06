return {
  "oonamo/ef-themes.nvim",
  opts = {
    light = "ef-trio-light",
    dark = "ef-owl",
    transparent = true,
    styles = {
      -- Set specific styles for specific highlight groups
      -- Can be any valid attr-list value. See `:h nvim_set_hl`
      comments = { italic = true },
      keywords = { bold = true },
      functions = {},
      variables = {},

      diagnostic = "full", -- Can be "full"
      pickers = "borderless", -- Can be "borderless"
    },

    modules = {
      blink = true,
      fzf = true,
      mini = true,
      semantic_tokens = true,
      snacks = true,
      treesitter = true,
      gitsigns = true,
      which_key = true,
    },
    on_highlights = function(_, colors)
      return {

        BlinkPairsRed = { fg = colors.red },
        BlinkPairsOrange = { fg = colors.yellow_warmer },
        BlinkPairsYellow = { fg = colors.yellow },
        BlinkPairsGreen = { fg = colors.green },
        BlinkPairsBlue = { fg = colors.blue },
        BlinkPairsPurple = { fg = colors.magenta },
        BlinkPairsCyan = { fg = colors.cyan },

        Comment = { fg = "#8b8693" },
        LspInlayHint = { bg = colors.bg_inactive, fg = "#8b8693", italic = true }, --colors.bg_inactive

        FzfLuaTitle = { fg = colors.bg_alt, bg = colors.red },
        FzfLuaPreviewTitle = { fg = colors.bg_alt, bg = colors.green },

        SnacksPickerBoxTitle = { fg = colors.bg_alt, bg = colors.red_cooler },
        SnacksPickerPreviewTitle = { fg = colors.bg_alt, bg = colors.green_cooler },

        ["@tag.tsx"] = { bold = true },
        ["@tag.attribute.tsx"] = { italic = true },

        ["@operator"] = { bold = true, fg = colors.yellow_faint },

        ["@keyword.import"] = { fg = "#4CC9FE", italic = true, bold = true },
        ["@keyword.export"] = { fg = "#4CC9FE", italic = true, bold = true },

        ["@keyword.modifier"] = { fg = colors.blue_warmer, italic = true, bold = true },

        ["@keyword.coroutine"] = { fg = colors.red, italic = true, bold = true },
        ["@keyword.exception"] = { fg = colors.red, italic = true, bold = true },

        ["@lsp.type.enum"] = { fg = colors.green_warmer, bold = true },
        ["@lsp.type.enumMember"] = { fg = "#04d1f9", bold = true, italic = true },
        ["@lsp.type.interface"] = { fg = "#9D5C0D", italic = true, bold = true },
      }
    end,
  },
}
