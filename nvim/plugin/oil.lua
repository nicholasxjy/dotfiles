local function setup_oil()
  if vim.g.oil_setup_done then
    return require("oil")
  end
  vim.g.oil_setup_done = true

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

  return oil
end

vim.api.nvim_create_user_command("Oil", function(opts)
  setup_oil().open(opts.args ~= "" and opts.args or nil)
end, { nargs = "?", complete = "dir" })

vim.keymap.set("n", "<leader>o", function()
  setup_oil().open()
end, { desc = "Oil", silent = true })
