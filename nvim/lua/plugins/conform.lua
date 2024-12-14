return {
  {
    "stevearc/conform.nvim",
    event = "BufReadPre",
    config = function()
      vim.g.autoformat = true
      require("conform").setup({
        formatters_by_ft = {
          css = { "prettier" },
          go = { "goimports", "gofmt", "golines" },
          html = { "prettier" },
          javascript = { "prettier" },
          typescript = { "pretter" },
          javascriptreact = { "prettier" },
          typescriptreact = { "pretter" },
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
        },

        format_after_save = function()
          if not vim.g.autoformat then
            return
          else
            if vim.bo.filetype == "ps1" then
              vim.lsp.buf.format()
              return
            end
            return { lsp_format = "fallback" }
          end
        end,
      })
    end,
  },
}
