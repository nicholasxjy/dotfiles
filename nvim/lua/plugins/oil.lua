return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    watch_for_changes = true,
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
      ["<Tab>"] = {
        "actions.select",
        opts = { tab = true },
        desc = "Open the entry in new tab",
      },
      ["q"] = "actions.close",
      ["<Esc>"] = "actions.parent",
    },
  },
  cmd = "Oil",
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  lazy = false,
  keys = {
    { "<leader>o", "<cmd>Oil<cr>", desc = "Open Oil File Explorer" },
  },
}
