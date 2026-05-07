local oil = require("oil")
oil.setup({
  default_file_explorer = true,
  watch_for_changes = false,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    -- is_always_hidden = function(name)
    --   local hidden_files = { ".DS_Store", "thumbs.db" }
    --   for _, value in ipairs(hidden_files) do
    --     if name == value then
    --       return true
    --     end
    --     return false
    --   end
    -- end,
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
