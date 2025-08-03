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
        "<leader>cf",
        function()
          require("conform").format()
        end,
        mode = { "n", "x", "v" },
        desc = "Format",
      },
      {
        "<leader>cF",
        function()
          require("conform").format({
            formatters = { "injected" },
          })
        end,
        desc = "Conform format injected langs",
        mode = { "n", "v", "x" },
      },
    },
    opts = {
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
        query = { "format-queries" },
        sh = { "shfmt" },
        go = { "goimports", "gofmt" }, -- golines
        lua = { "stylua" },
        nix = { "nixfmt" },
        rust = { "rustfmt" },
        templ = { "templ" },
        toml = { "taplo" },
      },
      default_format_opts = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
