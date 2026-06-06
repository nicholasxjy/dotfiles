require("tree-sitter-manager").setup({
  -- Default Options
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
  }, -- list of parsers to install at the start of a neovim session. If set to "all", install all parsers.
  -- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
  auto_install = true, -- if enabled, install missing parsers when editing a new file
  highlight = true, -- treesitter highlighting is enabled by default
  -- languages = {}, -- override or add new parser sources
})
