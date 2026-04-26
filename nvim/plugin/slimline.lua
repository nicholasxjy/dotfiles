require("slimline").setup({
  style = "fg",
  bold = true,
  configs = {
    mode = {
      verbose = true,
    },
    path = {
      hl = {
        primary = "Label",
      },
    },
    git = {
      hl = {
        primary = "Function",
      },
    },
    filetype_lsp = {
      hl = {
        primary = "Keyword",
      },
    },
    diagnostic = {
      workspace = true,
    },
  },
})
