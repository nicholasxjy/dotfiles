return {
  "danymat/neogen",
  cmd = "Neogen",
  keys = {
    {
      "<leader>cn",
      function()
        require("neogen").generate()
      end,
      desc = "Generate Annotations (Neogen)",
    },
  },
  opts = {
    enabled = true, --if you want to disable Neogen
    snippet_engine = "luasnip",
    input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
  },
}
