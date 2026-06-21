vim.pack.add({
  "https://github.com/nicholasxjy/marker-jump.nvim",
})

require("marker-jump").setup({
  keymaps = {
    toggle = nil,
    close = "q",
    refresh = "r",
    jump = "<CR>",
  },
  window = {
    width = 22,
    focus_on_open = true,
    position = "left",
  },
  jump_keys = "asdfghjklqwertyuiopzxcvbnm",
  labels = nil,
  virtual_text = true,
  signs = true,
  auto_close_on_jump = false,
})
