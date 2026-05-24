-- pack install
local eager_specs = {
  "https://github.com/folke/snacks.nvim",

  "https://github.com/arborist-ts/arborist.nvim",

  "https://github.com/folke/lazydev.nvim",

  "https://github.com/nicholasxjy/mini.hues",
  "https://github.com/nicholasxjy/mini.statusline",

  "https://github.com/nicholasxjy/rainbow-tags.nvim",

  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.files",
  "https://github.com/nvim-mini/mini.tabline",
  "https://github.com/nvim-mini/mini.surround",
  "https://github.com/nvim-mini/mini.trailspace",

  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/saghen/blink.download",
  { src = "https://github.com/saghen/blink.pairs", version = vim.version.range("*") },

  "http://github.com/folke/which-key.nvim",

  "https://github.com/folke/ts-comments.nvim",

  "https://github.com/kevinhwang91/promise-async",
  "https://github.com/nvim-lua/plenary.nvim",

  { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^9") },
}

local lazy_specs = {
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nicholasxjy/translator.nvim",
  "https://github.com/rrethy/vim-illuminate",
  "https://github.com/b0o/SchemaStore.nvim",
  "https://github.com/mfussenegger/nvim-jdtls",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/mfussenegger/nvim-lint",
  "https://github.com/Saecki/crates.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/MagicDuck/grug-far.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/iamcco/markdown-preview.nvim",
  "https://github.com/mrjones2014/smart-splits.nvim",
  "https://github.com/jake-stewart/multicursor.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/rcarriga/nvim-notify",
  "https://github.com/nicholasxjy/lsp-progress-notify.nvim",
  "https://github.com/andymass/vim-matchup",
  "https://github.com/mcauley-penney/visual-whitespace.nvim",
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
  "https://github.com/kevinhwang91/nvim-ufo",
  "https://github.com/Wansmer/treesj",
  "https://github.com/nicholasxjy/jishiben.nvim",
  "https://github.com/NStefan002/screenkey.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/barrettruth/diffs.nvim",
  "https://github.com/esmuellert/codediff.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/gbprod/yanky.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/nicholasxjy/colorful-menu.nvim",
  "https://github.com/brenoprata10/nvim-highlight-colors",
  "https://github.com/nicholasxjy/sidekick.nvim",
  "https://github.com/mvllow/modes.nvim",
  "https://github.com/vieitesss/minifugit.nvim",
}

local function defer_load() end

vim.pack.add(eager_specs)
vim.pack.add(lazy_specs, { load = defer_load })
