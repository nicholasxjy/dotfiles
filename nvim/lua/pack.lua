vim.pack.add({
  "https://github.com/edisj/msgarea.nvim",
})

require("vim._core.ui2").enable({
  enable = true,
  msg = {
    targets = {
      default = "msg",
      typed_cmd = "msgarea",
      wmsg = "msgarea",
      emsg = "msgarea",
      lua_error = "msgarea",
      list_cmd = "msgarea",
      lua_print = "msgarea",
      echoerr = "msgarea",
      shell_out = "msgarea",
      shell_cmd = "msgarea",
      shell_err = "msgarea",
      confirm = "pager",
      rpc_error = "pager",
    },
    msg = { timeout = 4000 },
    pager = { height = 0.75 },
  },
})

-- pack install
vim.pack.add({
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/mrjones2014/smart-splits.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
})
