local util = require("util")
local set = vim.keymap.set

local function multicursor()
  util.ensure_plugin("multicursor.nvim", function()
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
  end)

  return require("multicursor-nvim")
end

set({ "n", "x" }, "\\", function()
  multicursor().addCursor()
end, { desc = "Add Cursor" })

set({ "n", "x" }, "<up>", function()
  multicursor().lineAddCursor(-1)
end, { desc = "Add Cursor Above" })
set({ "n", "x" }, "<down>", function()
  multicursor().lineAddCursor(1)
end, { desc = "Add Cursor Below" })

set({ "n", "x" }, "<leader><up>", function()
  multicursor().lineSkipCursor(-1)
end)
set({ "n", "x" }, "<leader><down>", function()
  multicursor().lineSkipCursor(1)
end)

set({ "n", "x" }, "<C-d>", function()
  multicursor().matchAddCursor(1)
end, { desc = "Match Next" })

set({ "n", "x" }, "\\n", function()
  multicursor().matchAddCursor(-1)
end, { desc = "Match Prev" })

set("n", "<c-leftmouse>", function()
  multicursor().handleMouse()
end)
set("n", "<c-leftdrag>", function()
  multicursor().handleMouseDrag()
end)
set("n", "<c-leftrelease>", function()
  multicursor().handleMouseRelease()
end)

set({ "n", "x" }, "<c-q>", function()
  multicursor().toggleCursor()
end)
