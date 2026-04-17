return {
  "rrethy/vim-illuminate",
  event = "VeryLazy",
  keys = {
    {
      "]]",
      function()
        require("illuminate").goto_next_reference()
      end,
      desc = "Next reference",
    },
    {
      "[[",
      function()
        require("illuminate").goto_prev_reference()
      end,
      desc = "Prev reference",
    },
  },
  config = function()
    require("illuminate").configure({
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
      -- delay: delay in milliseconds
      delay = 100,
    })
  end,
}
