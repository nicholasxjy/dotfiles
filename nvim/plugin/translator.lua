require("translator").setup({
  default_target_lang = "zh", -- Default target language
  default_source_lang = nil, -- Default source language (nil = auto-detect)
  window = {
    width = 60,
  },
})
vim.keymap.set("v", "<leader>bv", function()
  require("translator").transVisualSel()
end, { desc = "Translate Selection" })
vim.keymap.set("n", "<leader>bc", function()
  require("translator").transCurWord()
end, { desc = "Translate Word" })
