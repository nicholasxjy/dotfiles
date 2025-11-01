return {
  {
    "folke/snacks.nvim",
    opts = {
      indent = {
        indent = {
          enabled = false,
          only_current = true,
          only_scope = true,
          -- char = "⋮",
          char = "",
          -- char = "┊",
          hl = {
            "SnacksIndentRed",
            "SnacksIndentOrange",
            "SnacksIndentYellow",
            "SnacksIndentGreen",
            "SnacksIndentCyan",
            "SnacksIndentBlue",
            "SnacksIndentViolet",
          },
        },
        scope = {
          enabled = true,
          -- char = "║",
          char = "┊",
          underline = true,
          only_current = true,
          hl = {
            "SnacksIndentScopeRed",
            "SnacksIndentScopeOrange",
            "SnacksIndentScopeYellow",
            "SnacksIndentScopeGreen",
            "SnacksIndentScopeCyan",
            "SnacksIndentScopeBlue",
            "SnacksIndentScopeViolet",
          },
        },
        chunk = {
          enabled = false,
          char = {
            -- corner_top = "┌",
            -- corner_bottom = "└",
            corner_top = "╭",
            corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = "",
          },
          only_current = true,
          hl = {
            "SnacksIndentChunkRed",
            "SnacksIndentChunkOrange",
            "SnacksIndentChunkYellow",
            "SnacksIndentChunkGreen",
            "SnacksIndentChunkCyan",
            "SnacksIndentChunkBlue",
            "SnacksIndentChunkViolet",
          },
        },
      },
    },
  },
}
