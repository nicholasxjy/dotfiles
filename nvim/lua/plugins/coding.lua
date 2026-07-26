local function config(name)
  return function()
    require("config." .. name)
  end
end

local function rustaceanvim_opts()
  return {
    tools = {
      float_win_config = { border = "rounded" },
    },
    server = {
      on_attach = function() end,
      default_settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = { enable = true },
          },
          checkOnSave = true,
          diagnostics = { enable = true },
          procMacro = {
            enable = true,
            ignored = {
              ["async-trait"] = { "async_trait" },
              ["napi-derive"] = { "napi" },
              ["async-recursion"] = { "async_recursion" },
            },
          },
          files = {
            excludeDirs = {
              ".direnv",
              ".git",
              ".github",
              ".gitlab",
              "bin",
              "node_modules",
              "target",
              "venv",
              ".venv",
            },
          },
        },
      },
    },
    dap = {
      adapter = function()
        local codelldb_path = vim.fn.exepath("codelldb")
        local os_name = vim.uv.os_uname().sysname
        local liblldb_path = vim.fn.expand("$HOME/.local/share/nvim/mason/share/lldb")
        if os_name:find("Windows") then
          liblldb_path = liblldb_path .. "\\bin\\lldb.dll"
        else
          liblldb_path = liblldb_path .. "/lib/liblldb" .. (os_name == "Linux" and ".so" or ".dylib")
        end
        return require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
      end,
    },
  }
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = config("treesitter"),
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "astro",
      "blade",
      "dot",
      "elixir",
      "eruby",
      "glimmer",
      "handlebars",
      "hbs",
      "heex",
      "html",
      "htmlangular",
      "htmldjango",
      "javascript",
      "javascript.glimmer",
      "javascript.jsx",
      "javascriptreact",
      "liquid",
      "markdown",
      "php",
      "rescript",
      "rust",
      "svelte",
      "templ",
      "twig",
      "typescript",
      "typescript.glimmer",
      "typescript.tsx",
      "typescriptreact",
      "vento",
      "vue",
      "xml",
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = config("treesitter-autotag"),
  },
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
  },
  {
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = config("matchup"),
  },
  {
    "saghen/blink.pairs",
    event = "VeryLazy",
    dependencies = { "saghen/blink.lib" },
    build = function()
      require("blink.pairs").build():pwait(60000)
    end,
    config = config("blink-pairs"),
  },
  {
    "saghen/blink.indent",
    event = "VeryLazy",
    config = config("blink-indent"),
  },
  {
    "saghen/blink.cmp",
    event = { "BufReadPre", "BufNewFile", "CmdlineEnter" },
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
      },
      "saghen/blink.lib",
      "nvim-mini/mini.icons",
    },

    build = function()
      require("blink.cmp").build():pwait(60000)
    end,
    config = config("blink"),
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    config = config("lazydev"),
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile", "FileType" },
    dependencies = { "saghen/blink.cmp", "mason-org/mason.nvim" },
    config = function()
      require("lsp")
    end,
  },
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonToolsInstall" },
    keys = {
      { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" },
    },
    config = config("mason"),
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>cf", mode = { "n", "v", "x" }, desc = "Format Code" },
    },
    config = config("conform"),
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = config("lint"),
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^9",
    ft = "rust",
    init = function()
      vim.g.rustaceanvim = rustaceanvim_opts
    end,
    config = function()
      if vim.fn.executable("rust-analyzer") == 0 then
        vim.notify("rust-analyzer not found in PATH", vim.log.levels.ERROR, { title = "rustaceanvim" })
      end
    end,
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml", "BufNewFile Cargo.toml" },
    opts = {
      completion = {
        crates = { enabled = true },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },
  {
    "nicholasxjy/rainbow-tags.nvim",
    ft = { "typescriptreact", "javascriptreact", "tsx" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = config("rainbow-tags"),
  },
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
  },
}
