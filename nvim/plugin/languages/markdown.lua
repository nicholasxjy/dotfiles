local loader = require("loader")

local setup = function()
  loader.packadd("markdown-preview.nvim")
  loader.packadd("render-markdown.nvim")

  vim.g.mkdp_filetypes = { "markdown" }

  require("render-markdown").setup({
    file_types = { "markdown" },
    completions = { blink = { enabled = true }, lsp = { enabled = false } },
    code = {
      -- width = "block",
    },
  })
end

loader.defer("markdown", setup, { "BufReadPre", "BufNewFile" }, { pattern = { "*.md", "*.mdx" } })
