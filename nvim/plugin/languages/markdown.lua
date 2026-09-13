local loader = require("loader")

local setup = function()
  vim.g.mkdp_filetypes = { "markdown" }
  loader.packadd("markdown-preview.nvim", "nvim-web-devicons", "render-markdown.nvim")

  require("render-markdown").setup({
    enabled = true,
    file_types = { "markdown" },
    completions = { blink = { enabled = true }, lsp = { enabled = false } },
    code = {},
  })
end

loader.defer("markdown", setup, { "BufReadPre", "BufNewFile" }, { pattern = { "*.md", "*.mdx" } })
