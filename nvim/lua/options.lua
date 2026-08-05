vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Nvim probes for these interpreters on demand; none of the plugins here use
-- them, so skip the probe entirely.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Built-in plugins that are either unused or superseded.
-- `matchparen`/`matchit` in particular re-scan for the pair under the cursor on
-- every move; vim-matchup and blink.pairs already do that work.
vim.g.loaded_gzip = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_zipPlugin = 1

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.cursorline = true
opt.clipboard = "unnamedplus"
opt.confirm = true
opt.autoread = true
opt.mouse = "a"
opt.undofile = true
opt.swapfile = false
opt.conceallevel = 1
opt.linebreak = true

opt.winborder = "rounded"

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.updatetime = 200
opt.laststatus = 3

opt.redrawtime = 1500 -- Give up on syntax redraw instead of blocking on huge lines
opt.synmaxcol = 300 -- Only relevant for the regex-syntax fallback, Tree-sitter ignores it

opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = true
opt.undolevels = 10000

opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
