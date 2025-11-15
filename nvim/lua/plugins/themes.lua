return {
  {
    "nicholasxjy/Lemons.nvim",
    branch = "dev",
    opts = {
      transparent = vim.g.transparent,
      override_colors = {
        black = "#1a1926",
        dark_gray = "#211c2f",
        gray = "#303047",
      },
      overrides = function(c)
        return {
          NormalFloat = { bg = vim.g.transparent and "NONE" or c.black },
          FloatBorder = { fg = c.navy, bg = vim.g.transparent and "NONE" or c.black },
          FzfLuaBorder = { link = "FloatBorder" },
          StatusLine = { bg = "NONE" },
          Search = { bg = c.dark_yellow, fg = c.yellow, bold = true },
          -- PmenuSel = { fg = c.black, bg = "#87ceeb" },
          CursorLine = { bg = c.gray },
          Tabline = { bg = "NONE", fg = c.gray },
          TablineFill = { bg = "NONE" },
          MiniSurround = { fg = c.black, bg = c.orange },

          BlinkCmpMenu = { bg = vim.g.transparent and "NONE" or c.gray },

          SnacksPickerCursorLine = { link = "CursorLine" },
          SnacksPickerListCursorLine = { link = "CursorLine" },
          SnacksPickerMatch = { fg = c.yellow, bg = c.dark_yellow, bold = true },

          BlinkIndentRed = { link = "RainbowDelimiterRed" },
          BlinkIndentOrange = { link = "RainbowDelimiterOrange" },
          BlinkIndentYellow = { link = "RainbowDelimiterYellow" },
          BlinkIndentGreen = { link = "RainbowDelimiterGreen" },
          BlinkIndentCyan = { link = "RainbowDelimiterCyan" },
          BlinkIndentBlue = { link = "RainbowDelimiterBlue" },
          BlinkIndentViolet = { link = "RainbowDelimiterViolet" },

          BlinkIndentRedUnderline = { link = "RainbowDelimiterRed" },
          BlinkIndentOrangeUnderline = { link = "RainbowDelimiterOrange" },
          BlinkIndentYellowUnderline = { link = "RainbowDelimiterYellow" },
          BlinkIndentGreenUnderline = { link = "RainbowDelimiterGreen" },
          BlinkIndentCyanUnderline = { link = "RainbowDelimiterCyan" },
          BlinkIndentBlueUnderline = { link = "RainbowDelimiterBlue" },
          BlinkIndentVioletUnderline = { link = "RainbowDelimiterViolet" },
        }
      end,
    },
  },
}
