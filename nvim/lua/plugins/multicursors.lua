return {
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvimtools/hydra.nvim",
    },
    opts = {
      hint_config = {
        float_opts = {
          border = "rounded",
        },
      },
    },
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "v", "n" },
        "<leader>mw",
        "<cmd>MCstart<cr>",
        desc = "Select word under the cursor",
      },
      {
        mode = { "v", "n" },
        "<leader>mc",
        "<cmd>MCunderCursor<cr>",
        desc = "Select char under the cursor",
      },
    },
  },
}
