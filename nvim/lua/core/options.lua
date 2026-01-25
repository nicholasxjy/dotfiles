vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.autoformat = true
vim.g.inlay_hints = true
vim.g.codelens = true
vim.g.copilot_enabled = true

vim.g.picker = "snacks"

vim.g.transparent = false
vim.g.bordered = false
vim.o.winborder = "rounded"
vim.o.background = "dark"

local opt = vim.opt
-- UI/General
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.cursorline = true
opt.cursorcolumn = false
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.confirm = true
opt.mouse = "a"
opt.undofile = true
opt.swapfile = false
opt.conceallevel = 1
opt.scrolloff = 8
opt.linebreak = true
opt.showtabline = 0

-- Set tab width
opt.tabstop = 2
opt.shiftwidth = 2
opt.autoindent = true
opt.expandtab = true

opt.updatetime = 200
opt.laststatus = 3

opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = true -- Disable line wrap
opt.undolevels = 10000
opt.timeoutlen = 300 -- Lower than default (1000) to quickly trigger which-key

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

vim.o.statuscolumn = "%!v:lua.require('core.statuscolumn').setup()"
