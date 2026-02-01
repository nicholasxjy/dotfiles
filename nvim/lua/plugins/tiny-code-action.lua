return {
  "rachartier/tiny-code-action.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    {
      "folke/snacks.nvim",
    },
  },
  event = "LspAttach",
  opts = {
    picker = "snacks",
  },
  keys = {
    {
      "<leader>ca",
      function()
        ---@diagnostic disable-next-line: missing-parameter
        require("tiny-code-action").code_action()
      end,
      desc = "Code Action",
      silent = true,
      noremap = true,
    },
  },
}
