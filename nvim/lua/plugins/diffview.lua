return {
  "sindrets/diffview.nvim",
  event = "LazyFile",
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
    "DiffviewClose",
  },
  keys = {
    { "<leader>mdo", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
    { "<leader>mdf", "<cmd>DiffviewFileHistory<cr>", desc = "Open diffview file history" },
    { "<leader>mdc", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = { winbar_info = true },
      file_history = { winbar_info = true },
    },
    hooks = {
      diff_buf_read = function(bufnr)
        vim.b[bufnr].view_activated = false
      end,
    },
  },
}
