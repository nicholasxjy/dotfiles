return {
  "leath-dub/snipe.nvim",
  event = "VeryLazy",
  enabled = false,
  keys = {
    {
      "nn",
      function()
        require("snipe").open_buffer_menu()
      end,
      desc = "Open Snipe buffer menu",
      silent = true,
    },
  },
  opts = {
    ui = {
      position = "cursor",
      text_align = "file-first",
    },
    sort = "last",
  },
}
