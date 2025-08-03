return {
  {
    "mason-org/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    build = ":MasonUpdate",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        max_concurrent_installers = 6,
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "BufReadPost",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "jay-babu/mason-null-ls.nvim",
      "mfussenegger/nvim-dap",
      "jay-babu/mason-nvim-dap.nvim",
    },
    opts = {
      auto_update = true,
      ensure_installed = {
        "lua-language-server",
        "stylua",

        "dockerfile-language-server",
        "docker-compose-language-service",

        "bash-language-server",
        "shfmt",
        "shellcheck",

        "hadolint",

        "tailwindcss-language-server",
        "html-lsp",
        "css-lsp",
        "eslint-lsp",
        "prettier",
        "biome",
        "vtsls",
        "js-debug-adapter",
        "emmet-language-server",

        "gopls",
        "goimports",
        "golines",
        "golangci-lint-langserver",
        "delve",
        "gomodifytags",
        "gotests",
        "iferr",
        "impl",

        "rust-analyzer",

        "jdtls",
        "java-debug-adapter",
        "java-test",

        "codelldb",

        "pyright",

        "taplo",
        "lemminx",

        "ruff",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    cmd = { "DapInstall", "DapUninstall" },
  },
}
