return {
  "iofq/dart.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-mini/mini.icons",
  },
  opts = {
    picker = {
      -- argument to pass to vim.fn.fnamemodify `mods`, before displaying the file path in the picker
      -- e.g. ":t" for the filename, ":p:." for relative path to cwd
      path_format = ":p:.",
      border = "rounded",
    },
  },
}
