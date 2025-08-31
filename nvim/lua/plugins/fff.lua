return {
  "dmtrKovalenko/fff.nvim",
  build = "cargo build --release",
  lazy = false,
  opts = {
    title = "File Picker",
    prompt = " ", -- 
    lazy_sync = false,
    preview = {
      enabled = false,
    },
    layout = {
      width = 0.6,
      height = 0.45,
      preview_size = 0.4,
      prompt_position = "top", -- or 'top'
      preview_position = "top", -- or 'left', 'right', 'top', 'bottom'
    },
    keymaps = {
      move_up = { "<Up>", "<C-p>", "<C-k>" },
      move_down = { "<Down>", "<C-n>", "<C-j>" },
    },
    hl = {
      border = "FloatBorder",
      normal = "NormalFloat",
      title = "FloatTitle",
      matched = "IncSearch",
      active_file = "PmenuSel",
    },
    debug = false,
  },
  keys = {
    {
      "ff",
      function()
        require("fff").find_files()
      end,
      desc = "Find files(cwd)",
    },
    {
      "<leader>ff",
      function()
        require("fff").find_in_git_root()
      end,
      desc = "Find files(root)",
    },
  },
}
