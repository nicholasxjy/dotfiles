require("notify").setup({
  render = "wrapped-compact",
  stages = "fade_in_slide_out",
  on_open = function(win)
    local buf = vim.api.nvim_win_get_buf(win)
    vim.bo[buf].filetype = "markdown"
  end,
})
vim.notify = require("notify")

-- require("lsp-progress-notify").setup({
--   notification = {
--     render = "wrapped-compact",
--     stages = "fade_in_slide_out",
--     -- on_open = function(win)
--     --   local buf = vim.api.nvim_win_get_buf(win)
--     --   vim.bo[buf].filetype = "markdown"
--     -- end,
--   },
-- })

vim.keymap.set("n", "<leader>un", function()
  require("notify").clear_history()
end, { desc = "Clear Notifications" })

vim.keymap.set("n", "<leader>N", function()
  require("notify").history()
end, { desc = "Notifications" })
