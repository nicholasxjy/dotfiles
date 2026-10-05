local loader = require("loader")

-- Gitsigns decorates file buffers and attaches to already-loaded ones on setup.
loader.defer_buffer("gitsigns", function()
  loader.packadd("gitsigns.nvim")

  local gs = require("gitsigns")
  gs.setup({
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "-" },
      topdelete = { text = "" },
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
end, { schedule = true })

-- Git tools work without a file buffer (e.g. `nvim` in a repo root).
loader.on_very_lazy("git-tools", function()
  loader.packadd("differ.nvim")

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
  })

  -- LazyGit reads these when it opens; set them before its plugin/ file defaults them.
  vim.g.lazygit_floating_window_winblend = 0
  vim.g.lazygit_floating_window_scaling_factor = 0.95
  vim.g.lazygit_floating_window_border_chars = { "", "", "", "", "", "", "", "" }
  loader.packadd("lazygit.nvim")
  vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

  -- fzf-lua is configured by plugin/search.lua on VeryLazy.
  local function picker(name)
    return function()
      loader.packadd("fzf-lua")
      require("fzf-lua")[name]()
    end
  end

  vim.keymap.set("n", "<leader>gb", picker("git_branches"), { desc = "Git Branches" })
  vim.keymap.set("n", "<leader>gl", picker("git_commits"), { desc = "Git Log" })
  vim.keymap.set("n", "<leader>gs", picker("git_status"), { desc = "Git Status" })
  vim.keymap.set("n", "<leader>gS", picker("git_stash"), { desc = "Git Stash" })
  vim.keymap.set("n", "<leader>gd", picker("git_hunks"), { desc = "Git Diff (Hunks)" })
  vim.keymap.set("n", "<leader>gf", picker("git_bcommits"), { desc = "Git Log File" })
end)
