local loader = require("loader")

loader.on_very_lazy("navigation", function()
  loader.packadd("flash.nvim")

  -- Load only one split backend so its mappings and multiplexer hooks agree.
  local in_herdr = vim.env.HERDR_ENV == "1"
  local herdr_bin = vim.env.HERDR_BIN_PATH
  if not herdr_bin or herdr_bin == "" or vim.fn.executable(herdr_bin) ~= 1 then
    herdr_bin = "herdr"
  end
  local use_herdr = in_herdr and vim.fn.executable(herdr_bin) == 1
  local splits

  if use_herdr then
    loader.packadd("herdr-splits.nvim")
    splits = require("herdr-splits")
    splits.setup({
      herdr_bin = herdr_bin,
      neovim_amount = 2,
      -- Alt+j/k move lines; Alt+h/l switch Herdr tabs. Keep those bindings.
      resize_keys = {
        left = "<C-Left>",
        down = "<C-Down>",
        up = "<C-Up>",
        right = "<C-Right>",
      },
    })
    splits.add_ignored_filetype("qf")
  else
    if in_herdr then
      vim.g.smart_splits_multiplexer_integration = false
    end
    loader.packadd("smart-splits.nvim")
    splits = require("smart-splits")
    splits.setup({
      ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
      ignored_buftypes = { "nofile" },
    })
  end

  for _, direction in ipairs({
    { "h", "left", "Left" },
    { "j", "down", "Down" },
    { "k", "up", "Up" },
    { "l", "right", "Right" },
  }) do
    vim.keymap.set("n", "<C-" .. direction[1] .. ">", function()
      if in_herdr and not use_herdr then
        vim.notify_once("herdr executable not found; using Neovim split navigation", vim.log.levels.WARN)
      end
      splits["move_cursor_" .. direction[2]]()
    end, { desc = "Focus " .. direction[3] })

    if use_herdr then
      vim.keymap.set("n", "<C-" .. direction[3] .. ">", function()
        splits["resize_" .. direction[2]]()
      end, { desc = "Resize " .. direction[3] })
    end
  end

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

  local function setup_multicursor()
    loader.packadd("multicursor.nvim")
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
  end

  local function action(method, ...)
    local args = { ... }
    return function()
      if loader.load("multicursor", setup_multicursor) then
        require("multicursor-nvim")[method](unpack(args))
      end
    end
  end

  local set = vim.keymap.set
  set({ "n", "x" }, "\\", action("addCursor"), { desc = "Add Cursor" })
  set({ "n", "x" }, "<up>", action("lineAddCursor", -1), { desc = "Add Cursor Above" })
  set({ "n", "x" }, "<down>", action("lineAddCursor", 1), { desc = "Add Cursor Below" })
  set({ "n", "x" }, "<leader><up>", action("lineSkipCursor", -1), { desc = "Skip Cursor Above" })
  set({ "n", "x" }, "<leader><down>", action("lineSkipCursor", 1), { desc = "Skip Cursor Below" })
  set({ "n", "x" }, "<C-d>", action("matchAddCursor", 1), { desc = "Match Next" })
  set({ "n", "x" }, "\\n", action("matchAddCursor", -1), { desc = "Match Prev" })
  set("n", "<c-leftmouse>", action("handleMouse"))
  set("n", "<c-leftdrag>", action("handleMouseDrag"))
  set("n", "<c-leftrelease>", action("handleMouseRelease"))
  set({ "n", "x" }, "<c-q>", action("toggleCursor"), { desc = "Toggle Cursors" })
end)
