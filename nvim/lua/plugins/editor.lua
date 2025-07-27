return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },
  {
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    opts = {},
  },
  {
    "max397574/better-escape.nvim",
    event = "VeryLazy",
    opts = {
      timeout = 300,
      default_mappings = false,
      mappings = {
        i = { j = { k = "<Esc>", j = "<Esc>" } },
      },
    },
  },
  {
    "tummetott/reticle.nvim",
    event = "VeryLazy",
    cmd = {
      "ReticleToggleCursorline",
      "ReticleToggleCursorcolumn",
      "ReticleToggleCursorcross",
    },
    opts = {
      on_startup = {
        cursorline = true,
        cursorcolumn = false,
      },

      disable_in_insert = true,
      disable_in_diff = true,
      always_highlight_number = true,
      -- Define filetypes which are ignored by the plugin
      ignore = {
        cursorline = {
          "DressingInput",
          "FTerm",
          "NvimSeparator",
          "NvimTree",
          "TelescopePrompt",
          "Trouble",
          "snacks_picker_input",
          "snacks_terminal",
        },
        cursorcolumn = {
          "snacks_picker_input",
          "snacks_picker_list",
          "snacks_terminal",
          "mason",
          "lazy",
          "fzf",
        },
      },

      -- Specify filetypes where the cursorline and/or cursorcolumn should be
      -- explicitly disabled. Typically, you would include these filetypes in
      -- the 'ignored' table. However, there are situations where plugins enable
      -- cursorline/cursorcolumn without offering a configuration option for
      -- disabling them. By adding these filetypes to the 'never' table, you
      -- can override the plugin's settings and turn off these features.
      never = {
        cursorline = {},
        cursorcolumn = {},
      },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    main = "rainbow-delimiters.setup",
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
    "mcauley-penney/visual-whitespace.nvim",
    event = "VeryLazy",
    config = true,
    opts = {
      highlight = { link = "LineNr" },
    },
  },
  {
    "mvllow/modes.nvim",
    event = "VeryLazy",
    config = function()
      require("modes").setup({
        colors = {
          bg = "#1E1F2A",
          copy = "#f1ff5e",
          delete = "#ff6e5e",
          insert = "#5eff6c",
          visual = "#ff5ea0",
        },
        set_cursor = true,
        set_cursorline = true,
        set_number = true,
        set_signcolumn = true,
        ignore = { "NvimTree", "TelescopePrompt" },
        line_opacity = 0.15,
      })
    end,
  },
  {
    "lukas-reineke/virt-column.nvim",
    event = "VeryLazy",
    opts = {
      -- char = "|",
      -- char = "",
      -- char = "┇",
      -- char = "∶",
      -- char = "∷",
      char = "║",
      -- char = "⋮",
      -- char = "",
      -- char = "󰮾",
      virtcolumn = "80",
    },
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinLeave" },
  },
  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    config = function()
      require("hlslens").setup()
      local kopts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
    end,
  },
  {
    "razak17/tailwind-fold.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
  },
  {
    "vvvvv/yfix.nvim",
    event = "VeryLazy",
    config = function()
      require("yfix").setup({
        insert_mode = true,
        normal_mode = true,
      })
    end,
  },
}
