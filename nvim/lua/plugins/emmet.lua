return {
  -- here only for wrapping html tags
  -- emmet_ls is already installed in mason
  "olrtg/nvim-emmet",
  event = "VeryLazy",
  keys = {
    {
      "<leader>ce",
      function()
        require("nvim-emmet").wrap_with_abbreviation()
      end,
      desc = "Emmet Wrap with Abbreviation",
      mode = { "n", "v" },
    },
  },
}
