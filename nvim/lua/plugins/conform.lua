return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({
            lsp_format = "fallback",
          })
        end,
        desc = "Format buffer",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local default_formatters_by_ft = {
        css = { "prettier" },
        go = { "goimports", "gofmt", "golines" },
        html = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        nix = { "nixfmt" },
        rust = { "rustfmt" },
        scss = { "prettier" },
        sh = { "shfmt" },
        templ = { "templ" },
        toml = { "taplo" },
        yaml = { "prettier" },
      }

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
