return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
  },
  lazy = false,
  keys = {
    { "<leader>o", "<CMD>Oil<CR>", desc = "Open oil" },
  },
  dependencies = { { "echasnovski/mini.icons" } },
}
