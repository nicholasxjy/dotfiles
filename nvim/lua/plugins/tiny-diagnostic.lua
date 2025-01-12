return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach", -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  config = function()
    vim.diagnostic.config({ virtual_text = false })
    require("tiny-inline-diagnostic").setup({
      preset = "modern",
      options = {
        show_source = true,
        use_icons_from_diagnostic = true,
        multilines = {
          enabled = true,
          always_show = true,
        },
      },
    })
  end,
}
