return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
      need = 0,
      branch = true, -- use git branch to save session
    },
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
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
    "gen740/SmoothCursor.nvim",
    lazy = false,
    opts = {
      type = "default",
      autostart = true,
      fancy = {
        enable = true,
        head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil }, -- ▷
        body = {
          { cursor = "󰝥", texthl = "SmoothCursorRed" },
          { cursor = "󰝥", texthl = "SmoothCursorOrange" },
          { cursor = "●", texthl = "SmoothCursorYellow" },
          { cursor = "●", texthl = "SmoothCursorGreen" },
          { cursor = "•", texthl = "SmoothCursorAqua" },
          { cursor = ".", texthl = "SmoothCursorBlue" },
          { cursor = ".", texthl = "SmoothCursorPurple" },
        },
        tail = { cursor = nil, texthl = "SmoothCursor" },
      },
      enabled_filetypes = nil,
      disabled_filetypes = {
        "render-markdown",
        "CodeCompanion",
        "oil",
        "snacks_picker_input",
        "snacks_picker_list",
        "fzf",
      },
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
    "lukas-reineke/virt-column.nvim",
    event = "VeryLazy",
    opts = {
      -- char = "|",
      -- char = "",
      -- char = "┇",
      -- char = "∶",
      -- char = "∷",
      -- char = "║",
      -- char = "⋮",
      -- char = "",
      char = "╿",
      -- char = "󰮾",
      virtcolumn = "80",
      highlight = "LineNr",
    },
  },
  {
    "NStefan002/screenkey.nvim",
    lazy = false,
    opts = {
      win_opts = {
        row = vim.o.lines - vim.o.cmdheight - 1,
        col = vim.o.columns - 1,
        relative = "editor",
        anchor = "SE",
        width = 20,
        height = 2,
        border = "single",
        title = "Screenkey",
        title_pos = "center",
        style = "minimal",
        focusable = false,
        noautocmd = true,
      },
      hl_groups = {
        ["screenkey.hl.key"] = { link = "Type" },
        ["screenkey.hl.map"] = { link = "Keyword" },
        ["screenkey.hl.sep"] = { link = "Normal" },
      },
    },
  },
  {
    "arnamak/stay-centered.nvim",
    lazy = false,
    opts = {
      skip_filetypes = {},
    },
  },
  {
    "mvllow/modes.nvim",
    event = "VeryLazy",
    config = function()
      require("modes").setup({
        colors = {
          bg = "#0D0D1A", -- Optional bg param, defaults to Normal hl group
          copy = "#f5c359",
          delete = "#c75c6a",
          change = "#c75c6a", -- Optional param, defaults to delete
          format = "#c79585",
          insert = "#78ccc5",
          replace = "#245361",
          select = "#9745be", -- Optional param, defaults to visual
          visual = "#9745be",
        },

        -- Set opacity for cursorline and number background
        line_opacity = 0.15,

        -- Enable cursor highlights
        set_cursor = true,

        -- Enable cursorline initially, and disable cursorline for inactive windows
        -- or ignored filetypes
        set_cursorline = true,

        -- Enable line number highlights to match cursorline
        set_number = true,

        -- Enable sign column highlights to match cursorline
        set_signcolumn = true,

        -- Disable modes highlights for specified filetypes
        -- or enable with prefix "!" if otherwise disabled (please PR common patterns)
        -- Can also be a function fun():boolean that disables modes highlights when true
        ignore = { "NvimTree", "TelescopePrompt", "!minifiles" },
      })
    end,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    opts = {},
  },
  {
    "tummetott/reticle.nvim",
    event = "VeryLazy",
    opts = {
      on_startup = {
        cursorline = true,
        cursorcolumn = false,
      },
      disable_in_insert = true,
      disable_in_diff = true,
      always_highlight_number = true,
      ignore = {
        cursorline = {
          "DressingInput",
          "FTerm",
          "NvimSeparator",
          "NvimTree",
          "TelescopePrompt",
          "Trouble",
          "snacks_picker_input",
          "snacks_picker_list",
          "snacks_picker_preview",
          "snacks_dashboard",
          "oil",
          "lazygit",
          "lazy",
        },
        cursorcolumn = {
          "DressingInput",
          "FTerm",
          "NvimSeparator",
          "NvimTree",
          "TelescopePrompt",
          "Trouble",
          "snacks_picker_input",
          "snacks_picker_list",
          "snacks_picker_preview",
          "snacks_dashboard",
          "fyler",
          "minifiles",
          "mason",
          "lazy",
          "oil",
          "lazygit",
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
        cursorcolumn = {
          "fyler",
        },
      },
    },
  },
  {
    "Wansmer/treesj",
    keys = {
      {
        "gS",
        function()
          require("treesj").toggle()
        end,
        desc = "Toggle split/join",
        silent = true,
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
