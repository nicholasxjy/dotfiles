return {
  "cryptomilk/nightcity.nvim",
  version = false,
  lazy = false,
  opts = {
    -- kabuki or afterlife
    style = "afterlife", -- The theme comes in two styles: kabuki or afterlife
    terminal_colors = true, -- Use colors used when opening a `:terminal`
    invert_colors = {
      cursor = false,
      diff = true,
      error = true,
      search = true,
      selection = false,
      signs = false,
      statusline = false,
      tabline = false,
    },
    font_style = {
      -- Style to be applied to different syntax groups
      comments = { italic = true },
      keywords = {},
      functions = { bold = true },
      variables = {},
      search = { bold = true },
    },
    -- Plugin integrations. Use `default = false` to disable all integrations.
    plugins = { default = true },
    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    on_highlights = function(highlights, colors)
      highlights.FzfLuaBorder = { fg = colors.bg }
      highlights.FzfLuaTitle = { fg = colors.bg, bg = colors.red }
      highlights.FzfLuaPreviewTitle = { fg = colors.bg, bg = colors.green }
      highlights["@tag"] = { bold = true }
      highlights["@lsp.type.enum"] = { fg = "#227B94" }
      highlights["@lsp.type.enumMember"] = { fg = "#C08B5C" }
      highlights["@lsp.type.interface"] = { fg = "#9D5C0D" }
      highlights["@keyword.import"] = { bold = true, fg = colors.lightgreen }
      highlights["@keyword.export"] = { bold = true, fg = colors.lightgreen }
    end,
  },
}
