if vim.env.HERDR_ENV ~= "1" then
  return
end

local loader = require("loader")

local function setup()
  vim.cmd.packadd("herdr-splits.nvim")

  local hs = require("herdr-splits")

  hs.setup({
    default_amount = 0.03,
    neovim_amount = 3,
    at_edge = "wrap",
    ignored_buftypes = { "nofile", "quickfix", "prompt", "help", "terminal" },
    ignored_filetypes = {
      "NvimTree",
      "neo-tree",
      "snacks_dashboard",
      "snacks_explorer",
      "snacks_picker",
      "dadbod-ui",
      "dbout",
      "aerial",
      "Outline",
      "Trouble",
      "quickfix",
    },
    move_cursor_same_row = false,
    herdr_bin = nil,
    floating_zindex_max = 50,
    ignore_previewwindows = false,
    nav_keys = { left = "<C-h>", down = "<C-j>", up = "<C-k>", right = "<C-l>" },
    resize_keys = { left = "<M-h>", down = "<M-j>", up = "<M-k>", right = "<M-l>" },
    unzoom_on_nav = true,
    nav_at_edge = "wrap",
  })

  vim.keymap.set("n", "<C-h>", function()
    hs.move_cursor_left()
  end, { desc = "Navigate left" })
  vim.keymap.set("n", "<C-j>", function()
    hs.move_cursor_down()
  end, { desc = "Navigate down" })
  vim.keymap.set("n", "<C-k>", function()
    hs.move_cursor_up()
  end, { desc = "Navigate up" })
  vim.keymap.set("n", "<C-l>", function()
    hs.move_cursor_right()
  end, { desc = "Navigate right" })
  -- vim.keymap.set("n", "<M-h>", function()
  --   hs.resize_left()
  -- end, { desc = "Resize left" })
  -- vim.keymap.set("n", "<M-j>", function()
  --   hs.resize_down()
  -- end, { desc = "Resize down" })
  -- vim.keymap.set("n", "<M-k>", function()
  --   hs.resize_up()
  -- end, { desc = "Resize up" })
  -- vim.keymap.set("n", "<M-l>", function()
  --   hs.resize_right()
  -- end, { desc = "Resize right" })
end

loader.defer("herdr-splits", setup)
