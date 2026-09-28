local loader = require("loader")

loader.on_very_lazy("navigation", function()
  loader.packadd("smart-splits.nvim", "flash.nvim", "multicursor.nvim")

  -- Smart-splits (seamless window navigation)
  local ss = require("smart-splits")
  ss.setup({
    ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
    ignored_buftypes = { "nofile" },
  })

  vim.keymap.set("n", "<C-h>", function()
    ss.move_cursor_left()
  end, { desc = "Focus Left" })
  vim.keymap.set("n", "<C-j>", function()
    ss.move_cursor_down()
  end, { desc = "Focus Down" })
  vim.keymap.set("n", "<C-k>", function()
    ss.move_cursor_up()
  end, { desc = "Focus Up" })
  vim.keymap.set("n", "<C-l>", function()
    ss.move_cursor_right()
  end, { desc = "Focus Right" })

  -- Flash (jump navigation)
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
  end, { desc = "Flash Jump" })

  vim.keymap.set({ "n", "x", "o" }, "S", function()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
      flash.treesitter()
    end
  end, { desc = "Flash Treesitter" })

  -- Multicursor
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

  local set = vim.keymap.set

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
  end, { desc = "Skip Cursor Above" })
  set({ "n", "x" }, "<leader><down>", function()
    mc.lineSkipCursor(1)
  end, { desc = "Skip Cursor Below" })

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
  end, { desc = "Toggle Cursors" })
end)
