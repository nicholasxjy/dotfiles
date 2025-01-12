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
      enabled = true,
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
        hl = "SnacksIndent",
        -- hl = {
        --   "SnacksIndent1",
        --   "SnacksIndent2",
        --   "SnacksIndent3",
        --   "SnacksIndent4",
        --   "SnacksIndent5",
        --   "SnacksIndent6",
        --   "SnacksIndent7",
        --   "SnacksIndent8",
        -- },
      },
      scope = {
        enabled = true,
        -- char = "⁚",
        underline = true,
      },
      chunk = {
        enabled = true,
        hl = {
          "SnacksIndentChunk1",
          "SnacksIndentChunk2",
          "SnacksIndentChunk3",
          "SnacksIndentChunk4",
          "SnacksIndentChunk5",
          "SnacksIndentChunk6",
          "SnacksIndentChunk7",
          "SnacksIndentChunk8",
        },
      },
    },
    bigfile = { enabled = true },
    dim = { enabled = true },
    zen = { enabled = true },
    scroll = { enabled = false },
    input = { enabled = true },
    words = { enabled = true },
    statuscolumn = {
      enabled = true,
      left = { "mark", "sign" }, -- priority of signs on the left (high to low)
      right = { "fold", "git" }, -- priority of signs on the right (high to low)
      folds = {
        open = true, -- show open fold icons
        git_hl = true, -- use Git Signs hl for fold icons
      },
    },
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
        width = 0.7,
        height = 0.6,
        wo = {
          winbar = "", -- hide terminal title
        },
      },
    },
  },
}
