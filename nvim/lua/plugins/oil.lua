return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = true,
    },
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "Open oil" },
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    confiog = function(_, opts)
      require("oil").setup(opts)
    end,
  },
}
