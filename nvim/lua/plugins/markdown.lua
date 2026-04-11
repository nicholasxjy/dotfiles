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
        desc = "Preview Markdown",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = { "saghen/blink.cmp" },
    cmd = "Markview",
    keys = {
      { "<leader>um", "<cmd>Markview toggle<cr>", desc = "Markview toggle" },
    },
    opts = {
      preview = {
        icon_provider = "mini",
      },
    },
  },
}
