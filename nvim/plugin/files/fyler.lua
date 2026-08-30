require("loader").packadd("fyler.nvim")
local fyler = require("fyler")

fyler.setup({
  -- Whether to skip confirmation for "simple" mutations. A simple mutation
  -- follows: copy <= 1 and create <= 5 and delete <= 0 and move <= 1
  auto_confirm_simple_mutation = false,
  -- Restricts cursor from moving outside editable region
  bound_cursor = true,
  -- Buffer-local options applied to the finder buffer
  -- (see: nvim_set_option_value)
  buf_opts = {},
  -- Follow current file
  follow_current_file = true,
  -- Table of extensions to enable (e.g., 'git', 'trash', 'watcher')
  extensions = {},
  -- Event hooks for custom behavior (on_highlight, on_delete, on_rename)
  hooks = {},
  -- External integrations (e.g., icon provider)
  integrations = {},
  -- Window-local options applied to the finder window
  -- (see: nvim_set_option_value)
  win_opts = {},
  -- Buffer kind to use globally.
  kind = "replace",
  -- Per-kind preset overrides. Each preset can contain mappings,
  -- buf_opts, win_opts, and any window layout fields
  kind_presets = {
    floating = {
      -- Border style (see: :h winborder)
      border = vim.o.winborder,
      -- Size of buffer:
      -- - string with '%' for relative (e.g. '70%')
      -- - number for absolute
      height = "80%",
      mappings = {
        n = {
          ["<CR>"] = {
            action = "select",
            args = { close = true, pick = true },
          },
        },
      },
      width = "60%",
      -- Horizontal alignment: 'start' | 'center' | 'end'
      col = "center",
      -- Vertical alignment: 'start' | 'center' | 'end'
      row = "center",
    },
    replace = {
      mappings = {
        n = {
          ["<CR>"] = {
            action = "select",
            args = { close = true, pick = true },
          },
        },
      },
    },
    split_left_most = {
      width = "35%",
      mappings = {
        n = {
          ["<CR>"] = {
            action = "select",
            args = { close = true, pick = true },
          },
        },
      },
    },
  },
  -- Key mappings organized by mode (see: fyler.Mapping)
  mappings = {
    n = {
      ["-"] = {
        action = "visit",
        args = { parent = true },
        desc = "Go to parent directory",
      },
      ["."] = {
        action = "visit",
        args = { cursor = true },
        desc = "Enter directory under cursor",
      },
      ["<BS>"] = {
        action = "shrink",
        args = { parent = true },
        desc = "Collapse parent directory",
      },
      ["<C-R>"] = {
        action = "refresh",
        args = { recursive = true, force = true },
        desc = "Force refresh tree",
      },
      ["<C-S>"] = {
        action = "select",
        args = { split = true },
        desc = "Open in horizontal split",
      },
      ["<C-T>"] = {
        action = "select",
        args = { tabedit = true },
        desc = "Open in new tab",
      },
      ["<C-V>"] = {
        action = "select",
        args = { vsplit = true },
        desc = "Open in vertical split",
      },
      ["<CR>"] = {
        action = "select",
        args = { pick = true },
        desc = "Open with window picker",
      },
      ["<2-LeftMouse>"] = {
        action = "select",
        args = { pick = true },
        desc = "Open with window picker",
      },
      ["="] = {
        action = "visit",
        desc = "Go to root directory",
      },
      ["g."] = {
        action = "toggle_ui",
        args = { "hidden_items" },
        desc = "Toggle hidden files",
      },
      ["gi"] = {
        action = "toggle_ui",
        args = { "indent_guides" },
        desc = "Toggle indent guides",
      },
      ["q"] = {
        action = "close",
        desc = "Close finder",
      },
    },
  },
  -- UI configuration
  ui = {
    hidden_items = {
      -- Toggleable pre-defined switches (e.g. 'dotfiles' to hide files).
      switches = { "dotfiles" },
      -- Toggleable patterns (Lua patterns matched against the full path).
      patterns = {},
      -- Always visible items matching these patterns, even if they would
      -- normally be hidden.
      always_visible = {},
      -- Always hide items matching these patterns, even if they would
      -- normally be visible.
      always_hidden = {},
    },
    -- Whether to draw indent guides at each depth level.
    indent_guides = true,
  },
  -- Follow the finder root as the tab-local working directory.
  follow_root_dir = true,
  -- Keep directory editing with netrw; explorers are opened explicitly below.
  use_as_default_explorer = false,
})

vim.keymap.set("n", "<leader>o", function()
  fyler.open({ kind = "split_left_most" })
end, { desc = "Fyler" })
