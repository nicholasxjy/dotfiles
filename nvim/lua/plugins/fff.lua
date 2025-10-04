return {
  "nicholasxjy/fff.nvim",
  build = "cargo build --release",
  opts = {
    prompt = " ",
    title = "Files",
    layout = {
      height = 0.5,
      width = 0.8,
      prompt_position = "top", -- or 'top'
      preview_position = "right", -- or 'left', 'right', 'top', 'bottom'
      preview_size = 0.5,
    },
    preview = {
      enabled = false,
    },
    keymaps = {
      select = "<CR>",
      move_up = { "<Up>", "<C-p>", "<C-k>" },
      move_down = { "<Down>", "<C-n>", "<C-j>" },
    },
  },
  lazy = false,
  keys = {
    -- {
    --   "ff",
    --   function()
    --     require("fff").find_files()
    --   end,
    --   desc = "Find files",
    --   silent = true,
    -- },
  },
}
