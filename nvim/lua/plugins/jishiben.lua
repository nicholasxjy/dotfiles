return {
  "nicholasxjy/jishiben.nvim",
  event = "VeryLazy",
  opts = {
    win = {
      title = "JISHIBEN",
      width = 80,
      height = 20,
    },
  },
  keys = {
    { "<leader>Ja", "<cmd>JishibenAdd<cr>", desc = "Jishiben Add" },
    { "<leader>Jd", "<cmd>JishibenDelete<cr>", desc = "Jishiben Delete" },
    { "<leader>Jp", "<cmd>JishibenOpen<cr>", desc = "Jishiben Open" },
    { "<leader>Js", "<cmd>JishibenPick<cr>", desc = "Jishiben Pick" },
    { "<leader>Jc", "<cmd>JishibenClear<cr>", desc = "Jishiben Clear" },
  },
}
