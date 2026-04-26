require("render-markdown").setup({
  file_types = { "markdown" },
  completions = { blink = { enabled = false }, lsp = { enabled = true } },
  code = {
    width = "block",
    right_pad = 1,
  },
})
