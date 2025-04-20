return {
  "mrjones2014/smart-splits.nvim",
  -- event = "VeryLazy",
  lazy = false,
  keys = {
    {
      "<c-h>",
      function()
        require("smart-splits").move_cursor_left()
      end,
      desc = "Move to left split",
    },
    {
      "<c-j>",
      function()
        require("smart-splits").move_cursor_down()
      end,
      desc = "Move to below split",
    },
    {
      "<c-k>",
      function()
        require("smart-splits").move_cursor_up()
      end,
      desc = "Move to above split",
    },
    {
      "<c-l>",
      function()
        require("smart-splits").move_cursor_right()
      end,
      desc = "Move to right split",
    },
  },
  opts = { ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" }, ignored_buftypes = { "nofile" } },
}
