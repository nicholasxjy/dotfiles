vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  { src = "https://github.com/nicholasxjy/zed-bar.nvim", version = "feature/optional-nvim-treesitter" },
})

require("zed-bar").setup({})
