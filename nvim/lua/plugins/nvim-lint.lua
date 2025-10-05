return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      local linters_by_ft = {
        sh = { "shellcheck" },
        dockerfile = { "hadolint" },
        javascript = { "eslint" },
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
        javascriptreact = { "eslint" },
        go = { "golangcilint" },
      }

      lint.linters_by_ft = linters_by_ft
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
        group = vim.api.nvim_create_augroup("xue-nvim-lint", { clear = true }),
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
