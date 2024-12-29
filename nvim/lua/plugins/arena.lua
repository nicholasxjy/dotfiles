return {
  {
    "dzfrias/arena.nvim",
    event = "BufWinEnter",
    config = true,
    keys = {
      {
        "<leader>h",
        function()
          require("arena").toggle()
        end,
        desc = "Find buffer to jump",
      },
    },
    opts = {
      max_items = 10,
      ignore_current = false,
      buf_opts = {
        ["relativenumber"] = false,
      },
      per_project = true,
      devicons = true,
      -- Config for frecency algorithm.
      algorithm = {
        -- Multiplies the recency by a factor. Must be greater than zero.
        -- A smaller number will mean less of an emphasis on recency!
        recency_factor = 1,
        -- Same as `recency_factor`, but for frequency!
        frequency_factor = 0.5,
      },
      keybinds = {},
    },
  },
}
