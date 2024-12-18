return {
  "brenoprata10/nvim-highlight-colors",
  config = function()
    require("nvim-highlight-colors").setup({
      render = "virtual",
      virtual_symbol = "󰻂",
      enable_tailwind = true,
      exclude_filetypes = {},
      exclude_buftypes = {},
    })
  end,
}
