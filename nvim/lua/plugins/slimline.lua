return {
  "sschleemilch/slimline.nvim",
  event = "VeryLazy",
  opts = {
    style = "fg",
    bold = true,
    hl = {
      secondary = "Comment",
    },
    configs = {
      mode = {
        hl = {
          normal = "Type",
          visual = "Keyword",
          insert = "Function",
          replace = "Statement",
          command = "String",
          other = "Function",
        },
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
      diagnostics = {
        workspace = true,
      },
      filetype_lsp = {
        hl = {
          primary = "String",
        },
      },
    },
  },
}
