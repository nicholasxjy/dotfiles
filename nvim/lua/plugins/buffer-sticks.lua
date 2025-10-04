return {
  "ahkohd/buffer-sticks.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>h",
      function()
        BufferSticks.jump()
      end,
      desc = "Jump to buffer",
      silent = true,
    },
  },
  config = function()
    local sticks = require("buffer-sticks")
    sticks.setup({
      filter = { buftypes = { "terminal" } },
      highlights = {
        active = { link = "Statement" },
        alternate = { link = "StorageClass" },
        inactive = { link = "Whitespace" },
        active_modified = { link = "Constant" },
        alternate_modified = { link = "Constant" },
        inactive_modified = { link = "Constant" },
        label = { link = "Comment" },
      },
    })
    sticks.show()
  end,
}
