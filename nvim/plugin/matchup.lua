require("match-up").setup({
  matchparen = {
    enabled = 1,
    nomode = "i",
    insert_timeout = 20,
    hi_background = 1,
    hi_surround_always = 0,
    offscreen = {
      method = "status",
    },
  },
  surround = {
    enabled = 1,
  },
  text_obj = {
    enabled = 1,
  },
  treesitter = {
    enabled = true,
    stopline = 300,
    enable_quotes = true,
    include_match_words = true,
    disable_virtual_text = true,
  },
})
