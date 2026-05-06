local util = require("util")

util.later(function()
  require("flash").setup({
    label = {
      rainbow = {
        enabled = true,
        shade = 5,
      },
    },
  })
end, 20, "VimEnter", true)

vim.keymap.set({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })

vim.keymap.set({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash treesitter" })
