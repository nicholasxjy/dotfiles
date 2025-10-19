return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },
  {
    "max397574/better-escape.nvim",
    event = "VeryLazy",
    enabled = false,
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
    "HiPhish/rainbow-delimiters.nvim",
    ft = {
      "html",
      "clojure",
      "query",
      "scheme",
      "lisp",
      "commonlisp",
      "php",
      "javascriptreact",
      "typescriptreact",
    },
    config = function()
      require("rainbow-delimiters.setup").setup({
        query = {
          [""] = "",
          javascript = "rainbow-tags-react",
          tsx = "rainbow-tags-react",
          commonlisp = "rainbow-delimiters",
          scheme = "rainbow-delimiters",
          query = function(bufnr)
            -- Use blocks for read-only buffers like in `:InspectTree`
            local is_nofile = vim.bo[bufnr].buftype == "nofile"
            return is_nofile and "rainbow-blocks" or "rainbow-delimiters"
          end,
          clojure = "rainbow-delimiters",
          html = "rainbow-delimiters",
        },
      })
    end,
  },
  {
    "gen740/SmoothCursor.nvim",
    lazy = false,
    opts = {
      type = "default",
      autostart = true,
      fancy = {
        enable = true,
        head = { cursor = "", texthl = "SmoothCursor", linehl = nil }, -- ▷
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
    "mvllow/modes.nvim",
    event = "VeryLazy",
    config = function()
      require("modes").setup({
        colors = {
          bg = "#35374B", -- Optional bg param, defaults to Normal hl group
        },
        set_cursor = true,
        set_cursorline = true,
        set_number = true,
        set_signcolumn = true,
        ignore = { "NvimTree", "TelescopePrompt" },
        line_opacity = 0.1,
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
      -- char = "║",
      -- char = "⋮",
      -- char = "",
      char = "󰮾",
      virtcolumn = "80",
    },
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
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      timeout = 1,
      maxkeys = 5,
      position = "top-right",
    },
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
}
