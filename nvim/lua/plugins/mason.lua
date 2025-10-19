return {
  "mason-org/mason.nvim",
  build = ":MasonUpdate",
  cmd = "Mason",
  event = { "BufNewFile", "BufReadPre" },
  opts_extend = { "ensure_installed" },
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  opts = {
    pip = {
      upgrade_pip = true,
    },
    ui = {
      border = vim.g.bordered and "rounded" or "none",
    },
    ensure_installed = {

      "lua-language-server",
      "stylua",

      "dockerfile-language-server",
      "docker-compose-language-service",

      "bash-language-server",
      "shfmt",
      "shellcheck",

      "hadolint",

      "html-lsp",
      "css-lsp",
      "eslint-lsp",
      "prettier",
      "biome",
      "vtsls",
      "js-debug-adapter",

      "json-lsp",

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

      "yaml-language-server",
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)

    local registry = require("mason-registry")
    registry:on("package:install:success", function()
      vim.defer_fn(function()
        require("lazy.core.handler.event").trigger({
          event = "FileType",
          buf = vim.api.nvim_get_current_buf(),
        })
      end, 100)
    end)

    registry.refresh(function()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = registry.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end)
  end,
}
