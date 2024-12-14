local snacks = require("snacks")
--- Map a key combination to a command
---@param modes string|string[]: The mode(s) to map the key combination to
---@param lhs string: The key combination to map
---@param rhs string|function: The command to run when the key combination is pressed
---@param opts table: Options to pass to the keymap
local map = function(modes, lhs, rhs, opts)
  local options = { silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  if type(modes) == "string" then
    modes = { modes }
  end
  for _, mode in ipairs(modes) do
    vim.keymap.set(mode, lhs, rhs, options)
  end
end

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

map({ "n" }, "<leader>w", "<cmd>w<cr>", { desc = "Save buffer", nowait = true })
-- Buffers
map("n", "<leader>dd", function()
  snacks.bufdelete({ wipe = true })
end, { desc = "Delete buffer", nowait = true })

map("n", "<leader>q", ":q<cr>", { desc = "Quit", nowait = true })
-- Clear search with <esc>
map("n", "<esc>", ":noh<cr><esc>", { desc = "Escape and clear hlsearch" })

map("n", "L", ":bnext<cr>", { desc = "Next buffer" })
map("n", "H", ":bprevious<cr>", { desc = "Previous buffer" })

-- windows
map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- Terminal/Run...
map("n", "<c-/>", function()
  Snacks.terminal()
end, { desc = "Terminal (cwd)" })
map("n", "<c-_>", function()
  Snacks.terminal()
end, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

map("n", "<leader>gg", function()
  snacks.lazygit()
end, { desc = "Lazygit" })

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
-- better indenting
map("v", "<", "<gv", {})
map("v", ">", ">gv", {})

map("n", "<leader>gb", function()
  Snacks.git.blame_line()
end, { desc = "Git Blame Line" })

map("n", "i", function()
  return string.match(vim.api.nvim_get_current_line(), "%g") == nil and "cc" or "i"
end, { expr = true, noremap = true })

map(
  { "n", "t" },
  "<C-h>",
  "<CMD>NavigatorLeft<CR>",
  { desc = "Navigate Left", silent = true, noremap = true, nowait = true }
)
map(
  { "n", "t" },
  "<C-l>",
  "<CMD>NavigatorRight<CR>",
  { desc = "Navigate Right", silent = true, noremap = true, nowait = true }
)
map(
  { "n", "t" },
  "<C-k>",
  "<CMD>NavigatorUp<CR>",
  { desc = "Navigate Up", silent = true, noremap = true, nowait = true }
)
map(
  { "n", "t" },
  "<C-j>",
  "<CMD>NavigatorDown<CR>",
  { desc = "Navigate Down", silent = true, noremap = true, nowait = true }
)
