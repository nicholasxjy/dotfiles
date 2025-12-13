return {
  "andymass/vim-matchup",
  event = "BufReadPost",
  init = function()
    -- modify your configuration vars here
    vim.g.matchup_treesitter_stopline = 500
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
    vim.g.matchup_surround_enabled = 1
    -- or call the setup function provided as a helper. It defines the
    -- configuration vars for you
    require("match-up").setup({
      treesitter = {
        stopline = 500,
      },
    })
  end,
  opts = {
    treesitter = {
      stopline = 500,
    },
  },
}
