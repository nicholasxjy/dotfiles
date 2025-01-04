return {
  {
    "oskarrrrrrr/symbols.nvim",
    event = "VeryLazy",
    cmd = { "SymbolsToggle", "SymbolsOpen", "SymbolsClose" },
    keys = {
      { ",s", "<cmd>SymbolsToggle<cr>", desc = "Toggle symbols" },
    },
    config = function()
      local r = require("symbols.recipes")
      require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {
        sidebar = {
          hide_cursor = true,
          close_on_goto = true,
          wrap = true,
        },
      })
    end,
  },
}
