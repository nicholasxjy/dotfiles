local ensure_installed = {

  "lua-language-server",

  "emmylua_ls",
  "stylua",
  "marksman",

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
}

local mason = require("mason")

mason.setup({
  pip = {
    upgrade_pip = true,
  },
  ui = {
    backdrop = 100,
    height = 0.65,
    width = 0.7,
  },
  ensure_installed = ensure_installed,
})

vim.schedule(function()
  local registry = require("mason-registry")
  registry:on("package:install:success", function()
    vim.defer_fn(function()
      vim.api.nvim_exec_autocmds("FileType", {
        buffer = vim.api.nvim_get_current_buf(),
        modeline = false,
      })
    end, 100)
  end)

  registry.refresh(function()
    for _, tool in ipairs(ensure_installed) do
      local p = registry.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end)
end)
