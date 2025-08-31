return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "echasnovski/mini.icons" },
  cmd = "Fyler",
  keys = {
    { "<leader>o", "<CMD>Fyler<CR>", desc = "Open fyler" },
  },
  opts = {
    views = {
      explorer = {
        close_on_select = true,
        -- Changes explorer behaviour to auto confirm simple edits
        confirm_simple = true,
        -- Changes explorer behaviour to hijack NETRW
        default_explorer = true,
        win = {
          border = "rounded",
          kind_presets = {
            float = {
              height = "0.8rel",
              width = "0.8rel",
              top = "0.1rel",
              left = "0.1rel",
            },
          },
        },
      },
    },
  },
}
