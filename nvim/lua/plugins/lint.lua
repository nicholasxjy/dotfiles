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
      local function debounce(ms, fn)
        local timer = assert(vim.uv.new_timer())
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = debounce(100, function()
          require("lint").try_lint()
        end),
      })

      vim.keymap.set("n", "<leader>cL", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
}
