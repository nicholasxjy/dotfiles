return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      signature = {
        enabled = vim.g.cmp_engine == "cmp",
      },
      hover = {
        enabled = true,
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        opts = { skip = true },
      },
    },
    presets = {
      bottom_search = false,
      long_message_to_split = true,
      lsp_doc_border = false,
      command_palette = {
        views = {
          cmdline_popup = {
            position = {
              row = "50%",
              col = "50%",
            },
          },
        },
      },
    },
    views = {
      mini = {
        win_options = {
          winblend = 0,
        },
      },
    },
  },
  config = function(_, opts)
    require("noice").setup(opts)
  end,
}
