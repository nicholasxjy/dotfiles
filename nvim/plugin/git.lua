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

local function setup_diffbandit()
  loader.packadd("diffbandit.nvim")
  require("diffbandit").setup({
    navigation = {
      -- Keep Neovim's diagnostic navigation in editable diff buffers.
      document_keys = { top = false, bottom = false },
    },
  })
end

-- Register entry commands before loading the plugin, including its standalone launcher.
for _, spec in ipairs({
  { "DiffBandit", nargs = "+", complete = "file" },
  { "DiffBanditBuffers", nargs = "+" },
  { "DiffBanditFolderDiff", nargs = "+", complete = "dir" },
  { "DiffBanditGit", nargs = "*", complete = "file", git = true },
  { "DiffBanditGitCurrent", nargs = "*", complete = "file", git = true },
  { "DiffBanditCommitPanel", nargs = "*", complete = "file", git = true },
  { "DiffBanditGitMenu", nargs = "*", complete = "file", git = true },
  { "DiffBanditGitLog", nargs = "*", complete = "file", git = true },
  { "DiffBanditGitCommit", nargs = 1, git = true },
  { "DiffBanditGitCompare", nargs = "*", git = true },
  { "DiffBanditGitCheckout", nargs = "?", git = true },
  { "DiffBanditMerge", nargs = "?", complete = "file", git = true },
  { "DiffBanditClose", nargs = 0 },
  { "DiffBanditLaunch", nargs = 0 },
}) do
  local command = spec[1]
  vim.api.nvim_create_user_command(command, function(ctx)
    if spec.git and vim.fn.executable("git") ~= 1 then
      vim.notify("DiffBandit requires the git executable", vim.log.levels.WARN)
      return
    end
    if loader.load("diffbandit", setup_diffbandit) then
      vim.api.nvim_cmd({ cmd = command, args = ctx.fargs, mods = ctx.smods }, {})
    end
  end, { nargs = spec.nargs, complete = spec.complete, desc = "Open " .. command })
end

vim.keymap.set("n", "<leader>gD", "<cmd>DiffBanditGit<CR>", { desc = "Git Diff (DiffBandit)" })
vim.keymap.set("n", "<leader>gF", "<cmd>DiffBanditGitCurrent<CR>", { desc = "Git Diff File (DiffBandit)" })
vim.keymap.set("n", "<leader>gc", "<cmd>DiffBanditCommitPanel<CR>", { desc = "Git Commit Panel (DiffBandit)" })

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
