local loader = require("loader")
local ui = require("ui")

-- ============================================================================
-- Neo-tree (Sidebar Explorer)
-- ============================================================================
local function setup_neotree()
  loader.packadd("plenary.nvim", "nui.nvim", "nvim-window-picker", "nvim-file-operations", "neo-tree.nvim")

  require("window-picker").setup({
    filter_rules = {
      include_current_win = false,
      autoselect_one = true,
      bo = {
        filetype = { "neo-tree", "neo-tree-popup", "qf" },
        buftype = { "terminal", "quickfix" },
      },
    },
  })

  -- LSP willRename/didRename for neo-tree moves (capabilities set in lua/lsp.lua).
  require("nvim-file-operations").setup()

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
        visible = true,
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
end

local function toggle_neotree(args)
  if loader.load("neo-tree", setup_neotree) then
    vim.cmd("Neotree " .. args)
  end
end

-- Stub until first use; neo-tree's own plugin/ file replaces it on packadd.
vim.api.nvim_create_user_command("Neotree", function(ctx)
  toggle_neotree(ctx.args)
end, { nargs = "*", desc = "Neo-tree" })

vim.keymap.set("n", "<leader>fe", function()
  toggle_neotree("filesystem toggle reveal")
end, { desc = "Neo-tree (Filesystem)" })

vim.keymap.set("n", "<leader>e", function()
  toggle_neotree("toggle")
end, { desc = "Neo-tree Toggle" })

vim.keymap.set("n", "<leader>ge", function()
  toggle_neotree("git_status toggle")
end, { desc = "Neo-tree (Git Status)" })

vim.keymap.set("n", "<leader>be", function()
  toggle_neotree("buffers toggle")
end, { desc = "Neo-tree (Buffers)" })

-- ============================================================================
-- Mini.files (Modal in-buffer Explorer)
-- ============================================================================
local show_dotfiles = true

local function files_filter(entry)
  return entry.name ~= ".DS_Store" and (show_dotfiles or entry.name:sub(1, 1) ~= ".")
end

local function open_buf_in_split(buf_id, key_map, direction, desc)
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

  vim.keymap.set("n", key_map, rhs, { buffer = buf_id, desc = desc })
end

local function setup_mini_files()
  loader.packadd("mini.files")

  require("mini.files").setup({
    mappings = {
      show_help = "?",
      go_in_plus = "<cr>",
      go_out_plus = "-",
    },
    content = { filter = files_filter },
    options = { permanent_delete = false, use_as_default_explorer = false },
  })

  local group = vim.api.nvim_create_augroup("sjvim_mini_files", { clear = true })

  vim.api.nvim_create_autocmd("User", {
    group = group,
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
    group = group,
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
      local buf_id = args.data.buf_id
      vim.keymap.set("n", "g.", function()
        show_dotfiles = not show_dotfiles
        require("mini.files").refresh({ content = { filter = files_filter } })
      end, { buffer = buf_id, desc = "Toggle Dotfiles" })

      open_buf_in_split(buf_id, "<C-h>", "topleft vertical", "Open in Left Split")
      open_buf_in_split(buf_id, "<C-j>", "belowright horizontal", "Open in Below Split")
      open_buf_in_split(buf_id, "<C-k>", "topleft horizontal", "Open in Above Split")
      open_buf_in_split(buf_id, "<C-l>", "belowright vertical", "Open in Right Split")
      open_buf_in_split(buf_id, "<C-t>", "tab", "Open in Tab")
    end,
  })
end

vim.keymap.set("n", "<leader>E", function()
  if not loader.load("mini-files", setup_mini_files) then
    return
  end
  local path = vim.api.nvim_buf_get_name(0)

  if path ~= "" and vim.uv.fs_stat(path) then
    require("mini.files").open(path, false)
  else
    require("mini.files").open()
  end
end, { desc = "Mini files", silent = true })

-- ============================================================================
-- Yazi (Terminal File Manager)
-- ============================================================================
local function setup_yazi()
  loader.packadd("plenary.nvim", "yazi.nvim")

  require("yazi").setup({
    open_for_directories = false,
    integrations = {
      grep_in_directory = "fzf-lua",
      grep_in_selected_files = "fzf-lua",
    },
    keymaps = {
      -- These optional actions need dependencies beyond yazi and plenary.
      open_and_pick_window = false, -- snacks.nvim
      copy_relative_path_to_selected_files = vim.fn.executable("grealpath") == 1 and "<C-y>" or false,
    },
  })
end

local function open_yazi(args)
  for _, executable in ipairs({ "yazi", "ya" }) do
    if vim.fn.executable(executable) ~= 1 then
      vim.notify(executable .. " is not installed or not on PATH", vim.log.levels.WARN)
      return
    end
  end

  if loader.load("yazi", setup_yazi) then
    vim.api.nvim_cmd({ cmd = "Yazi", args = args or {} }, {})
  end
end

-- Replaced by yazi.nvim's command when the plugin is first loaded.
vim.api.nvim_create_user_command("Yazi", function(ctx)
  open_yazi(ctx.fargs)
end, {
  nargs = "*",
  desc = "Yazi file manager",
  complete = function(lead)
    return vim.tbl_filter(function(command)
      return vim.startswith(command, lead)
    end, { "cwd", "toggle", "logs" })
  end,
})

vim.keymap.set({ "n", "x" }, "<leader>y", "<cmd>Yazi<cr>", { desc = "Yazi (Current File)" })

-- ============================================================================
-- Oil (Editable File Browser with Preview)
-- ============================================================================
local function setup_oil()
  loader.packadd("oil.nvim")

  require("oil").setup({
    default_file_explorer = false,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
    },
    float = {
      border = vim.o.winborder,
      preview_split = "right",
    },
    preview_win = {
      update_on_cursor_moved = true,
    },
  })
end

vim.api.nvim_create_user_command("Oil", function(ctx)
  if loader.load("oil", setup_oil) then
    vim.api.nvim_cmd({ cmd = "Oil", args = ctx.fargs, mods = ctx.smods, count = ctx.count }, {})
  end
end, { nargs = "*", complete = "dir", count = true, desc = "Oil file browser" })

vim.keymap.set("n", "<leader>o", function()
  if not loader.load("oil", setup_oil) then
    return
  end

  local oil = require("oil")
  oil.open_float(nil, nil, function()
    -- Empty directories have no entry to preview.
    if oil.get_cursor_entry() then
      oil.open_preview()
    end
  end)
end, { desc = "Oil (File Preview)", silent = true })
