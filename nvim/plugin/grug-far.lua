vim.pack.add({
  "https://github.com/MagicDuck/grug-far.nvim",
}, { load = false })

local loaded = false

local function load_grug_far()
  if loaded then
    return require("grug-far")
  end

  vim.cmd.packadd("grug-far.nvim")

  local gr = require("grug-far")

  gr.setup({
    headerMaxWidth = 80,
  })

  loaded = true

  return gr
end

vim.keymap.set({ "n", "v" }, "<leader>sr", function()
  local gr = load_grug_far()
  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")

  gr.open({
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
    },
  })
end, { desc = "Find and replace" })
