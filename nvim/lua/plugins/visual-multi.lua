return {
  "mg979/vim-visual-multi",
  event = { "BufRead", "InsertEnter" },
  config = function()
    vim.g.VM_theme = "iceblue"
  end,
}
