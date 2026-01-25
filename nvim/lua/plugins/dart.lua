return {
  "iofq/dart.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-mini/mini.icons" },
  opts = {
    marklist = { "1", "2", "3", "4", "5", "0" },
    buflist = {},
    picker = {
      path_format = ":p:.",
      window = {},
      mappings = {
        select = "<CR>",
        close = "<Esc>",
      },
    },
  },
}
