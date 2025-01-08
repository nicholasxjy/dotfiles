return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("nightfox").setup({
      groups = {
        all = {
          TelescopeNormal = {
            bg = "bg0",
            fg = "fg1",
          },
          TelescopeBorder = {
            bg = "bg0",
            fg = "bg0",
          },
          TelescopePromptNormal = {
            bg = "bg0",
          },
          TelescopePreviewBorder = {
            bg = "bg0",
            fg = "bg0",
          },
          TelescopePromptTitle = {
            bg = "palette.red",
            fg = "bg0",
          },
          TelescopePreviewTitle = {
            bg = "palette.cyan",
            fg = "bg0",
          },
          TelescopeResultsTitle = {
            bg = "palette.green",
            fg = "bg0",
          },
        },
      },
    })
  end,
}
