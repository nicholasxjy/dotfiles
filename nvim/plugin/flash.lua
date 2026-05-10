local util = require("util")

local function flash()
  util.ensure_plugin("flash.nvim", function()
    require("flash").setup({
      label = {
        rainbow = {
          enabled = true,
          shade = 5,
        },
      },
    })
  end)

  return require("flash")
end

vim.keymap.set({ "n", "x", "o" }, "s", function()
  flash().jump()
end, { desc = "Flash" })

vim.keymap.set({ "n", "x", "o" }, "S", function()
  flash().treesitter()
end, { desc = "Flash treesitter" })
