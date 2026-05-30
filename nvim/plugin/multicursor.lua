local set = vim.keymap.set

local mc = require("multicursor-nvim")
mc.setup()

mc.addKeymapLayer(function(layerSet)
  layerSet({ "n", "x" }, "<left>", mc.prevCursor)
  layerSet({ "n", "x" }, "<right>", mc.nextCursor)
  layerSet("n", "<esc>", function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    else
      mc.clearCursors()
    end
  end)
end)

local hl = vim.api.nvim_set_hl
hl(0, "MultiCursorCursor", { reverse = true })
hl(0, "MultiCursorVisual", { link = "Visual" })
hl(0, "MultiCursorSign", { link = "SignColumn" })
hl(0, "MultiCursorMatchPreview", { link = "IncSearch" })
hl(0, "MultiCursorDisabledCursor", { reverse = true })
hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })

set({ "n", "x" }, "\\", function()
  mc.addCursor()
end, { desc = "Add Cursor" })

set({ "n", "x" }, "<up>", function()
  mc.lineAddCursor(-1)
end, { desc = "Add Cursor Above" })
set({ "n", "x" }, "<down>", function()
  mc.lineAddCursor(1)
end, { desc = "Add Cursor Below" })

set({ "n", "x" }, "<leader><up>", function()
  mc.lineSkipCursor(-1)
end)
set({ "n", "x" }, "<leader><down>", function()
  mc.lineSkipCursor(1)
end)

set({ "n", "x" }, "<C-d>", function()
  mc.matchAddCursor(1)
end, { desc = "Match Next" })

set({ "n", "x" }, "\\n", function()
  mc.matchAddCursor(-1)
end, { desc = "Match Prev" })

set("n", "<c-leftmouse>", function()
  mc.handleMouse()
end)
set("n", "<c-leftdrag>", function()
  mc.handleMouseDrag()
end)
set("n", "<c-leftrelease>", function()
  mc.handleMouseRelease()
end)

set({ "n", "x" }, "<c-q>", function()
  mc.toggleCursor()
end)
