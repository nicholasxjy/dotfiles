return {
  {
    "stevearc/dressing.nvim",
    event = "BufRead",
    opts = {},
  },
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      timeout = 1,
      maxkeys = 5,
      position = "bottom-center",
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    main = "rainbow-delimiters.setup",
  },
  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup({
        auto_cmd = true,
      })
    end,
  },
  {
    "tris203/precognition.nvim",
    opts = {
      startVisible = false,
      disabled_fts = {
        "startify",
        "lazy",
        "mason",
        "trouble",
        "neo-tree",
        "NeoTree",
        "Trouble",
        "markdown",
        "dashboard",
        "Dashboard",
      },
    },
  },
  {
    "mcauley-penney/visual-whitespace.nvim",
    event = "VeryLazy",
    config = true,
    opts = {
      highlight = { link = "LineNr" },
    },
  },
}
