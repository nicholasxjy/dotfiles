local loader = require("loader")

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
