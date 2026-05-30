local fzf = require("fzf-lua")
fzf.setup({
  "border-fused",
  fzf_colors = true,
  defaults = {
    formatter = "path.filename_first",
  },
  winopts = {
    height = 1,
    width = 0.9,
    row = 1,
    border = "single",
    backdrop = 50,
    preview = {
      border = "single",
      wrap = true,
      hidden = false,
      layout = "vertical",
      vertical = "up:50%",
    },
  },
  files = {
    multiprocess = true,
  },
  diagnostics = {
    cwd_only = true,
  },
  debug = false,
})

local function call_fzf(method, opts)
  return function()
    return fzf[method](opts)
  end
end

local map = vim.keymap.set
local mini_pick = {
  height = 0.4,
  width = 0.7,
  row = 0.5,
  border = "none",
  backdrop = 70,
}

local mappings = {
  { "<leader>R", "resume", nil, "Fzf resume" },
  { "<leader>/", "grep_curbuf", nil, "Grep current buffer" },
  { "<leader>:", "commands", nil, "Commands" },
  { "<leader>m", "marks", { winopts = mini_pick, previewer = false }, "Marks" },
  { "<leader>fb", "buffers", { cwd_only = true }, "Buffers" },
  { "<leader>fc", "colorschemes", nil, "Colorschemes" },
  { "<leader>fq", "quickfix", nil, "Quickfix" },
  { "<leader>fl", "loclist", nil, "Location List" },
  { "<leader>fg", "global", nil, "Global Search" },
  { "<leader>fa", "autocmds", nil, "Autocmds" },
  { "<leader>fk", "keymaps", nil, "Keymaps" },
  { "<leader>fj", "jumps", nil, "Jumps" },
  { "<leader>fr", "registers", nil, "Registers" },
  { "<leader>gf", "git_files", nil, "Git Files" },
  { "<leader>gb", "git_branches", nil, "Git Branches" },
  { "<leader>gc", "git_commits", nil, "Git Commits" },
  { "<leader>gC", "git_bcommits", nil, "Buffer Commits" },
  { "<leader>gs", "git_status", nil, "Git Status" },
  { "<leader>gd", "git_diff", nil, "Git Diff" },
  { "<leader>gB", "git_blame", nil, "Git Blame" },
  { "<leader>gt", "git_tags", nil, "Git Tags" },
  { "<leader>gh", "git_hunks", nil, "Git Hunks" },
  { "<leader>gw", "git_worktrees", nil, "Git Worktrees" },
}

for _, mapping in ipairs(mappings) do
  map("n", mapping[1], call_fzf(mapping[2], mapping[3]), { desc = mapping[4] })
end
