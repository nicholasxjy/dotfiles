local util = require("util")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    util.ensure_plugin("lazydev.nvim", function()
      require("lazydev").setup({
        library = {
          "~/.local/share/nvim/lazy/",
          { path = "luvit-meta/library", words = { "vim%.uv" } },
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "snacks.nvim", words = { "Snacks" } },
        },
      })
    end)
  end,
})
