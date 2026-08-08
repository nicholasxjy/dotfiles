local loader = require("loader")

local setup_automatic = function()
  loader.packadd(
    "todo-comments.nvim",
    "smart-paste.nvim",
    "modes.nvim",
    "stay-centered.nvim",
    "nvim-highlight-colors",
    "ts-comments.nvim"
  )

  -- Tree-sitter aware `commentstring`; the plugin is inert without this call.
  require("ts-comments").setup()

  local function hl_color(group, attr, fallback)
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    if not ok then
      return fallback
    end

    local color = hl[attr]
    if color == nil then
      return fallback
    end

    return string.format("#%06x", color)
  end

  require("smart-paste").setup()

  require("modes").setup({
    colors = {
      bg = "#0D1164", --hl_color("Normal", "bg", "#0D1164"),
      copy = hl_color("WarningMsg", "fg", "#f5c359"),
      delete = hl_color("ErrorMsg", "fg", "#c75c6a"),
      change = hl_color("ErrorMsg", "fg", "#c75c6a"),
      format = hl_color("Operator", "fg", "#c79585"),
      insert = hl_color("DiagnosticInfo", "fg", "#78ccc5"),
      replace = hl_color("Substitute", "bg", "#245361"),
      select = hl_color("Search", "bg", "#9745be"),
      visual = hl_color("Visual", "bg", "#9745be"),
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
  })

  require("stay-centered").setup({
    -- The filetype is determined by the vim filetype, not the file extension. In order to get the filetype, open a file and run the command:
    -- :lua print(vim.bo.filetype)
    skip_filetypes = {},
    -- Set to false to disable by default
    enabled = true,
    -- allows scrolling to move the cursor without centering, default recommended
    allow_scroll_move = true,
    -- temporarily disables plugin on left-mouse down, allows natural mouse selection
    -- try disabling if plugin causes lag, function uses vim.on_key
    disable_on_mouse = true,
  })

  require("todo-comments").setup()

  require("nvim-highlight-colors").setup({})
end

local setup_tools = function()
  loader.packadd("screenkey.nvim", "jishiben.nvim", "translator.nvim", "nerdy.nvim", "treesj")

  require("nerdy").setup({
    max_recents = 30, -- Configure recent icons limit
    copy_to_clipboard = false, -- Copy glyph to clipboard instead of inserting
    copy_register = "+", -- Register to use for copying (if `copy_to_clipboard` is true)
  })

  require("screenkey").setup({
    win_opts = {
      row = vim.o.lines - vim.o.cmdheight - 1,
      col = vim.o.columns - 1,
      relative = "editor",
      anchor = "SE",
      width = 20,
      height = 2,
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

  require("treesj").setup({ use_default_keymaps = false })

  -- local width = math.max(1, vim.o.columns)
  -- local height = math.max(1, math.floor(vim.o.lines * 0.4) - 2)
  require("jishiben").setup({
    win = {
      -- width = width,
      -- height = height,
      -- row = vim.o.lines - height - 2,
      -- col = 0,
    },
  })

  require("translator").setup({
    default_target_lang = "zh",
    default_source_lang = nil,
    window = {
      width = 60,
    },
  })

  vim.keymap.set("n", "<leader>uJ", function()
    require("treesj").toggle()
  end, { desc = "Toggle Split" })

  vim.keymap.set("v", "<leader>bv", function()
    require("translator").transVisualSel()
  end, { desc = "Translate Selection" })

  vim.keymap.set("n", "<leader>bc", function()
    require("translator").transCurWord()
  end, { desc = "Translate Word" })
end

loader.on_very_lazy("editor-automatic", setup_automatic)
loader.on_very_lazy("editor-tools", setup_tools)
