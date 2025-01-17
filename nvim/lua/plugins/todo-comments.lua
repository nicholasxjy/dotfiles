return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "BufRead",
  opts = {},
  keys = {
    {
      "<leader>xt",
      function()
        Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME", "NOTE", "PERF", "FIX", "HACK" } })
      end,
      desc = "Todo/Fix/Fixme etc",
    },

    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next Todo Comment",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous Todo Comment",
    },
  },
}
