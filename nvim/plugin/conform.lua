local util = require("util")

local function has_config(ctx, files)
  return not vim.tbl_isempty(vim.fs.find(files, { path = ctx.dirname, upward = true }))
end

local function setup_conform()
  util.ensure_plugin("conform.nvim", function()
    require("conform").setup({
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
          timeout_ms = 500,
        }
      end,
      formatters_by_ft = {
        javascript = { "biome", "prettier", stop_after_first = true },
        javascriptreact = { "biome", "prettier", stop_after_first = true },
        typescript = { "biome", "prettier", stop_after_first = true },
        typescriptreact = { "biome", "prettier", stop_after_first = true },
        css = { "biome", "prettier", stop_after_first = true },
        scss = { "biome", "prettier", stop_after_first = true },
        json = { "biome", "prettier", stop_after_first = true },
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
          condition = function(_, ctx)
            return has_config(ctx, {
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.js",
              ".prettierrc.cjs",
              ".prettierrc.mjs",
              ".prettierrc.toml",
              "prettier.config.js",
              "prettier.config.cjs",
              "prettier.config.mjs",
            })
          end,
        },
        biome = {
          condition = function(_, ctx)
            return has_config(ctx, { "biome.json", "biome.jsonc" })
          end,
        },
      },
    })
  end)

  return require("conform")
end

function _G.__conform_formatexpr()
  return setup_conform().formatexpr()
end

vim.schedule(function()
  vim.o.formatexpr = "v:lua.__conform_formatexpr()"
end)

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("ConformDeferredSetup", { clear = true }),
  once = true,
  callback = setup_conform,
})

vim.keymap.set({ "n", "v", "x" }, "<leader>cf", function()
  setup_conform().format()
end, { desc = "Format code using Conform" })
