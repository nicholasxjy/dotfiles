vim.pack.add({
  "https://github.com/folke/flash.nvim",
})

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
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    flash.treesitter()
  end
end, { desc = "Flash treesitter" })
