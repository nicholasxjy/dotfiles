return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = false,
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      { "<leader>o", "<cmd>Oil<cr>", desc = "Open oil" },
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    confiog = function(_, opts)
      require("oil").setup(opts)
    end,
  },
}
