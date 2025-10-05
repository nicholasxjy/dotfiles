return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" } })
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "Saghen/blink.cmp",
    },
    opts = {
      preview = {
        enable = true,
        icon_provider = "mini",
      },
      markdown = {
        enable = true,
      },
      markdown_inline = {
        enable = true,
      },
      html = {
        enable = true,
      },
    },
  },
}
