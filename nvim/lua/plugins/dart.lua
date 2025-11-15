return {
  "iofq/dart.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-mini/mini.icons",
  },
  opts = {
    buflist = { "1", "2", "3", "4", "5", "6", "7", "8" },
    picker = {
      -- argument to pass to vim.fn.fnamemodify `mods`, before displaying the file path in the picker
      -- e.g. ":t" for the filename, ":p:." for relative path to cwd
      path_format = ":p:.",
      window = {
        title = "Dart Pick",
      },
    },
  },
}
