vim.pack.add({
  "https://github.com/jake-stewart/multicursor.nvim",
}, { load = false })

local loaded = false

local function load_multicursor()
  if loaded then
    return require("multicursor-nvim")
  end

  vim.cmd.packadd("multicursor.nvim")

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

  loaded = true

  return mc
end

local set = vim.keymap.set

set({ "n", "x" }, "\\", function()
  load_multicursor().addCursor()
end, { desc = "Add Cursor" })

set({ "n", "x" }, "<up>", function()
  load_multicursor().lineAddCursor(-1)
end, { desc = "Add Cursor Above" })
set({ "n", "x" }, "<down>", function()
  load_multicursor().lineAddCursor(1)
end, { desc = "Add Cursor Below" })

set({ "n", "x" }, "<leader><up>", function()
  load_multicursor().lineSkipCursor(-1)
end)
set({ "n", "x" }, "<leader><down>", function()
  load_multicursor().lineSkipCursor(1)
end)

set({ "n", "x" }, "<C-d>", function()
  load_multicursor().matchAddCursor(1)
end, { desc = "Match Next" })

set({ "n", "x" }, "\\n", function()
  load_multicursor().matchAddCursor(-1)
end, { desc = "Match Prev" })

set("n", "<c-leftmouse>", function()
  load_multicursor().handleMouse()
end)
set("n", "<c-leftdrag>", function()
  load_multicursor().handleMouseDrag()
end)
set("n", "<c-leftrelease>", function()
  load_multicursor().handleMouseRelease()
end)

set({ "n", "x" }, "<c-q>", function()
  load_multicursor().toggleCursor()
end)
