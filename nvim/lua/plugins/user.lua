-- * override the configuration of LazyVim plugins
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      {
        "<leader><space>",
        function()
          require("fzf-lua").files({
            cwd_prompt = true,
            cwd_prompt_shorten_len = 32,
            cwd_prompt_shorten_val = 2,
          })
        end,
        desc = "Find Files",
      },
    },
    opts = {
      winopts = {
        title = true,
        title_pos = "center",
        border = "single",
        row = 1,
        width = 1.0,
        height = 0.45,
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "classic",
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = false,
        command_palette = {
          views = {
            cmdline_popup = {
              position = {
                row = "50%",
                col = "50%",
              },
            },
          },
        },
      },
    },
  },
  {
    "folke/trouble.nvim",
    opts = function(_, opts)
      opts.focus = true
      opts.use_diagnostic_signs = true
      opts.preview = {
        type = "float",
        size = {
          width = 0.8,
          height = 0.5,
        },
      }
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      label = {
        uppercase = false,
        rainbow = {
          enabled = true,
          shade = 5,
        },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      current_line_blame = true,
    },
  },
}
