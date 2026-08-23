-- Eager: `default_file_explorer` has to claim the buffer before Nvim's own
-- directory handler does, which happens while the first argument is opened.
require("loader").packadd("oil.nvim")

local oil = require("oil")
oil.setup({
  default_file_explorer = true,
  watch_for_changes = false,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
  },
  confirmation = {
    border = vim.o.winborder,
  },
  preview_win = {
    update_on_cursor_moved = true,
  },
  float = {
    border = vim.o.winborder,
  },
  keymaps = {
    ["q"] = "actions.close",
    ["<Esc>"] = "actions.parent",
  },
})

-- Automatically open preview window
vim.api.nvim_create_autocmd("User", {
  pattern = "OilEnter",
  callback = vim.schedule_wrap(function(args)
    if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
      oil.open_preview()
    end
  end),
})

vim.keymap.set("n", "<leader>o", function()
  oil.open_float()
end, { desc = "Oil", silent = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(event)
    local action = event.data.actions[1]
    if action and action.type == "move" then
      Snacks.rename.on_rename_file(action.src_url, action.dest_url)
    end
  end,
})
