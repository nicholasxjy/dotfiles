return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "?" },
      },
      signcolumn = false,
      current_line_blame = true,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        if not gs then
          return
        end

        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = buffer, desc = desc })
        end

        map("]h", gs.next_hunk, "Next Hunk")
        map("[h", gs.prev_hunk, "Prev Hunk")
      end,
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },

  {
    "barrettruth/diffs.nvim",
    cmd = { "Gdiff", "Gvdiff", "Ghdiff", "Greview" },
    event = "VeryLazy",
    init = function()
      vim.g.diffs = {
        integrations = {
          fugitive = true,
          neogit = true,
          neojj = true,
          gitsigns = true,
        },
      }
    end,
  },

  {
    "esmuellert/codediff.nvim",
    cmd = { "CodeDiff", "VscodeDiff" },
    event = "VeryLazy",
    opts = {
      explorer = {
        view_mode = "tree",
      },
      history = {
        view_mode = "tree",
      },
    },
  },
}
