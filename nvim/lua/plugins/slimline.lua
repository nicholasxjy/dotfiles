return {
  "sschleemilch/slimline.nvim",
  event = "VeryLazy",
  enabled = false,
  opts = {
    style = "fg",
    bold = true,
    configs = {
      diagnostics = {
        workspace = true,
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
          primary = "String",
        },
      },
    },
  },
}
