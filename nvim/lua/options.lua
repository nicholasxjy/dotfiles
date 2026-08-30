vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General ====================================================================
vim.o.mouse = "a" -- Enable mouse
vim.o.mousescroll = "ver:25,hor:6" -- Customize mouse scroll
vim.o.switchbuf = "usetab" -- Use already opened buffers when switching
vim.o.undofile = true -- Enable persistent undo
vim.o.clipboard = "unnamedplus" -- Use the system clipboard

vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

-- UI =========================================================================
vim.o.breakindent = true -- Indent wrapped lines to match line start
vim.o.breakindentopt = "list:-1" -- Add padding for lists (if 'wrap' is set)
vim.o.colorcolumn = "+1" -- Draw column on the right of maximum width
vim.o.cursorline = true -- Enable current line highlighting
vim.o.linebreak = true -- Wrap lines at 'breakat' (if 'wrap' is set)
vim.o.list = true -- Show helpful text indicators
vim.o.number = true -- Show line numbers
vim.o.pumheight = 10 -- Make popup menu smaller
vim.o.ruler = false -- Don't show cursor coordinates
vim.o.shortmess = "CFOSWaco" -- Disable some built-in completion messages
vim.o.showmode = false -- Don't show mode in command line
vim.o.signcolumn = "yes" -- Always show signcolumn (less flicker)
vim.o.splitbelow = true -- Horizontal splits will be below
vim.o.splitkeep = "screen" -- Reduce scroll during window split
vim.o.splitright = true -- Vertical splits will be to the right
vim.o.wrap = false -- Don't visually wrap lines (toggle with \w)

vim.o.cursorlineopt = "screenline,number" -- Show cursor line per screen line

-- Special UI symbols
vim.o.fillchars = "eob: ,fold:╌"
vim.o.listchars = "extends:…,nbsp:␣,precedes:…,tab:> "
vim.opt.foldenable = true
-- Treesitter 负责计算 fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- 打开文件时默认全部展开
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
-- 最大嵌套层级
vim.opt.foldnestmax = 10
-- fold 至少包含几行
vim.opt.foldminlines = 1
-- 折叠列
vim.opt.foldcolumn = "0"

vim.o.termguicolors = true

if vim.fn.has("nvim-0.10") == 1 then
  vim.o.foldtext = "" -- Show text under fold with its highlighting
end

vim.o.winborder = "solid" -- Use border in floating windows

vim.o.pummaxwidth = 100 -- Limit maximum width of popup menu
vim.o.completetimeout = 100

vim.o.pumborder = "single" -- Use border in built-in completion menu

require("vim._core.ui2").enable({ enable = true })

if vim.fn.has("nvim-0.13") == 1 then
  -- Try it out. Probably not a good idea since the "put" action has visible
  -- side effects so the temporary highlight is more distracting than useful.
  vim.cmd("autocmd TextPutPost * silent! lua vim.hl.hl_op()")

  vim.o.shortmess = "CFOSWacou" -- Add `u` flag to disable undo/redo messages

  vim.o.updatetime = 200 -- Ensure fast `current_line` diagnostic renders
end

-- Editing ====================================================================
vim.o.autoindent = true -- Use auto indent
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.formatoptions = "rqnl1j" -- Improve comment editing
vim.o.ignorecase = true -- Ignore case during search
vim.o.incsearch = true -- Show search matches while typing
vim.o.infercase = true -- Infer case in built-in completion
vim.o.shiftwidth = 2 -- Use this number of spaces for indentation
vim.o.smartcase = true -- Respect case if search pattern has upper case
vim.o.smartindent = true -- Make indenting smart
vim.o.spelllang = "en,uk,ru" -- Define spelling dictionaries
vim.o.spelloptions = "camel" -- Treat camelCase word parts as separate words
vim.o.tabstop = 2 -- Show tab as this number of spaces
vim.o.virtualedit = "block" -- Allow going past end of line in blockwise mode

vim.o.iskeyword = "@,48-57,_,192-255,-" -- Treat dash as `word` textobject part
vim.o.dictionary = vim.fn.stdpath("config") .. "/misc/dict/english.txt" -- Use specific dictionaries

-- Pattern for a start of 'numbered' list (used in `gw`). This reads as
-- "Start of list item is: at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space".
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- Built-in completion
vim.o.complete = ".,w,b,kspell" -- Use less sources
vim.o.completeopt = "menuone,noselect" -- Use custom behavior

if vim.fn.has("nvim-0.11") == 1 then
  vim.o.completeopt = "menuone,noselect,fuzzy,nosort"
end
