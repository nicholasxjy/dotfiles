local util = require("util")

util.build_fn_on_change("markdown-preview.nvim", { "install", "update" }, function()
  vim.fn["mkdp#util#install"]()
end)

vim.pack.add({
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/iamcco/markdown-preview.nvim",
})

vim.g.mkdp_filetypes = { "markdown" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "mdx" },
  once = true,
  callback = function()
    require("render-markdown").setup({
      file_types = { "markdown" },
      completions = { blink = { enabled = true }, lsp = { enabled = false } },
      code = {
        width = "block",
      },
    })
  end,
})
