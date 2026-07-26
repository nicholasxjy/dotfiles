local miniclue = require("mini.clue")

require("minibuffer.integrations.mini-clue").setup()

miniclue.setup({
  window = {
    delay = 100,
    config = {
      width = "auto",
      col = "auto",
      anchor = "NW",
    },
  },
  triggers = {
    { mode = { "n", "x" }, keys = "<Leader>" },
    { mode = "n", keys = "[" },
    { mode = "n", keys = "]" },
    { mode = "i", keys = "<C-x>" },
    { mode = { "n", "x" }, keys = "g" },
    { mode = { "n", "x" }, keys = "'" },
    { mode = { "n", "x" }, keys = "`" },
    { mode = { "n", "x" }, keys = '"' },
    { mode = { "i", "c" }, keys = "<C-r>" },
    { mode = "n", keys = "<C-w>" },
    { mode = { "n", "x" }, keys = "z" },
  },
  clues = {
    { mode = "n", keys = "<leader>a", desc = "+AI" },
    { mode = "n", keys = "<leader>b", desc = "+Buffer" },
    { mode = "n", keys = "<leader>c", desc = "+Code" },
    { mode = "n", keys = "<leader>d", desc = "+Debug" },
    { mode = "n", keys = "<leader>f", desc = "+Files" },
    { mode = "n", keys = "<leader>s", desc = "+Search" },
    { mode = "n", keys = "<leader>g", desc = "+Git" },
    { mode = "n", keys = "<leader>x", desc = "+Diagnostic" },
    { mode = "n", keys = "<leader>u", desc = "+UI" },
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})
