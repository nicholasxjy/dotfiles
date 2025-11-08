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
          "render-markdown",
          "CodeCompanion",
        },
        cursorcolumn = {
          "snacks_picker_input",
          "snacks_picker_list",
          "snacks_terminal",
          "mason",
          "lazy",
          "fzf",
          "oil",
          "render-markdown",
          "CodeCompanion",
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
    "gen740/SmoothCursor.nvim",
    lazy = false,
    opts = {
      type = "default",
      autostart = true,
      fancy = {
        enable = true,
        head = { cursor = ">", texthl = "SmoothCursor", linehl = nil }, -- ▷
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
      -- highlight = { link = "LineNr" },
    },
  },
  {
    "rasulomaroff/reactive.nvim",
    event = "VeryLazy",
    opts = {
      builtin = {
        cursorline = true,
        cursor = true,
        modemsg = true,
      },
    },
  },
  {
    "lukas-reineke/virt-column.nvim",
    event = "VeryLazy",
    enabled = false,
    opts = {
      -- char = "|",
      -- char = "",
      -- char = "┇",
      -- char = "∶",
      -- char = "∷",
      -- char = "║",
      -- char = "⋮",
      char = "",
      -- char = "󰮾",
      virtcolumn = "80",
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
}
