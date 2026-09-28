local loader = require("loader")
local ui = require("ui")

-- ============================================================================
-- Neo-tree (Sidebar Explorer)
-- ============================================================================
local neotree_is_setup = false

local function setup_neotree()
  if neotree_is_setup then
    return
  end

  loader.packadd("plenary.nvim", "nui.nvim", "nvim-window-picker", "nvim-file-operations", "neo-tree.nvim")

  local has_picker, picker = pcall(require, "window-picker")
  if has_picker then
    picker.setup({
      filter_rules = {
        include_current_win = false,
        autoselect_one = true,
        bo = {
          filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },
          buftype = { "terminal", "quickfix" },
        },
      },
    })
  end

  local has_file_ops, file_ops = pcall(require, "nvim-file-operations")
  if not has_file_ops then
    has_file_ops, file_ops = pcall(require, "lsp-file-operations")
  end
  if has_file_ops then
    file_ops.setup()
  end

  require("neo-tree").setup({
    close_if_last_window = false,
    popup_border_style = vim.o.winborder ~= "" and vim.o.winborder or "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
    sort_case_insensitive = false,
    sources = { "filesystem", "buffers", "git_status" },
    source_selector = {
      winbar = true,
      statusline = false,
      sources = {
        { source = "filesystem", display_name = " 󰉓 Files " },
        { source = "buffers", display_name = " 󰈚 Buffers " },
        { source = "git_status", display_name = " 󰊢 Git " },
      },
    },
    default_component_configs = {
      container = {
        enable_character_fade = true,
      },
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
      },
      modified = {
        symbol = "[+]",
        highlight = "NeoTreeModified",
      },
      git_status = {
        symbols = {
          added = vim.trim(ui.icons.git.added or ""),
          modified = vim.trim(ui.icons.git.modified or ""),
          deleted = vim.trim(ui.icons.git.removed or ""),
          renamed = "󰁕",
          untracked = "",
          ignored = "",
          unstaged = "󰄱",
          staged = "",
          conflict = "",
        },
      },
      diagnostics = {
        symbols = {
          error = vim.trim(ui.icons.diagnostics.Error or ""),
          warn = vim.trim(ui.icons.diagnostics.Warn or ""),
          info = vim.trim(ui.icons.diagnostics.Info or ""),
          hint = vim.trim(ui.icons.diagnostics.Hint or "󰌵"),
        },
      },
    },
    window = {
      position = "left",
      width = 35,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["<space>"] = "none",
        ["l"] = "open",
        ["h"] = "close_node",
        ["<CR>"] = "open",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["w"] = "open_with_window_picker",
        ["P"] = {
          "toggle_preview",
          config = {
            use_float = true,
          },
        },
        ["C"] = "close_node",
        ["z"] = "close_all_nodes",
        ["Z"] = "expand_all_nodes",
        ["a"] = {
          "add",
          config = {
            show_path = "none",
          },
        },
        ["A"] = "add_directory",
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy",
        ["m"] = "move",
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
      },
    },
    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      use_libuv_file_watcher = true,
      hijack_netrw_behavior = "disabled",
      filtered_items = {
        visible = false,
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_hidden = true,
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
      },
    },
    buffers = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      group_empty_dirs = true,
      show_unloaded = true,
    },
    git_status = {
      window = {
        position = "float",
      },
    },
  })
  neotree_is_setup = true
end

local function toggle_neotree(args)
  setup_neotree()
  vim.cmd("Neotree " .. (args or "toggle"))
end

vim.api.nvim_create_user_command("Neotree", function(ctx)
  setup_neotree()
  local fargs = ctx.fargs or {}
  require("neo-tree.command")._command(unpack(fargs))
end, {
  nargs = "*",
  complete = function(arglead, cmdline, cursorpos)
    setup_neotree()
    return require("neo-tree.command").complete_args(arglead, cmdline, cursorpos)
  end,
})

vim.keymap.set("n", "<leader>fe", function()
  toggle_neotree("filesystem toggle reveal")
end, { desc = "Neo-tree (Filesystem)" })

vim.keymap.set("n", "<leader>E", function()
  toggle_neotree("toggle")
end, { desc = "Neo-tree Toggle" })

vim.keymap.set("n", "<leader>ge", function()
  toggle_neotree("git_status toggle")
end, { desc = "Neo-tree (Git Status)" })

vim.keymap.set("n", "<leader>be", function()
  toggle_neotree("buffers toggle")
end, { desc = "Neo-tree (Buffers)" })

-- ============================================================================
-- Fyler (Floating Column Finder)
-- ============================================================================
local fyler_is_setup = false

local function setup_fyler()
  if fyler_is_setup then
    return
  end

  loader.packadd("fyler.nvim")
  local fyler = require("fyler")

  fyler.setup({
    auto_confirm_simple_mutation = false,
    bound_cursor = true,
    buf_opts = {},
    follow_current_file = true,
    extensions = {
      git = { enabled = true },
      watcher = { enabled = true },
    },
    hooks = {},
    integrations = {
      icon = "mini_icons",
    },
    win_opts = {},
    kind = "floating",
    kind_presets = {
      floating = {
        border = vim.o.winborder,
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
        col = "center",
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
    mappings = {
      n = {
        ["-"] = { action = "visit", args = { parent = true }, desc = "Go to parent directory" },
        ["."] = { action = "visit", args = { cursor = true }, desc = "Enter directory under cursor" },
        ["<BS>"] = { action = "shrink", args = { parent = true }, desc = "Collapse parent directory" },
        ["<C-R>"] = { action = "refresh", args = { recursive = true, force = true }, desc = "Force refresh tree" },
        ["<C-S>"] = { action = "select", args = { split = true }, desc = "Open in horizontal split" },
        ["<C-T>"] = { action = "select", args = { tabedit = true }, desc = "Open in new tab" },
        ["<C-V>"] = { action = "select", args = { vsplit = true }, desc = "Open in vertical split" },
        ["<CR>"] = { action = "select", args = { pick = true }, desc = "Open with window picker" },
        ["<2-LeftMouse>"] = { action = "select", args = { pick = true }, desc = "Open with window picker" },
        ["="] = { action = "visit", desc = "Go to root directory" },
        ["g."] = { action = "toggle_ui", args = { "hidden_items" }, desc = "Toggle hidden files" },
        ["gi"] = { action = "toggle_ui", args = { "indent_guides" }, desc = "Toggle indent guides" },
        ["q"] = { action = "close", desc = "Close finder" },
      },
    },
    ui = {
      hidden_items = {
        switches = {},
        patterns = {},
        always_visible = {},
        always_hidden = {},
      },
      indent_guides = true,
    },
    follow_root_dir = true,
    use_as_default_explorer = false,
  })
  fyler_is_setup = true
end

vim.api.nvim_create_user_command("Fyler", function(ctx)
  setup_fyler()
  require("fyler").open(ctx.args ~= "" and { kind = ctx.args } or { kind = "floating" })
end, { nargs = "?", desc = "Open Fyler file manager" })

vim.keymap.set("n", "<leader>o", function()
  setup_fyler()
  require("fyler").open({ kind = "floating" })
end, { desc = "Fyler" })

-- ============================================================================
-- Mini.files (Modal in-buffer Explorer)
-- ============================================================================
local function open_buf_in_split(buf_id, key_map, direction)
  local MiniFiles = require("mini.files")

  local function rhs()
    local cur_target = MiniFiles.get_explorer_state().target_window

    if cur_target == nil or MiniFiles.get_fs_entry().fs_type == "directory" then
      return
    end

    local new_target = vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. " split")
      return vim.api.nvim_get_current_win()
    end)
    MiniFiles.set_target_window(new_target)
    MiniFiles.go_in({ close_on_file = true })
  end

  vim.keymap.set("n", key_map, rhs, { buffer = buf_id, desc = "Open in " .. string.sub(direction, 12) })
end

local function setup_mini_files()
  loader.packadd("mini.files")

  require("mini.files").setup({
    mappings = {
      show_help = "?",
      go_in_plus = "<cr>",
      go_out_plus = "-",
    },
    content = {
      filter = function(entry)
        return entry.name ~= ".DS_Store"
      end,
    },
    options = { permanent_delete = false, use_as_default_explorer = false },
  })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesWindowOpen",
  callback = function(args)
    local win_id = args.data.win_id
    vim.wo[win_id].winblend = 0
    local config = vim.api.nvim_win_get_config(win_id)
    config.border = vim.o.winborder
    vim.api.nvim_win_set_config(win_id, config)
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    vim.keymap.set("n", "g.", function()
      vim.g.show_dotfiles = not vim.g.show_dotfiles
      require("mini.files").refresh({
        content = {
          filter = function(entry)
            return vim.g.show_dotfiles or entry.name:sub(1, 1) ~= "."
          end,
        },
      })
    end, { buffer = buf_id, desc = "Toggle Dotfiles" })

    open_buf_in_split(buf_id, "<C-h>", "topleft vertical")
    open_buf_in_split(buf_id, "<C-j>", "belowright horizontal")
    open_buf_in_split(buf_id, "<C-k>", "topleft horizontal")
    open_buf_in_split(buf_id, "<C-l>", "belowright vertical")
    open_buf_in_split(buf_id, "<C-t>", "tab")
  end,
})

vim.keymap.set("n", "<leader>e", function()
  if not loader.load("mini-files", setup_mini_files) then
    return
  end
  local bufname = vim.api.nvim_buf_get_name(0)
  local path = vim.fn.fnamemodify(bufname, ":p")

  if path and vim.uv.fs_stat(path) then
    require("mini.files").open(bufname, false)
  else
    require("mini.files").open()
  end
end, { desc = "Mini files", silent = true })
