return {
  "atiladefreitas/dooing",
  cmd = { "Dooing" },
  config = function()
    require("dooing").setup({
      keymaps = {
        toggle_window = "<leader>]",
      },
    })
  end,
}
