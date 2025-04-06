return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = { "folke/snacks.nvim", lazy = true },
    keys = {
      {
        "<leader>y",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    opts = {
      open_for_directories = false,
      yazi_floating_window_border = "single",
      keymaps = {
        show_help = "?",
      },
    },
  },
}
