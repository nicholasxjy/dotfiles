return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  cmd = "Fyler",
  keys = {
    { "<leader>o", "<cmd>Fyler kind=float<cr>", desc = "Fyler" },
  },
  opts = {
    views = {
      finder = {
        confirm_simple = true,
      },
      watcher = {
        enabled = true,
      },
      win = {
        border = "single",
        kind = "float",
        kinds = {
          float = {
            height = "80%",
            width = "80%",
            top = "10%",
            left = "10%",
          },
        },
      },
    },
  },
}
