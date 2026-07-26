local lint = require("lint")

lint.linters_by_ft = {
  sh = { "shellcheck" },
  dockerfile = { "hadolint" },
  javascript = { "eslint" },
  typescript = { "eslint" },
  typescriptreact = { "eslint" },
  javascriptreact = { "eslint" },
  go = { "golangcilint" },
}

vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function(args)
    if vim.bo[args.buf].modifiable then
      lint.try_lint(nil, { ignore_errors = true })
    end
  end,
})
