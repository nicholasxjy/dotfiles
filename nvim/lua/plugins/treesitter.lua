return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
          max_lines = 4,
          multiline_threshold = 2,
        },
      },
    },
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      -- Install core parsers at startup
      ts.install({
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

        -- "query",
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
      }, {
        max_jobs = 8,
      })

      local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

      -- Auto-install parsers and enable highlighting on FileType
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        desc = "Enable treesitter highlighting and indentation",
        callback = function(event)
          local lang = vim.treesitter.language.get_lang(event.match) or event.match
          local buf = event.buf

          -- Start highlighting immediately (works if parser exists)
          pcall(vim.treesitter.start, buf, lang)

          -- Enable treesitter indentation
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

          -- Install missing parsers (async, no-op if already installed)
          -- ts.install({ lang })
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    branch = "main",
    keys = function()
      local move = require("nvim-treesitter-textobjects.move")
      return {
        {
          "]a",
          function()
            move.goto_next_start("@parameter.inner", "textobjects")
          end,
          mode = { "n", "x", "o" },
          desc = "next args(start)",
        },
        {
          "[a",
          function()
            move.goto_previous_start("@parameter.inner", "textobjects")
          end,
          mode = { "n", "x", "o" },
          desc = "prev args(start)",
        },
        {
          "]A",
          function()
            move.goto_next_end("@parameter.inner", "textobjects")
          end,
          mode = { "n", "x", "o" },
          desc = "next args(end)",
        },
        {
          "[A",
          function()
            move.goto_previous_end("@parameter.inner", "textobjects")
          end,
          mode = { "n", "x", "o" },
          desc = "prev args(end)",
        },
        {
          "]c",
          function()
            move.goto_next_start("@class.outer", "textobjects")
          end,
          mode = { "n", "x", "o" },
          desc = "next class(start)",
        },
        {
          "]C",
          function()
            move.goto_next_end("@class.outer", "textobjects")
          end,
          mode = { "n", "x", "o" },
          desc = "next class(end)",
        },
        {
          "[c",
          function()
            move.goto_previous_start("@class.outer", "textobjects")
          end,
          mode = { "n", "x", "o" },
          desc = "prev class(start)",
        },
        {
          "[C",
          function()
            move.goto_previous_end("@class.outer", "textobjects")
          end,
          mode = { "n", "x", "o" },
          desc = "prev class(end)",
        },
        {
          "]f",
          function()
            move.goto_next_start("@function.outer", "textobjects")
          end,
          mode = { "n", "x", "o" },
          desc = "next func(start)",
        },
        {
          "]F",
          function()
            move.goto_next_end("@function.outer", "textobjects")
          end,
          mode = { "n", "x", "o" },
          desc = "next func(end)",
        },
        {
          "[f",
          function()
            move.goto_previous_start("@function.outer", "textobjects")
          end,
          mode = { "n", "x", "o" },
          desc = "prev func(start)",
        },
        {
          "[F",
          function()
            move.goto_previous_end("@function.outer", "textobjects")
          end,
          mode = { "n", "x", "o" },
          desc = "next func(end)",
        },
      }
    end,
  },
}
