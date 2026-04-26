require("illuminate").configure({
  providers = {
    "lsp",
    "treesitter",
    "regex",
  },
  delay = 100,
})

vim.keymap.set("n", "]]", function()
  require("illuminate").goto_next_reference()
end, { desc = "Next reference" })

vim.keymap.set("n", "[[", function()
  require("illuminate").goto_prev_reference()
end, { desc = "Prev reference" })
