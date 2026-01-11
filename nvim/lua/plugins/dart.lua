return {
  "iofq/dart.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-mini/mini.icons",
  },
  opts = {
    buflist = { "1", "2", "3", "4", "5", "6" },
    picker = {
      path_format = ":p",
      window = {},
      mappings = {
        select = "<CR>",
        close = "<Esc>",
      },
    },
  },
}
