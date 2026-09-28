local loader = require("loader")

-- ============================================================================
-- Mason (Eager: puts mason's bin directory on $PATH)
-- ============================================================================
loader.packadd("mason.nvim")

local ensure_installed = {
  "lua-language-server",
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
  "ruff",
  "yaml-language-server",
  "sqruff",
  "zls",
}

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

-- ============================================================================
-- Conform (Code Formatting)
-- ============================================================================
loader.defer_buffer("conform", function()
  loader.packadd("conform.nvim")

  -- A Vite config alone does not opt a project into oxfmt.
  local oxfmt_config_files = {
    ".oxfmtrc.json",
    ".oxfmtrc.jsonc",
    "oxfmt.config.ts",
    "oxfmt.config.mts",
  }

  local conform = require("conform")

  conform.setup({
    default_format_opts = {
      timeout_ms = 3000,
      lsp_format = "fallback",
    },
    format_on_save = function(bufnr)
      if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
        return
      end
      return {
        timeout_ms = 1000,
        lsp_format = "fallback",
      }
    end,
    formatters_by_ft = {
      javascript = { "oxfmt", "biome", "prettier", stop_after_first = true },
      javascriptreact = { "oxfmt", "biome", "prettier", stop_after_first = true },
      typescript = { "oxfmt", "biome", "prettier", stop_after_first = true },
      typescriptreact = { "oxfmt", "biome", "prettier", stop_after_first = true },
      css = { "oxfmt", "biome", "prettier", stop_after_first = true },
      scss = { "oxfmt", "biome", "prettier", stop_after_first = true },
      json = { "oxfmt", "biome", "prettier", stop_after_first = true },
      jsonc = { "oxfmt", "biome", "prettier", stop_after_first = true },
      vue = { "oxfmt", "prettier", stop_after_first = true },
      html = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      lua = { "stylua" },
      go = { "goimports", "gofmt", stop_after_first = true },
      sql = { "sqruff" },
      rust = { "rustfmt" },
    },
    formatters = {
      prettier = { require_cwd = true },
      biome = { require_cwd = true },
      oxfmt = {
        require_cwd = true,
        cwd = function(_, ctx)
          return vim.fs.root(ctx.dirname, oxfmt_config_files)
        end,
      },
    },
  })

  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

  vim.keymap.set({ "n", "x" }, "<leader>cf", function()
    conform.format()
  end, { desc = "Format code using Conform" })
end)

-- ============================================================================
-- Linting (nvim-lint)
-- ============================================================================
loader.defer_buffer("lint", function()
  loader.packadd("nvim-lint")

  local lint = require("lint")

  local javascript_filetypes = {
    javascript = true,
    javascriptreact = true,
    typescript = true,
    typescriptreact = true,
  }

  local function has_config(bufnr, files)
    local path = vim.api.nvim_buf_get_name(bufnr)
    return not vim.tbl_isempty(vim.fs.find(files, { path = vim.fs.dirname(path), upward = true }))
  end

  local function javascript_linters(bufnr)
    if has_config(bufnr, { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts", "oxlint.config.mts" }) then
      return { "oxlint" }
    end
    return {}
  end

  lint.linters_by_ft = {
    dockerfile = { "hadolint" },
  }

  -- bashls runs ShellCheck; golangci_lint_ls owns Go lint diagnostics.
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("sjvim_lint", { clear = true }),
    callback = function(args)
      if vim.bo[args.buf].buftype == "" and vim.bo[args.buf].modifiable then
        local linters = javascript_filetypes[vim.bo[args.buf].filetype] and javascript_linters(args.buf) or nil
        vim.api.nvim_buf_call(args.buf, function()
          lint.try_lint(linters, { ignore_errors = true })
        end)
      end
    end,
  })
end, { schedule = true })
