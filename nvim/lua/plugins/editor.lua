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
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPre",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "virtual",
        virtual_symbol = "󰻂",
      })
    end,
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
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },
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
  {
    "gen740/SmoothCursor.nvim",
    lazy = false,
    opts = {
      type = "default",
      autostart = true,
      fancy = {
        enable = true, -- enable fancy mode
        head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil }, -- false to disable fancy head
        body = {
          { cursor = "󰝥", texthl = "SmoothCursorRed" },
          { cursor = "󰝥", texthl = "SmoothCursorOrange" },
          { cursor = "●", texthl = "SmoothCursorYellow" },
          { cursor = "●", texthl = "SmoothCursorGreen" },
          { cursor = "•", texthl = "SmoothCursorAqua" },
          { cursor = ".", texthl = "SmoothCursorBlue" },
          { cursor = ".", texthl = "SmoothCursorPurple" },
        },
        tail = { cursor = nil, texthl = "SmoothCursor" }, -- false to disable fancy tail
      },
      enabled_filetypes = nil,
      disabled_filetypes = nil,
    },
    config = function(_, opts)
      require("smoothcursor").setup(opts)
    end,
  },
  {
    "mvllow/modes.nvim",
    event = "VeryLazy",
    config = function()
      require("modes").setup({
        colors = {
          bg = "#24283b", -- Optional bg param, defaults to Normal hl group
          copy = "#e0af68",
          delete = "#db4b4b",
          insert = "#9ece6a",
          visual = "#ff007c",
        },
        -- Enable cursor highlights
        set_cursor = true,

        -- Enable cursorline initially, and disable cursorline for inactive windows
        -- or ignored filetypes
        set_cursorline = true,

        -- Enable line number highlights to match cursorline
        set_number = true,
        -- Disable modes highlights in specified filetypes
        -- Please PR commonly ignored filetypes
        ignore_filetypes = { "NvimTree", "TelescopePrompt" },
        -- Set opacity for cursorline and number background
        line_opacity = 0.2,
      })
    end,
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "atiladefreitas/dooing",
    cmd = { "Dooing" },
    config = function()
      require("dooing").setup({
        keymaps = {
          toggle_window = "<leader>]",
        },
      })
    end,
  },
}
