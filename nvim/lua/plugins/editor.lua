local ui = require("core.ui")
return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    keys = {
      {
        "<leader>S",
        function()
          require("persistence").select()
        end,
        desc = "Select Session",
      },
    },
    opts = {
      dir = vim.fn.stdpath("state") .. "/sessions/",
      need = 1,
      branch = true,
    },
    config = function(_, opts)
      local ps = require("persistence")
      ps.setup(opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistenceSavePost",
        callback = function()
          local session = vim.fn.sha256(ps.current(opts)):sub(1, 10)
          Dart.write_session(session)
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistenceLoadPost",
        callback = function()
          local session = vim.fn.sha256(ps.current(opts)):sub(1, 10)
          Dart.read_session(session)
        end,
      })
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
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
        colors = ui.mode_colors,

        -- Set opacity for cursorline and number background
        line_opacity = 0.1,

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
