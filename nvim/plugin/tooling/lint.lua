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
    local linters = {}

    if
      has_config(bufnr, {
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
        "eslint.config.ts",
        "eslint.config.mts",
        "eslint.config.cts",
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json",
        ".eslintrc.yaml",
        ".eslintrc.yml",
      })
    then
      table.insert(linters, "eslint")
    end

    if has_config(bufnr, { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts", "oxlint.config.mts" }) then
      table.insert(linters, "oxlint")
    end

    return linters
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
