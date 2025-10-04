return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
        ["vim.lsp.util.stylize_markdown"] = false,
        ["cmp.entry.get_documentation"] = false,
      },
      signature = { enabled = false },
      hover = { enabled = false },
    },
    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = vim.g.transparent, -- add a border to hover docs and signature help
      command_palette = {
        views = {
          cmdline_popup = {
            position = {
              row = "85%",
              col = "50%",
            },
          },
        },
      },
    },
  },
}
