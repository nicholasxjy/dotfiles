return {
  {
    "gbprod/yanky.nvim",
    event = "BufNewfile",
    opts = {
      highlight = { timer = 250 },
    },
    keys = {
      { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank" },
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Paste After" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Paste Before" },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Paste After Selection" },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Paste Before Selection" },
      { "[y", "<Plug>(YankyCycleForward)", desc = "Older Yank" },
      { "]y", "<Plug>(YankyCycleBackward)", desc = "Newer Yank" },
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Paste After Line" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Paste Before Line" },
      { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Paste After Line" },
      { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Paste Before Line" },
      { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Paste Right" },
      { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Paste Left" },
      { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Paste Before Right" },
      { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Paste Before Left" },
      { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Paste After Filter" },
      { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Paste Before Filter" },
    },
  },
}
