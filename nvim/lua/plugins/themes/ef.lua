return {
  "oonamo/ef-themes.nvim",
  opts = {
    light = "ef-spring",
    dark = "ef-false",
    transparent = false,
    styles = {
      -- Set specific styles for specific highlight groups
      -- Can be any valid attr-list value. See `:h nvim_set_hl`
      comments = { italic = true },
      keywords = { bold = true },
      functions = {},
      variables = {},

      diagnostic = "full", -- Can be "full"
      pickers = "default", -- Can be "borderless"
    },

    modules = {
      -- Enable/Disable highlights for a module
      -- See `h: EfThemes-modules` for the list of available modules
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
        LspInlayHint = { bg = colors.bg_inactive, fg = colors.fg_dim },
        FzfLuaTitle = { fg = colors.bg_alt, bg = colors.red },
        FzfLuaPreviewTitle = { fg = colors.bg_alt, bg = colors.green },
        ["@tag.tsx"] = { bold = true },

        ["@keyword.import"] = { fg = colors.blue_cooler, bold = true },
        ["@keyword.export"] = { fg = colors.blue_cooler, bold = true },

        ["@lsp.type.enum"] = { fg = "#677D6A" },
        ["@lsp.type.enumMember"] = { fg = "#C08B5C", bold = true },
        ["@lsp.type.interface"] = { fg = "#9D5C0D", bold = true },
      }
    end,
  },
}
