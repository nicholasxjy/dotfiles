local loader = require("loader")

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
