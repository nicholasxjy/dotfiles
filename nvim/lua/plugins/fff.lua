return {
  "dmtrKovalenko/fff.nvim",
  build = function()
    require("fff.download").download_or_build_binary()
  end,
  opts = {
    prompt = "🪿 ",
    keymaps = {
      close = "<Esc>",
      select = "<CR>",
      move_up = { "<Up>", "<C-p>", "<C-k>" },
      move_down = { "<Down>", "<C-n>", "<C-j>" },
    },
    hl = {
      matched = "Search",
    },
    debug = {
      enabled = true,
      show_scores = true,
    },
  },
  lazy = false,
  -- keys = {
  --   {
  --     "<leader><space>",
  --     function()
  --       require("fff").find_files()
  --     end,
  --     desc = "FFFind files",
  --   },
  -- },
}
