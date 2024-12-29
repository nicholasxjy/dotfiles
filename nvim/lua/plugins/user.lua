-- * override the configuration of LazyVim plugins
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cyberdream",
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
      spec = {
        -- { "<leader>j", group = "personal1", icon = { icon = "󰕈", color = "yellow" } },
        -- { "<leader>k", group = "personal2", icon = { icon = "󰌽", color = "red" } },
        { "<leader>m", group = "Customize", icon = { icon = "󰣨", color = "cyan" } },
        { "<leader>md", group = "Diffview", icon = { icon = "󰦓", color = "red" } },
      },
      -- win = {
      --   border = "single",
      -- },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
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
