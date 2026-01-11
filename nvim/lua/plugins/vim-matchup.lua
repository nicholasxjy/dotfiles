return {
  "andymass/vim-matchup",
  event = "BufReadPost",
  opts = {
    matchparen = {
      enabled = 1,
      hi_background = 1,
      hi_surround_always = 1,
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
      stopline = 500,
      enable_quotes = true,
      include_match_words = true,
      disable_virtual_text = true,
    },
  },
}
