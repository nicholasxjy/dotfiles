local oil = require("oil")
oil.setup({
  default_file_explorer = true,
  watch_for_changes = false,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
  },
  confirmation = {
    border = "single",
  },
  keymaps = {
    ["q"] = "actions.close",
    ["<Esc>"] = "actions.parent",
  },
})

vim.keymap.set("n", "<leader>o", function()
  oil.open()
end, { desc = "Oil", silent = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(event)
    if event.data.actions[1].type == "move" then
      Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
    end
  end,
})
