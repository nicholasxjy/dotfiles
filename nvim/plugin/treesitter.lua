vim.pack.add({
  "https://github.com/romus204/tree-sitter-manager.nvim",
})

require("tree-sitter-manager").setup({
  parser_dir = vim.fn.stdpath("data") .. "/site/parser",
  query_dir = vim.fn.stdpath("data") .. "/site/queries",
  assume_installed = {}, -- blacklist languages
  ensure_installed = {
    "bash",
    "c",
    "diff",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "luadoc",
    "luap",
    "markdown",
    "markdown_inline",
    "printf",
    "python",
    "query",
    "regex",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
    "git_config",
    "gitcommit",
    "git_rebase",
    "gitignore",
    "gitattributes",
    "typst",
    "go",
    "rust",
    "java",
    "javadoc",
  }, -- parsers to install at startup
  auto_install = true, -- auto-install when a new filetype is encountered
  noauto_install = {}, -- blacklist from auto_install
  highlight = true, -- enable treesitter highlighting (use list to whitelist)
  nohighlight = {}, -- blacklist from highlight
  languages = {}, -- override or add new parser sources
  nerdfont = true, -- use Nerd Font icons in the manager UI
  border = "rounded", -- border style for the TUI window
  min_width = 78, -- minimum size of the TUI
  min_height = 40,
})
