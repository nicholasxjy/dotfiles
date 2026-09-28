local loader = require("loader")

loader.defer_buffer("git", function()
  loader.packadd("differ.nvim", "gitsigns.nvim", "lazygit.nvim", "fzf-lua")

  local gs = require("gitsigns")
  gs.setup({
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "-" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "?" },
    },
    signcolumn = true,
    current_line_blame = true,
    on_attach = function(buffer)
      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = buffer, desc = desc })
      end

      map("]h", function()
        gs.nav_hunk("next")
      end, "Next Hunk")
      map("[h", function()
        gs.nav_hunk("prev")
      end, "Prev Hunk")
    end,
  })

  require("differ").setup({
    layout = "split",
    context = math.huge,
    wrap = true,
    diff_counter = true,
    cursorline_tint = true,
    deep_diff = {
      enabled = true,
      granularity = "word",
      similarity_threshold = 0.5,
    },
    merge = {
      layout = "default",
    },
    relative_dates = false,
    base = nil,
    sidecar_bin = nil,
    command_alias = nil,
  })

  -- LazyGit
  vim.g.lazygit_floating_window_winblend = 0
  vim.g.lazygit_floating_window_scaling_factor = 0.95
  vim.g.lazygit_floating_window_border_chars = { "", "", "", "", "", "", "", "" }
  vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

  -- Git pickers
  local fzflua = require("fzf-lua")
  vim.keymap.set("n", "<leader>gb", fzflua.git_branches, { desc = "Git Branches" })
  vim.keymap.set("n", "<leader>gl", fzflua.git_commits, { desc = "Git Log" })
  vim.keymap.set("n", "<leader>gs", fzflua.git_status, { desc = "Git Status" })
  vim.keymap.set("n", "<leader>gS", fzflua.git_stash, { desc = "Git Stash" })
  vim.keymap.set("n", "<leader>gd", fzflua.git_hunks, { desc = "Git Diff (Hunks)" })
  vim.keymap.set("n", "<leader>gf", fzflua.git_bcommits, { desc = "Git Log File" })
end, { schedule = true })
