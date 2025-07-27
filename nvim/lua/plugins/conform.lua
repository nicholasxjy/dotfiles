local supported = {
  "css",
  "graphql",
  "handlebars",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "less",
  "markdown",
  "markdown.mdx",
  "scss",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
  "yaml.docker-compose",
}

return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({
            lsp_format = "fallback",
            async = false,
            timeout_ms = 3000,
          })
        end,
        desc = "Conform format",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local default_formatters_by_ft = {
        sh = { "shfmt" },
        go = { "goimports", "gofmt" }, -- golines
        lua = { "stylua" },
        nix = { "nixfmt" },
        rust = { "rustfmt" },
        templ = { "templ" },
        toml = { "taplo" },
      }

      for _, ft in ipairs(supported) do
        default_formatters_by_ft[ft] = default_formatters_by_ft[ft] or {}
        table.insert(default_formatters_by_ft[ft], "prettier")
        -- table.insert(default_formatters_by_ft[ft], "biome")
      end

      opts.formatters_by_ft = vim.tbl_deep_extend("force", default_formatters_by_ft, opts.formatters_by_ft or {})

      opts.formatters =
        vim.tbl_deep_extend("force", { injected = { options = { ignore_errors = true } } }, opts.formatters or {})

      require("conform").setup(opts)

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          if not vim.g.autoformat or vim.b.autoformat == false then
            return
          end
          require("conform").format({ bufnr = args.buf, lsp_format = "fallback" })
        end,
      })
    end,
  },
}
