require("lazydev").setup({
  library = {
    "~/.local/share/nvim/lazy/",
    { path = "luvit-meta/library", words = { "vim%.uv" } },
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "snacks.nvim", words = { "Snacks" } },
  },
})
