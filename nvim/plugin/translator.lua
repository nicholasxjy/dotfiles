local translator = require("translator")

translator.setup({
  default_target_lang = "zh",
  default_source_lang = nil,
  window = {
    width = 60,
  },
})

vim.keymap.set("v", "<leader>bv", function()
  translator.transVisualSel()
end, { desc = "Translate Selection" })
vim.keymap.set("n", "<leader>bc", function()
  translator.transCurWord()
end, { desc = "Translate Word" })
