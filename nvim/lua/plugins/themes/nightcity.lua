return {
  "cryptomilk/nightcity.nvim",
  version = false,
  opts = {
    -- kabuki or afterlife
    style = "kabuki", -- The theme comes in two styles: kabuki or afterlife
    terminal_colors = true, -- Use colors used when opening a `:terminal`
    invert_colors = {
      cursor = false,
      diff = false,
      error = false,
      search = false,
      selection = false,
      signs = false,
      statusline = false,
      tabline = false,
    },
    font_style = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = { bold = false },
      variables = {},
      search = { bold = true },
    },
    -- Plugin integrations. Use `default = false` to disable all integrations.
    plugins = { default = true },

    on_highlights = function(groups, c)
      groups["FloatBorder"] = { fg = c.red }
      groups["FloatTitle"] = { fg = c.red }

      groups["FzfLuaBorder"] = { link = "FloatBorder" }
      groups["FzfLuaPreviewBorder"] = { link = "FloatBorder" }
      groups["FzfLuaHelpBorder"] = { link = "FloatBorder" }
      groups["FzfLuaPreviewTitle"] = { fg = c.blue, bold = true }

      groups["BlinkCmpSource"] = { fg = c.xgray4 }
      groups["@tag.tsx"] = { bold = true }
      groups["@tag.jsx"] = { bold = true }

      groups["@punctuation.bracket"] = { fg = c.xgray3 }
    end,
  },
}
