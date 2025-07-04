return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
    },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = { enable = true },
      textobjects = {
        select = {
          enable = false,
          -- lookahead = true,
          -- keymaps = {
          --   ["ak"] = { query = "@block.outer", desc = "around block" },
          --   ["ik"] = { query = "@block.inner", desc = "inside block" },
          --   ["ac"] = { query = "@class.outer", desc = "around class" },
          --   ["ic"] = { query = "@class.inner", desc = "inside class" },
          --   ["a?"] = { query = "@conditional.outer", desc = "around conditional" },
          --   ["i?"] = { query = "@conditional.inner", desc = "inside conditional" },
          --   ["af"] = { query = "@function.outer", desc = "around function " },
          --   ["if"] = { query = "@function.inner", desc = "inside function " },
          --   ["ao"] = { query = "@loop.outer", desc = "around loop" },
          --   ["io"] = { query = "@loop.inner", desc = "inside loop" },
          --   ["aa"] = { query = "@parameter.outer", desc = "around argument" },
          --   ["ia"] = { query = "@parameter.inner", desc = "inside argument" },
          -- },
        },
        move = {
          enable = false,
          -- goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          -- goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          -- goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          -- goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
      ensure_installed = {
        "bash",

        "dockerfile",

        "fish",

        "git_config",
        "gitcommit",
        "git_rebase",
        "gitignore",
        "gitattributes",

        "go",
        "gomod",
        "gowork",
        "gosum",

        "c",
        "diff",

        "html",
        "css",

        "javascript",
        "jsdoc",
        "tsx",
        "typescript",

        "json",
        "jsonc",
        "json5",

        "lua",
        "luadoc",
        "luap",

        "markdown",
        "markdown_inline",

        "printf",

        "python",
        "ninja",
        "rst",

        "query",
        "regex",
        "toml",

        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "typst",

        "rust",
        "ron",

        "java",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      vim.treesitter.language.register("scss", "less")
      vim.treesitter.language.register("scss", "postcss")
    end,
  },
}
