return {
  "mrjones2014/smart-splits.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<c-h>",
      function()
        require("smart-splits").move_cursor_left()
      end,
      desc = "Focus Left",
    },
    {
      "<c-j>",
      function()
        require("smart-splits").move_cursor_down()
      end,
      desc = "Focus Down",
    },
    {
      "<c-k>",
      function()
        require("smart-splits").move_cursor_up()
      end,
      desc = "Focus Up",
    },
    {
      "<c-l>",
      function()
        require("smart-splits").move_cursor_right()
      end,
      desc = "Focus Right",
    },
  },
  opts = { ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" }, ignored_buftypes = { "nofile" } },
}
