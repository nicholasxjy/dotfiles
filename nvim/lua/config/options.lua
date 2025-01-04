-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_blink_main = true
vim.g.ai_cmp = true
vim.g.trouble_lualine = true

vim.opt.pumblend = 0
vim.opt.updatetime = 200
vim.opt.wrap = true
vim.opt.laststatus = 3
vim.opt.showtabline = 2
vim.opt.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"

vim.opt.foldcolumn = "1" -- '0' is not bad
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
