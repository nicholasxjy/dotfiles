local util = require("util")

local function oil()
  util.ensure_plugin("oil.nvim", function()
    require("oil").setup({
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
  end)

  return require("oil")
end

vim.keymap.set("n", "<leader>o", function()
  oil().open()
end, { desc = "Oil", silent = true })
