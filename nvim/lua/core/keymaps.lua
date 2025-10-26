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

map({ "n" }, "<leader>k", "<cmd>w<cr>", { desc = "Save buffer", nowait = true, silent = true })

-- Buffers
map("n", "<leader>j", function()
  Snacks.bufdelete({ wipe = true })
end, { desc = "Delete buffer", nowait = true, silent = true })

map("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete other buffers" })

map("n", "<leader>q", ":q<cr>", { desc = "Quit", nowait = true })
map("n", "<leader>L", ":Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>M", ":Mason<cr>", { desc = "Mason" })

-- Clear search with <esc>
map({ "n", "i", "s" }, "<esc>", function()
  vim.cmd("noh")
  if vim.snippet then
    vim.snippet.stop()
  end
  return "<esc>"
end, { expr = true, desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

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
  Snacks.lazygit()
end, { desc = "Lazygit" })

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
-- better indenting
map("v", "<", "<gv", {})
map("v", ">", ">gv", {})

map("n", "i", function()
  return string.match(vim.api.nvim_get_current_line(), "%g") == nil and "cc" or "i"
end, { expr = true, noremap = true })

-- magic tricks
map({ "n", "v" }, "gh", "^", { desc = "Go to start of line", nowait = true })
map({ "n", "v" }, "gl", "$", { desc = "Go to end of line", nowait = true })
map({ "n", "v" }, "gm", "%", { desc = "Go to matching bracket", nowait = true })

-- Duplicate and comment first instance
map("n", "ycc", "yygccp", { remap = true, desc = "Duplicate current line and comment the first one out" })

-- Search only in visual area when in visual mode
map("x", "/", "<Esc>/\\%V", { desc = "Search only in visual area" })
