local loader = require("loader")

local setup = function()
  loader.packadd("conform.nvim")

  local function has_config(ctx, files)
    return not vim.tbl_isempty(vim.fs.find(files, { path = ctx.dirname, upward = true }))
  end

  local oxfmt_config_files = {
    ".oxfmtrc.json",
    ".oxfmtrc.jsonc",
    "oxfmt.config.ts",
    "oxfmt.config.mts",
    "vite.config.ts",
    "vite.config.js",
  }

  local biome_config_files = {
    "biome.json",
    "biome.jsonc",
    ".biome.json",
    ".biome.jsonc",
  }

  local conform = require("conform")
  local prettier_root = require("conform.formatters.prettierd").cwd

  conform.setup({
    default_format_opts = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
      lsp_format = "fallback",
    },
    format_on_save = function(bufnr)
      if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
        return
      end
      return {
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
      html = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      lua = { "stylua" },
      go = { "goimports", "gofmt" }, -- golines
      sql = { "sqruff" },
      rust = { "rustfmt" },
    },
    formatters = {
      prettier = {
        condition = function(self, ctx)
          return prettier_root(self, ctx) ~= nil
        end,
        cwd = prettier_root,
      },
      biome = {
        condition = function(_, ctx)
          return has_config(ctx, biome_config_files)
        end,
        cwd = function(_, ctx)
          return vim.fs.root(ctx.dirname, biome_config_files)
        end,
      },
      oxfmt = {
        args = function(_, ctx)
          return { "--stdin-filepath=" .. ctx.filename }
        end,
        condition = function(_, ctx)
          return has_config(ctx, oxfmt_config_files)
        end,
        cwd = function(_, ctx)
          return vim.fs.root(ctx.dirname, oxfmt_config_files)
        end,
      },
    },
  })

  vim.schedule(function()
    vim.o.formatexpr = "v:lua.__conform_formatexpr()"
  end)

  vim.keymap.set({ "n", "v", "x" }, "<leader>cf", function()
    conform.format()
  end, { desc = "Format code using Conform" })
end

loader.defer_buffer("conform", setup, { schedule = true })
