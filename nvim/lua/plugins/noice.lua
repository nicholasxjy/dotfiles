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
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      signature = { enabled = false },
      hover = { enabled = true },
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
              row = "80%",
              col = "50%",
            },
          },
        },
      },
    },
  },
}
