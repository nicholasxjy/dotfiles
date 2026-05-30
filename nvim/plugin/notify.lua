local notify_opts = {
  render = "wrapped-compact",
  stages = "fade_in_slide_out",
  on_open = function(win)
    local buf = vim.api.nvim_win_get_buf(win)
    vim.bo[buf].filetype = "markdown"
  end,
}

local progress_opts = {
  notification = notify_opts,
}

require("notify").setup(notify_opts)
require("lsp-progress-notify").setup(progress_opts)

vim.keymap.set("n", "<leader>un", function()
  require("notify").clear_history()
end, { desc = "Clear Notifications" })
