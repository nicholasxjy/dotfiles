return {
  "vuki656/package-info.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  event = "BufRead package.json",
  config = function()
    require("package-info").setup()
  end,
}
