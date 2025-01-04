return {
  "numToStr/Navigator.nvim",
  cmd = {
    "NavigatorLeft",
    "NavigatorRight",
    "NavigatorUp",
    "NavigatorDown",
  },
  config = function()
    require("Navigator").setup({
      disable_on_zoom = true,
    })
  end,
}
