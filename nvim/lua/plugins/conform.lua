local supported = {
  "graphql",
  "handlebars",
  "markdown",
  "markdown.mdx",
  "yaml",
  "yaml.docker-compose",
  "less",
  "scss",
  "css",
  "html",
}

local fe_supported = {
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "typescript",
  "typescriptreact",
  "vue",
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
        -- lua = { "stylua" },
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
    config = function(_, opts)
      local function has_config(ctx, files)
        return not vim.tbl_isempty(vim.fs.find(files, { path = ctx.dirname, upward = true }))
      end

      opts.formatters = opts.formatters or {}
      opts.formatters.prettier = {
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
      }
      opts.formatters.biome = {
        condition = function(_, ctx)
          return has_config(ctx, { "biome.json", "biome.jsonc" })
        end,
      }

      for _, ft in ipairs(supported) do
        opts.formatters_by_ft[ft] = { "prettier" }
      end

      for _, ft in ipairs(fe_supported) do
        opts.formatters_by_ft[ft] = { "biome", "prettier", stop_after_first = true }
      end

      require("conform").setup(opts)
    end,
  },
}
