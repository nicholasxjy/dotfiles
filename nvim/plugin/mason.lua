local util = require("util")

local ensure_installed = {
  "lua-language-server",
  "copilot-language-server",
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
  "vue-language-server",
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
  "zls",
}

local function setup_mason()
  util.ensure_plugin("mason.nvim", function()
    require("mason").setup({
      pip = {
        upgrade_pip = true,
      },
      ui = {
        backdrop = 100,
        height = 0.65,
        width = 0.7,
      },
    })

    local registry = require("mason-registry")
    registry:on("package:install:success", function()
      vim.defer_fn(function()
        vim.api.nvim_exec_autocmds("FileType", {
          buffer = vim.api.nvim_get_current_buf(),
          modeline = false,
        })
      end, 100)
    end)
  end)
end

local function install_missing_tools()
  setup_mason()

  local registry = require("mason-registry")
  local missing = {}
  registry.refresh(function()
    for _, tool in ipairs(ensure_installed) do
      local ok, pkg = pcall(registry.get_package, tool)
      if not ok then
        vim.notify(("Mason package not found: %s"):format(tool), vim.log.levels.WARN)
      elseif not pkg:is_installed() then
        missing[#missing + 1] = tool
        pkg:install()
      end
    end

    if #missing == 0 then
      vim.notify("All Mason tools are installed", vim.log.levels.INFO)
      return
    end

    vim.notify("Installing Mason tools: " .. table.concat(missing, ", "), vim.log.levels.INFO)
  end)
end

setup_mason()

vim.api.nvim_create_user_command("MasonToolsInstall", install_missing_tools, {
  desc = "Install configured Mason tools",
})
