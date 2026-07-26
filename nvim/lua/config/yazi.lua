require("yazi").setup({})

vim.keymap.set("n", "<leader>-", function()
  require("yazi").yazi({
    open_for_directories = true,
  })
end, { desc = "Yazi" })
