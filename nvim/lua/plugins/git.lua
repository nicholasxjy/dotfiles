return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      current_line_blame = true,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(l, r, desc)
          vim.keymap.set("n", l, r, { buffer = buffer, desc = desc })
        end

        map("]h", gs.next_hunk, "Next Hunk")
        map("[h", gs.prev_hunk, "Prev Hunk")
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    event = { "VeryLazy" },
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
      "DiffviewClose",
    },
    keys = {
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
      { "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview File History" },
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
  },
}
