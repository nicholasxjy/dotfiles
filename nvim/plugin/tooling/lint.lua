local loader = require("loader")

local setup = function()
  loader.packadd("nvim-lint")

  local lint = require("lint")

  local javascript_filetypes = {
    javascript = true,
    javascriptreact = true,
    typescript = true,
    typescriptreact = true,
  }

  local function has_config(bufnr, files)
    local path = vim.api.nvim_buf_get_name(bufnr)
    return not vim.tbl_isempty(vim.fs.find(files, { path = vim.fs.dirname(path), upward = true }))
  end

  local function javascript_linters(bufnr)
    -- ESLint diagnostics are provided by the ESLint LSP; keep oxlint as the
    -- complementary project linter to avoid duplicate reports.
    if has_config(bufnr, { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts", "oxlint.config.mts" }) then
      return { "oxlint" }
    end

    return {}
  end

  lint.linters_by_ft = {
    sh = { "shellcheck" },
    dockerfile = { "hadolint" },
    go = { "golangcilint" },
  }

  vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function(args)
      if vim.bo[args.buf].modifiable then
        local linters = javascript_filetypes[vim.bo[args.buf].filetype] and javascript_linters(args.buf) or nil
        lint.try_lint(linters, { ignore_errors = true })
      end
    end,
  })
end

loader.defer_buffer("lint", setup, { schedule = true })
