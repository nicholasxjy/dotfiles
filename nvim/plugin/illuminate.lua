local illum = require("illuminate")

illum.configure({
  providers = {
    "lsp",
    "treesitter",
    "regex",
  },
  delay = 250,
})

vim.keymap.set("n", "]]", function()
  illum.goto_next_reference()
end, { desc = "Next reference" })

vim.keymap.set("n", "[[", function()
  illum.goto_prev_reference()
end, { desc = "Prev reference" })
