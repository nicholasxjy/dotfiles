local util = require("util")

local function grug_far()
  util.ensure_plugin("grug-far.nvim", function()
    require("grug-far").setup({
      headerMaxWidth = 80,
    })
  end)

  return require("grug-far")
end

vim.keymap.set({ "n", "v" }, "<leader>sr", function()
  local grug = grug_far()
  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
  grug.open({
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
    },
  })
end, { desc = "Find and replace" })
