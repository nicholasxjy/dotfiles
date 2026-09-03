local loader = require("loader")
local util = require("util")

util.build_fn_on_change("blink.cmp", { "install", "update" }, function()
  loader.packadd("blink.lib", "blink.cmp")
  ---@diagnostic disable-next-line: undefined-field
  require("blink.cmp").build():pwait(60000)
end)

util.build_cmd_on_change("LuaSnip", { "install", "update" }, { "make", "install_jsregexp" })

util.build_fn_on_change("markdown-preview.nvim", { "install", "update" }, function()
  loader.packadd("markdown-preview.nvim")
  vim.fn["mkdp#util#install"]()
end)

util.build_fn_on_change("nvim-treesitter", "update", function()
  loader.packadd("nvim-treesitter")
  require("nvim-treesitter").update()
end)

-- `vim.pack` only installs and registers here; nothing is put on 'runtimepath'.
-- Each plugin is `:packadd`ed by its own config under `plugin/`, at the moment
-- it is actually needed. Adding a plugin below therefore also requires a
-- `loader.packadd(...)` call in the config that owns it.
local function noop() end

vim.pack.add({
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/folke/snacks.nvim",
  { src = "https://github.com/nicholasxjy/minibuffer.nvim", version = "feat/snacks-picker-integration" },
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mrjones2014/smart-splits.nvim",

  "https://github.com/FylerOrg/fyler.nvim",
  "https://github.com/gen740/SmoothCursor.nvim",

  "https://github.com/windwp/nvim-autopairs",

  "https://github.com/folke/which-key.nvim",
  "https://github.com/nicholasxjy/sidekick.nvim",

  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp",

  "http://github.com/2KAbhishek/nerdy.nvim",
  "https://github.com/arnamak/stay-centered.nvim",
  "https://github.com/folke/ts-comments.nvim",
  "https://github.com/nemanjamalesija/smart-paste.nvim",
  "https://github.com/nicholasxjy/jishiben.nvim",
  "https://github.com/nicholasxjy/translator.nvim",
  "https://github.com/Wansmer/treesj",
  "https://github.com/nicholasxjy/modes.nvim",
  "https://github.com/b0o/SchemaStore.nvim",
  "https://github.com/mfussenegger/nvim-jdtls",
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/ibhagwan/fzf-lua",

  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/undont/differ.nvim",

  "https://github.com/MagicDuck/grug-far.nvim",
  "https://github.com/rrethy/vim-illuminate",
  "https://github.com/mfussenegger/nvim-lint",
  "https://github.com/nvim-lualine/lualine.nvim",

  -- "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/iamcco/markdown-preview.nvim",
  "https://github.com/delphinus/md-render.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/delphinus/budoux.lua",

  "https://github.com/andymass/vim-matchup",

  "https://github.com/brenoprata10/nvim-highlight-colors",
  "https://github.com/NStefan002/screenkey.nvim",
  "https://github.com/folke/todo-comments.nvim",

  "https://github.com/nvim-mini/mini.tabline",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.files",
  "https://github.com/nvim-mini/mini.surround",
  "https://github.com/nvim-mini/mini.trailspace",
  "https://github.com/nvim-mini/mini.ai",
  "https://github.com/nvim-mini/mini.notify",
  "https://github.com/nvim-mini/mini.statuscolumn",

  "https://github.com/jake-stewart/multicursor.nvim",
  "https://github.com/nicholasxjy/rainbow-tags.nvim",
  "https://github.com/Saecki/crates.nvim",
  { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^9") },
  "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
  "https://github.com/nicholasxjy/zed-bar.nvim",

  "https://github.com/nicholasxjy/mini.hues",
  "https://github.com/folke/tokyonight.nvim",
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
}, { load = noop })
