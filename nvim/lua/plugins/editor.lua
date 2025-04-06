return {
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
        auto_cmd = false,
      })

      vim.api.nvim_create_autocmd("BufReadPost", {
        desc = "Guess indentation when loading a file",
        callback = function(args)
          require("guess-indent").set_from_buffer(args.buf, true, true)
        end,
      })
      vim.api.nvim_create_autocmd("BufNewFile", {
        desc = "Guess indentation when saving a new file",
        callback = function(args)
          vim.api.nvim_create_autocmd("BufWritePost", {
            buffer = args.buf,
            once = true,
            callback = function(wargs)
              require("guess-indent").set_from_buffer(wargs.buf, true, true)
            end,
          })
        end,
      })
    end,
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
    event = "VeryLazy", -- optionally lazy load the plugin
    cmd = {
      "ReticleToggleCursorline",
      "ReticleToggleCursorcolumn",
      "ReticleToggleCursorcross",
    },
    opts = {
      on_startup = {
        cursorline = false,
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
        },
        cursorcolumn = {
          "snacks_picker_input",
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
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    cmd = "SmearCursorToggle",
    opts = {},
  },
}
