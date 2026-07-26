require("render-markdown").setup({
  file_types = { "markdown" },
  completions = { blink = { enabled = true }, lsp = { enabled = false } },
  code = {
    -- width = "block",
  },
})
