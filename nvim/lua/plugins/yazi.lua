return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    {
      "<leader>e",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "Open yazi",
    },
  },
  opts = {
    open_for_directories = true,
    floating_window_scaling_factor = 0.99,
    yazi_floating_window_border = "none",
    yazi_floating_window_zindex = 250,
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
}
