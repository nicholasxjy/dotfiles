return {
  {
    "OXY2DEV/bars-N-lines.nvim",
    config = function()
      local bars = require("bars")
      bars.setup({
        exclude_filetypes = { "dashboard", "markdown", "markdown.mdx", "", "codecompanion" },
        statuscolumn = true,
        statusline = false,
        tabline = false,
      })
    end,
    lazy = false,
  },
  {
    "OXY2DEV/foldtext.nvim",
    lazy = false,
  },
}
