local loader = require("loader")

local setup = function()
  vim.g.mkdp_filetypes = { "markdown" }
  loader.packadd("markdown-preview.nvim", "nvim-web-devicons", "budoux.lua", "md-render.nvim")

  -- require("render-markdown").setup({
  --   file_types = { "markdown" },
  --   completions = { blink = { enabled = true }, lsp = { enabled = false } },
  --   code = {
  --     -- width = "block",
  --   },
  -- })
end

loader.defer("markdown", setup, { "BufReadPre", "BufNewFile" }, { pattern = { "*.md", "*.mdx" } })
