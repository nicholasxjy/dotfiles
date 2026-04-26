require("notify").setup({
  render = "wrapped-compact",
  stages = "fade_in_slide_out",
})

vim.keymap.set("n", "<leader>un", function()
  require("notify").clear_history()
end, { desc = "Clear Notifications" })

vim.keymap.set("n", "<leader>N", function()
  require("notify").history()
end, { desc = "Notifications" })
