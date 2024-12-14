vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.autoformat = true

local opt = vim.opt

-- UI/General
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.cursorline = true
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.confirm = true
opt.mouse = "a"
opt.undofile = true
opt.swapfile = false
opt.conceallevel = 1
opt.scrolloff = 12
opt.wrap = true
opt.linebreak = true
opt.showtabline = 0

-- Set tab width
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.expandtab = true

opt.pumblend = 0
opt.updatetime = 200
opt.laststatus = 3
-- -- Make cursor blink
-- opt.guicursor = {
--     "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50",
--     "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
--     "sm:block-blinkwait175-blinkoff150-blinkon175",
-- }
