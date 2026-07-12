vim.pack.add({
  "https://github.com/MagicDuck/grug-far.nvim",
})

local gr = require("grug-far")

gr.setup({
  headerMaxWidth = 80,
})

vim.keymap.set({ "n", "v" }, "<leader>sr", function()
  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")

  gr.open({
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
    },
  })
end, { desc = "Find and replace" })
