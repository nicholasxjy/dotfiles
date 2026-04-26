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

local unmap = vim.keymap.del

local function safe_unmap(mode, lhs)
  pcall(unmap, mode, lhs)
end

-- remove default keybindings that cause `gr` delay
safe_unmap("n", "gri")
safe_unmap("n", "grr")
safe_unmap("n", "gra")
safe_unmap("n", "grn")
safe_unmap("n", "grt")
safe_unmap("n", "grx")

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Taller Split" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Shorter Split" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Narrower Split" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Wider Split" })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
-- Buffers
map("n", "<leader>j", function()
  Snacks.bufdelete({ wipe = true })
end, { desc = "Delete Buffer" })

map({ "n", "i", "x", "s" }, "<leader>k", "<cmd>w<cr><esc>", { desc = "Save" })

map("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })

map("n", "<leader>q", ":q<cr>", { desc = "Quit" })
map("n", "<leader>M", ":Mason<cr>", { desc = "Mason" })

-- Clear search with <esc>
map({ "n", "i", "s" }, "<esc>", function()
  vim.cmd("noh")
  if vim.snippet then
    vim.snippet.stop()
  end
  return "<esc>"
end, { expr = true, desc = "Clear Search" })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save" })

map("n", "L", ":bnext<cr>", { desc = "Next Buffer" })
map("n", "H", ":bprevious<cr>", { desc = "Prev Buffer" })

-- windows
map("n", "<leader>-", "<C-W>s", { desc = "Split Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Right", remap = true })

-- Terminal/Run...
map("n", "<c-/>", function()
  Snacks.terminal()
end, { desc = "Terminal" })
map("n", "<c-_>", function()
  Snacks.terminal()
end, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Close Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

map("n", "<leader>gg", function()
  Snacks.lazygit()
end, { desc = "Lazygit" })

-- better indenting
map("v", "<", "<gv", {})
map("v", ">", ">gv", {})

-- magic tricks
map({ "n", "v" }, "gh", "^", { desc = "Line Start", nowait = true })
map({ "n", "v" }, "gl", "$", { desc = "Line End", nowait = true })
map({ "n", "v" }, "gm", "%", { desc = "Match Pair", nowait = true })

-- Duplicate and comment first instance
map("n", "ycc", "yygccp", { remap = true, desc = "Duplicate and Comment" })

-- Search only in visual area when in visual mode
map("x", "/", "<Esc>/\\%V", { desc = "Search Selection" })

map("n", "<leader>um", ":messages<cr>", { desc = "Show messages" })
