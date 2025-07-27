return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, opts)
      local lint = require("lint")

      local default_linters_by_ft = {
        sh = { "shellcheck" },
        dockerfile = { "hadolint" },

        javascript = { "eslint" },
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
        javascriptreact = { "eslint" },
      }

      lint.linters_by_ft = vim.tbl_deep_extend("force", default_linters_by_ft, opts.linters_by_ft or {})
      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })

      vim.keymap.set("n", "<leader>cL", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
}
