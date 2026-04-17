return {
  "vuki656/package-info.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  event = "BufRead package.json",
  keys = {
    {
      "<leader>pf",
      function()
        require("package-info").show({ force = true })
      end,
      desc = "package info",
    },
  },
  config = function()
    require("package-info").setup({
      autostart = false,
    })
  end,
}
