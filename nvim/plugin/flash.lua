vim.pack.add({
  "https://github.com/folke/flash.nvim",
}, { load = false })

local loaded = false

local function load_flash()
  if loaded then
    return require("flash")
  end

  vim.cmd.packadd("flash.nvim")

  local flash = require("flash")
  flash.setup({
    label = {
      rainbow = {
        enabled = true,
        shade = 5,
      },
    },
  })

  loaded = true

  return flash
end

vim.keymap.set({ "n", "x", "o" }, "s", function()
  load_flash().jump()
end, { desc = "Flash" })

vim.keymap.set({ "n", "x", "o" }, "S", function()
  load_flash().treesitter()
end, { desc = "Flash treesitter" })
