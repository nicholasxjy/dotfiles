return {
  "nicholasxjy/translator.nvim",
  event = "VeryLazy",
  cmd = "Trans",
  opts = {
    default_target_lang = "zh", -- Default target language
    default_source_lang = nil, -- Default source language (nil = auto-detect)
    popup_width = 80, -- Popup window width
    popup_height = 20, -- Popup window max height
  },
  keys = {
    -- Translate visual selection to Chinese
    { "<leader>tv", ":'<,'>Trans to=zh<cr>", mode = "v", desc = "Translate to Chinese" },
    -- Translate word under cursor using default language
    { "<leader>tc", "<cmd>TransWord<cr>", mode = "n", desc = "Translate word" },
  },
}
