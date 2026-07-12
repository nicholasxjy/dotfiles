-- pack install
vim.pack.add({
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/mrjones2014/smart-splits.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nicholasxjy/minibuffer.nvim",
})

require("vim._core.ui2").enable({
  enable = true,
  msg = { target = "msg" },
})
