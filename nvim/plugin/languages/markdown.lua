local loader = require("loader")

local setup = function()
  vim.cmd.packadd("markdown-preview.nvim")
  vim.cmd.packadd("render-markdown.nvim")

  vim.g.mkdp_filetypes = { "markdown" }

  require("render-markdown").setup({
    file_types = { "markdown" },
    completions = { blink = { enabled = true }, lsp = { enabled = false } },
    code = {
      -- width = "block",
    },
  })
end

loader.defer_buffer("markdown", setup)
