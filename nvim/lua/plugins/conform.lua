local contains = function(list, val)
  for _, v in ipairs(list) do
    if v == val then
      return true
    end
  end
  return false
end

return {
  {
    "stevearc/conform.nvim",
    event = "BufReadPre",
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
        },

        format_after_save = function()
          if not vim.g.autoformat then
            return
          end
          if contains(vim.g.exclude_autoformat, vim.bo.filetype) then
            return
          end
          if vim.bo.filetype == "ps1" then
            vim.lsp.buf.format()
            return
          end
          return { lsp_format = "fallback" }
        end,
      })
    end,
  },
}
