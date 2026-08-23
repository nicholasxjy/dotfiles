local loader = require("loader")

loader.packadd("fff.nvim")

vim.g.fff = {
  prompt = "> ",
  title = "FFFiles",
  prompt_vim_mode = false,
  lazy_sync = true,
  layout = {
    width = 0.86,
    height = 0.74,
    preview_size = 0.42,
    preview_position = "top",
  },
  keymaps = {
    move_up = { "<Up>", "<C-p>", "<C-k>" },
    move_down = { "<Down>", "<C-n>", "<C-j>" },
  },
  hl = {
    grep_match = "SnacksPickerMatch",
    matched = "SnacksPickerMatch",
    directory_path = "SnacksPickerDir",
  },
  git = {
    status_text_color = true, -- true to color filenames by git status
  },
  file_picker = {
    fuzzy_query_highlighting = true, -- true to highlight fuzzy query matches in file picker results
  },
  debug = { enabled = true, show_scores = true },
}

-- vim.keymap.set("n", "<leader><cr>", function()
--   require("fff").resume()
-- end, { desc = "Resume" })
--
-- vim.keymap.set("n", "<leader><space>", function()
--   require("fff").find_files()
-- end, { desc = "Find files" })
--
-- vim.keymap.set("n", "<leader>sg", function()
--   require("fff").live_grep()
-- end, { desc = "Live grep" })
--
-- vim.keymap.set({ "n", "x", "v" }, "<leader>sw", function()
--   require("fff").live_grep_under_cursor()
-- end, { desc = "Grep selection" })
