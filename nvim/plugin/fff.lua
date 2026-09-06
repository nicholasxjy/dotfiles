local loader = require("loader")

vim.g.fff = {
  layout = {
    prompt_position = "top",
  },
  file_picker = {
    current_file_label = "(current)", -- virtual text marking the buffer the picker was opened from
    fuzzy_query_highlighting = true, -- true to highlight fuzzy query matches, not just the literal query
  },
  git = {
    status_text_color = true, -- true to color filenames by git status
  },
  hl = {
    grep_match = "SnacksPickerMatch",
    matched = "SnacksPickerMatch",
    directory_path = "SnacksPickerDir",
  },
  keymaps = {
    move_up = { "<Up>", "<C-p>", "<C-k>" },
    move_down = { "<Down>", "<C-n>", "<C-j>" },
  },
  lazy_sync = true,
  debug = { enabled = true, show_scores = true },
}

local opts = {
  show_git_status = true,
  keymaps = {
    next = { "<C-n>", "<C-j>" },
    previous = { "<C-p>", "<C-k>" },
  },
}

local setup = function()
  loader.packadd("fff", "minibuffer.nvim")

  local ok, fff_mb = pcall(require, "minibuffer.integrations.fff")

  if ok then
    vim.keymap.set("n", "<leader><space>", function()
      fff_mb.file_search("", opts)
    end, { desc = "FFFind" })

    vim.keymap.set("n", "<leader>sg", function()
      fff_mb.content_search("", opts)
    end, { desc = "FFFGrep" })
  end
end

loader.on_very_lazy("fff", setup)
