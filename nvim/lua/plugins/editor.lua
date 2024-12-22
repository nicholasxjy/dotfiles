return {
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      timeout = 1,
      maxkeys = 5,
      position = "bottom-center",
    },
  },
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup({
        auto_cmd = true,
      })
    end,
  },
  {
    "tris203/precognition.nvim",
    opts = {
      startVisible = false,
      disabled_fts = {
        "startify",
        "lazy",
        "mason",
        "trouble",
        "neo-tree",
        "NeoTree",
        "Trouble",
        "markdown",
        "dashboard",
        "Dashboard",
      },
    },
  },
}
