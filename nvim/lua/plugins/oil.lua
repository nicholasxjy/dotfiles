return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
  cmd = "Oil",
  keys = {
    { "<leader>o", "<CMD>Oil<CR>", desc = "Oil" },
  },
}
