return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },
  { "Bilal2453/luvit-meta" },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },
  {
    "windwp/nvim-ts-autotag",
    event = "BufRead",
    opts = {},
  },
  {
    "oskarrrrrrr/symbols.nvim",
    keys = {
      { ",s", "<cmd>SymbolsToggle<CR>", desc = "Symbols Toggle" },
    },
    config = function()
      local r = require("symbols.recipes")
      require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {
        sidebar = {
          hide_cursor = true,
          open_direction = "right",
        },
      })
    end,
  },
}
