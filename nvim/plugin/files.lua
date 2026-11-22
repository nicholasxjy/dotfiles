local loader = require("loader")

-- ============================================================================
-- Neo-tree (Sidebar File Explorer)
-- ============================================================================
local function setup_neo_tree()
  loader.packadd("plenary.nvim", "nui.nvim", "neo-tree.nvim")
  local mini_icons = require("mini.icons")

  require("neo-tree").setup({
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
    default_component_configs = {
      icon = {
        ---@param icon neotree.Render.Node
        ---@param node neotree.FileNode
        provider = function(icon, node)
          if node.type == "file" or node.type == "directory" then
            icon.text, icon.highlight = mini_icons.get(node.type, node.path or node.name)
          elseif node.type == "terminal" then
            icon.text, icon.highlight = mini_icons.get("filetype", "terminal")
          end
        end,
      },
    },
    window = {
      position = "left",
      width = 32,
    },
    filesystem = {
      -- Leave directory buffers to Oil.
      hijack_netrw_behavior = "disabled",
      follow_current_file = { enabled = true },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  })
end

vim.api.nvim_create_user_command("Neotree", function(ctx)
  if loader.load("neo-tree", setup_neo_tree) then
    vim.api.nvim_cmd({ cmd = "Neotree", args = ctx.fargs, mods = ctx.smods }, {})
  end
end, {
  nargs = "*",
  complete = function(lead, line)
    if not loader.load("neo-tree", setup_neo_tree) then
      return {}
    end
    return vim.split(require("neo-tree.command").complete_args(lead, line), "\n", { trimempty = true })
  end,
  desc = "Neo-tree file explorer",
})

vim.keymap.set("n", "<leader>e", function()
  if loader.load("neo-tree", setup_neo_tree) then
    require("neo-tree.command").execute({ source = "filesystem", position = "left", toggle = true })
  end
end, { desc = "Toggle Neo-tree", silent = true })

-- ============================================================================
-- Mini Files (Column File Browser)
-- ============================================================================
local function layout_mini_files_windows()
  local state = require("mini.files").get_explorer_state()
  if not state or #state.windows == 0 then
    return
  end

  local entries = {}
  local anchor_idx = 1
  local total_width = 0

  for _, item in ipairs(state.windows) do
    if vim.api.nvim_win_is_valid(item.win_id) then
      local config = vim.api.nvim_win_get_config(item.win_id)
      if config.relative == "editor" then
        local border = (config.border == nil or config.border == "none") and 0 or 2
        local outer_width = config.width + border
        entries[#entries + 1] = {
          win_id = item.win_id,
          buf_id = vim.api.nvim_win_get_buf(item.win_id),
          config = config,
          border = border,
          outer_width = outer_width,
        }
        if item.path == state.anchor then
          anchor_idx = #entries
        end
        total_width = total_width + outer_width
      end
    end
  end

  if #entries == 0 then
    return
  end

  local has_tabline = vim.o.showtabline == 2 or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)
  local has_statusline = vim.o.laststatus > 0
  local top = has_tabline and 1 or 0
  local bottom = vim.o.cmdheight + (has_statusline and 1 or 0)
  local avail_height = vim.o.lines - top - bottom
  local bottom_limit = top + avail_height

  local anchor = entries[anchor_idx]
  local anchor_max_height = math.max(1, avail_height - anchor.border)
  local anchor_height = math.min(math.max(1, vim.api.nvim_buf_line_count(anchor.buf_id)), anchor_max_height)
  local anchor_row = top + math.max(0, math.floor((avail_height - (anchor_height + anchor.border)) / 2))

  local left_width = 0
  for i = 1, anchor_idx - 1 do
    left_width = left_width + entries[i].outer_width
  end

  local ideal_anchor_col = math.floor((vim.o.columns - anchor.outer_width) / 2)
  local col = math.max(0, math.min(ideal_anchor_col - left_width, vim.o.columns - total_width))

  for _, entry in ipairs(entries) do
    local max_height = math.max(1, bottom_limit - anchor_row - entry.border)
    local target_height = math.min(math.max(1, vim.api.nvim_buf_line_count(entry.buf_id)), max_height)
    local config = entry.config

    if config.row ~= anchor_row or config.col ~= col or config.height ~= target_height then
      config.row = anchor_row
      config.col = col
      config.height = target_height
      vim.api.nvim_win_set_config(entry.win_id, config)
    end

    col = col + entry.outer_width
  end
end

local function setup_mini_files()
  loader.packadd("mini.files")

  require("mini.files").setup({
    options = {
      -- Leave directory buffers to Oil.
      use_as_default_explorer = false,
    },
    windows = {
      preview = true,
    },
  })

  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("sjvim_mini_files", { clear = true }),
    pattern = "MiniFilesWindowUpdate",
    callback = layout_mini_files_windows,
    desc = "Keep mini.files anchor window centered while expanding columns outward",
  })
end

vim.keymap.set("n", "<leader>a", function()
  if not loader.load("mini-files", setup_mini_files) then
    return
  end

  local path = vim.api.nvim_buf_get_name(0)
  require("mini.files").open(vim.uv.fs_stat(path) and path or vim.fn.getcwd(), false)
end, { desc = "Open Mini Files", silent = true })

-- ============================================================================
-- Oil (Editable File Browser with Preview)
-- ============================================================================
local function setup_oil()
  loader.packadd("oil.nvim")

  require("oil").setup({
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
    },
    confirmation = {
      border = "single",
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
  oil.open(nil, nil, function()
    -- Empty directories have no entry to preview.
    if oil.get_cursor_entry() then
      oil.open_preview()
    end
  end)
end, { desc = "Oil (File Preview)", silent = true })
