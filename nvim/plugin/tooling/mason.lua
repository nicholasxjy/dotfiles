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
  "oxlint",
  "oxfmt",
  "vue-language-server",
  "js-debug-adapter",
  "json-lsp",
  "gopls",
  "goimports",
  "golines",
  "golangci-lint-langserver",
  "golangci-lint",
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
  "sqruff",
  "zls",
}

local loader = require("loader")

-- Eager: `setup()` is what puts mason's bin directory on $PATH, and LSP servers
-- are spawned as soon as the first buffer gets its filetype.
loader.packadd("mason.nvim")

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

-- The registry index is only needed to react to installs, never to start one.
loader.on_very_lazy("mason-registry", function()
  require("mason-registry"):on("package:install:success", function()
    vim.defer_fn(function()
      vim.api.nvim_exec_autocmds("FileType", {
        buffer = vim.api.nvim_get_current_buf(),
        modeline = false,
      })
    end, 100)
  end)
end)

local function install_missing_tools()
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

vim.api.nvim_create_user_command("MasonToolsInstall", install_missing_tools, {
  desc = "Install configured Mason tools",
})
