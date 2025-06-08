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
    "axkirillov/unified.nvim",
    event = "VeryLazy",
    cmd = { "Unified" },
    keys = {
      { "<leader>gd", "<cmd>Unified<cr>", desc = "Git diff" },
    },
    config = function()
      require("unified").setup({
        signs = {
          add = "│",
          delete = "│",
          change = "│",
        },
        highlights = {
          add = "DiffAdd",
          delete = "DiffDelete",
          change = "DiffChange",
        },
        line_symbols = {
          add = "+",
          delete = "-",
          change = "~",
        },
        auto_refresh = true, -- Whether to automatically refresh diff when buffer changes
      })
    end,
  },
}
