return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  lazy = false, -- Necessary for `default_explorer` to work properly
  cmd = "Fyler",
  keys = {
    { "<leader>o", "<cmd>Fyler<cr>", desc = "Open Fyler" },
  },
  opts = {
    views = {
      finder = {
        indentscope = {
          enabled = false,
        },
        win = {
          border = "single",
          win_opts = {
            cursorline = true,
          },
        },
      },
    },
  },
}
