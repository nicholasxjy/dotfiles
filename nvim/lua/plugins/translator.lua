return {
  "nicholasxjy/translator.nvim",
  event = "VeryLazy",
  cmd = "Trans",
  opts = {
    default_target_lang = "zh", -- Default target language
    default_source_lang = nil, -- Default source language (nil = auto-detect)
    window = {
      width = 60,
    },
  },
  keys = {
    -- Translate visual selection to Chinese
    {
      "<leader>bv",
      function()
        require("translator").transVisualSel()
      end,
      mode = "v",
      desc = "Translate to Chinese",
    },
    -- Translate word under cursor using default language
    {
      "<leader>bc",
      function()
        require("translator").transCurWord()
      end,
      mode = "n",
      desc = "Translate word",
    },
  },
}
