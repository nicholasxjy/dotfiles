return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy", -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "classic",
      transparent_bg = true,
      transparent_cursorline = true,
      options = {
        show_source = {
          enabled = true,
          if_many = true,
        },
        set_arrow_to_diag_color = true,
        multilines = {
          enabled = true,
          always_show = true,
        },
        show_all_diags_on_cursorline = true,
        enable_on_insert = false,
        enable_on_select = false,
      },
    })
  end,
}
