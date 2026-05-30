local yanky = require("yanky")

yanky.setup({
  system_clipboard = {
    sync_with_ring = true,
    clipboard_register = nil,
  },
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 500,
  },
  preserve_cursor_position = {
    enabled = true,
  },
})

local function yanky_put(type, is_visual)
  return function()
    yanky.put(type, is_visual)
  end
end

vim.keymap.set("n", "p", yanky_put("p", false), { desc = "Put After" })
vim.keymap.set("n", "P", yanky_put("P", false), { desc = "Put Before" })
vim.keymap.set("n", "gp", yanky_put("gp", false), { desc = "Put After and Leave Cursor After" })
vim.keymap.set("n", "gP", yanky_put("gP", false), { desc = "Put Before and Leave Cursor Before" })
vim.keymap.set("x", "p", yanky_put("p", true), { desc = "Put After" })
vim.keymap.set("x", "P", yanky_put("P", true), { desc = "Put Before" })
vim.keymap.set("x", "gp", yanky_put("gp", true), { desc = "Put After and Leave Cursor After" })
vim.keymap.set("x", "gP", yanky_put("gP", true), { desc = "Put Before and Leave Cursor Before" })

vim.keymap.set({ "n", "x" }, "<leader>up", function()
  ---@diagnostic disable-next-line: undefined-field
  Snacks.picker.yanky()
end, { desc = "Open Yank History" })
