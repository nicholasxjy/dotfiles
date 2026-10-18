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

local function setup_lazygit()
  vim.g.lazygit_floating_window_winblend = 0
  vim.g.lazygit_floating_window_scaling_factor = 0.95
  vim.g.lazygit_floating_window_border_chars = { "", "", "", "", "", "", "", "" }
  loader.packadd("plenary.nvim", "lazygit.nvim")
end

for _, command in ipairs({
  "LazyGit",
  "LazyGitLog",
  "LazyGitCurrentFile",
  "LazyGitFilter",
  "LazyGitFilterCurrentFile",
  "LazyGitConfig",
}) do
  vim.api.nvim_create_user_command(command, function(ctx)
    if vim.fn.executable("lazygit") ~= 1 then
      vim.notify("LazyGit requires the lazygit executable", vim.log.levels.WARN)
      return
    end
    if loader.load("lazygit", setup_lazygit) then
      vim.api.nvim_cmd({ cmd = command, args = ctx.fargs, mods = ctx.smods }, {})
    end
  end, { desc = "Open " .. command })
end

vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

-- Git tools work without a file buffer (e.g. `nvim` in a repo root).
loader.on_very_lazy("git-tools", function()
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
