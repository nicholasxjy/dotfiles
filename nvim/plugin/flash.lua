local flash = require("flash")
flash.setup({
  label = {
    rainbow = {
      enabled = true,
      shade = 5,
    },
  },
})
vim.keymap.set({ "n", "x", "o" }, "s", function()
  flash.jump()
end, { desc = "Flash" })

vim.keymap.set({ "n", "x", "o" }, "S", function()
  flash.treesitter()
end, { desc = "Flash treesitter" })
