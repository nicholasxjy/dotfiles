-- Disable netrw before activating yazi.
vim.g.loaded_netrwPlugin = 1

vim.pack.add({
  -- "https://github.com/mikavilpas/yazi.nvim",
  "https://github.com/nicholasxjy/yazi.nvim",
})

require("yazi").setup({})

vim.keymap.set("n", "<leader>-", function()
  require("yazi").yazi({
    open_for_directories = true,
  })
end, { desc = "Yazi" })
