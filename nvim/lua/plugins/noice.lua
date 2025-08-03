return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      signature = { enabled = false },
      hover = { enabled = true },
    },
    notify = { enabled = false },
    cmdline = {
      view = "cmdline",
    },
    presets = {
      bottom_search = true,
      long_message_to_split = true,
      -- command_palette = {
      --   views = {
      --     cmdline_popup = {
      --       position = {
      --         row = "40%",
      --         col = "50%",
      --       },
      --     },
      --   },
      -- },
    },
  },
  keys = {
    {
      "<S-Enter>",
      function()
        require("noice").redirect(vim.fn.getcmdline())
      end,
      mode = "c",
      desc = "Redirect Cmdline",
    },
  },
  config = function(_, opts)
    -- HACK: noice shows messages from before it was enabled,
    -- but this is not ideal when Lazy is installing plugins,
    -- so clear the messages in this case.
    if vim.o.filetype == "lazy" then
      vim.cmd([[messages clear]])
    end
    require("noice").setup(opts)
  end,
}
