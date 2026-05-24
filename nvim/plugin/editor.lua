local util = require("util")

local modes_opts = {
  colors = {
    bg = "#3A0519", -- Optional bg param, defaults to Normal hl group
  },

  -- Set opacity for cursorline and number background
  line_opacity = 0.15,

  -- Enable cursor highlights
  set_cursor = false,

  -- Enable cursorline initially, and disable cursorline for inactive windows
  -- or ignored filetypes
  set_cursorline = true,

  -- Enable line number highlights to match cursorline
  set_number = true,

  -- Enable sign column highlights to match cursorline
  set_signcolumn = true,

  -- Disable modes highlights for specified filetypes
  -- or enable with prefix "!" if otherwise disabled (please PR common patterns)
  -- Can also be a function fun():boolean that disables modes highlights when true
  ignore = { "NvimTree", "TelescopePrompt", "!minifiles" },
}

util.later(function()
  util.ensure_plugin("modes.nvim", function()
    require("modes").setup(modes_opts)
  end)
end, 20, "VimEnter", true)

local function setup_screenkey()
  util.ensure_plugin("screenkey.nvim", function()
    require("screenkey").setup({
      win_opts = {
        row = vim.o.lines - vim.o.cmdheight - 1,
        col = vim.o.columns - 1,
        relative = "editor",
        anchor = "SE",
        width = 20,
        height = 2,
        border = "single",
        title = "Screenkey",
        title_pos = "center",
        style = "minimal",
        focusable = false,
        noautocmd = true,
      },
      hl_groups = {
        ["screenkey.hl.key"] = { link = "Type" },
        ["screenkey.hl.map"] = { link = "Keyword" },
        ["screenkey.hl.sep"] = { link = "Normal" },
      },
    })
  end)
end

vim.api.nvim_create_user_command("Screenkey", function(args)
  pcall(vim.api.nvim_del_user_command, "Screenkey")
  setup_screenkey()
  local cmd = "Screenkey"
  if args.bang then
    cmd = cmd .. "!"
  end
  if args.args ~= "" then
    cmd = cmd .. " " .. args.args
  end
  vim.cmd(cmd)
end, { nargs = "*", bang = true, desc = "Toggle Screenkey" })

local function setup_treesj()
  util.ensure_plugin("treesj", function()
    require("treesj").setup({ use_default_keymaps = false })
  end, false)

  return require("treesj")
end

vim.keymap.set("n", "<leader>uJ", function()
  setup_treesj().toggle()
end, { desc = "Toggle Split" })

local function is_normal_buffer(bufnr)
  return vim.bo[bufnr].buftype == ""
end

vim.g.visual_whitespace = {
  enabled = true,
  highlight = { link = "LineNr", default = true },
  match_types = {
    space = true,
    tab = true,
    nbsp = true,
    lead = true,
    trail = false,
  },
  list_chars = {
    space = "·",
    tab = "↦",
    nbsp = "␣",
    lead = "‹",
    trail = "›",
  },
  fileformat_chars = {
    unix = "↲",
    mac = "←",
    dos = "↙",
  },
  ignore = { filetypes = {}, buftypes = {} },
}

local visual_whitespace_group = vim.api.nvim_create_augroup("VisualWhitespaceDeferred", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = visual_whitespace_group,
  callback = function(ev)
    if not is_normal_buffer(ev.buf) then
      return
    end
    util.packadd("visual-whitespace.nvim")
    pcall(vim.api.nvim_del_augroup_by_id, visual_whitespace_group)
  end,
})

local function setup_jishiben()
  local width = math.max(1, vim.o.columns)
  local height = math.max(1, math.floor(vim.o.lines * 0.4) - 2)

  util.ensure_plugin("jishiben.nvim", function()
    require("jishiben").setup({
      win = {
        border = "single",
        width = width,
        height = height,
        row = vim.o.lines - height - 2,
        col = 0,
      },
    })
  end, false)

  return require("jishiben")
end

vim.api.nvim_create_user_command("JishibenOpen", function()
  setup_jishiben().open()
end, {})

vim.api.nvim_create_user_command("JishibenClear", function()
  setup_jishiben().clear_all()
  vim.notify("Jishiben: all notes cleared")
end, {})

local function setup_editor_buffer_plugins()
  util.ensure_plugin("todo-comments.nvim", function()
    require("todo-comments").setup()
  end)
end

local function setup_highlight_colors()
  util.ensure_plugin("nvim-highlight-colors", function()
    require("nvim-highlight-colors").setup({})
  end)
end

local editor_buffer_group = vim.api.nvim_create_augroup("EditorBufferPluginsDeferred", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = editor_buffer_group,
  callback = function(ev)
    if not is_normal_buffer(ev.buf) then
      return
    end
    vim.defer_fn(setup_editor_buffer_plugins, 100)
    pcall(vim.api.nvim_del_augroup_by_id, editor_buffer_group)
  end,
})

local highlight_colors_group = vim.api.nvim_create_augroup("HighlightColorsDeferred", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = highlight_colors_group,
  callback = function(ev)
    if not is_normal_buffer(ev.buf) then
      return
    end

    vim.schedule(setup_highlight_colors)
    pcall(vim.api.nvim_del_augroup_by_id, highlight_colors_group)
  end,
})
