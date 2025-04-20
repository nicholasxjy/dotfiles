return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "fish" },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        fish = { "fish_indent" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        fish = { "fish" },
      },
    },
  },
}
