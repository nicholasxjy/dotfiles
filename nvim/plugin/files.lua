local loader = require("loader")

-- ============================================================================
-- Neo-tree (Sidebar File Explorer)
-- ============================================================================
local function setup_neo_tree()
  loader.packadd("plenary.nvim", "nui.nvim", "neo-tree.nvim")
  local mini_icons = require("mini.icons")

  require("neo-tree").setup({
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
