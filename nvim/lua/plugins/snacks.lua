return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  keys = {
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
  },
  opts = {
    dashboard = {
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
    indent = {
      enabled = true,
      indent = {
        char = "¦",
        blank = " ",
      },
      scope = {
        enabled = true,
        char = "⁚",
        underline = true,
      },
      chunk = {
        enabled = true,
      },
      priority = 200,
    },
    bigfile = { enabled = true },
    dim = { enabled = true },
    zen = { enabled = true },
    scroll = { enabled = true },
    input = { enabled = true },

    notifier = { enabled = true },

    lazygit = {
      configure = false,
      win = {
        position = "float",
        width = 0.8,
        height = 0.8,
      },
    },
    terminal = {
      win = {
        position = "float",
        width = 0.6,
        height = 0.5,
        wo = {
          winbar = "", -- hide terminal title
        },
      },
    },
  },
}
