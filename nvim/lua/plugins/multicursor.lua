return {
  {
    "mg979/vim-visual-multi",
    event = { "BufRead", "InsertEnter" },
    config = function()
      vim.g.VM_theme = "iceblue"
      vim.g.VM_silent_exit = 1
      vim.g.VM_show_warnings = 0
    end,
  },
}
