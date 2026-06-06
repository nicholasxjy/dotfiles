vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" }, { load = false })

local loaded = false

local function load_lint()
  if loaded then
    return require("lint")
  end

  vim.cmd.packadd("nvim-lint")

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

  loaded = true

  return lint
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  once = true,
  callback = function()
    load_lint()
  end,
})
