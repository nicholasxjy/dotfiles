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

  local visual = hl_color("@keyword", "fg", "#9b88ce")

  require("modes").setup({
    colors = {
      bg = "#2E2910", --hl_color("Normal", "bg", "#2d293a"),
      copy = hl_color("WarningMsg", "fg", "#f4b258"),
      delete = hl_color("ErrorMsg", "fg", "#f08a75"),
      change = hl_color("DiagnosticInfo", "fg", "#91cee7"),
      format = hl_color("Operator", "fg", "#f8cb94"),
      insert = hl_color("DiagnosticHint", "fg", "#79c5b7"),
      replace = hl_color("Substitute", "bg", "#f08a75"),
      select = visual,
      visual = visual,
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

  require("treesj").setup({
    use_default_keymaps = false,
    check_syntax_error = true,
    ---If line after join will be longer than max value,
    ---@type number If line after join will be longer than max value, node will not be formatted
    max_join_length = 120,
    ---Cursor behavior:
    ---hold - cursor follows the node/place on which it was called
    ---start - cursor jumps to the first symbol of the node being formatted
    ---end - cursor jumps to the last symbol of the node being formatted
    ---@type 'hold'|'start'|'end'
    cursor_behavior = "hold",
  })

  require("jishiben").setup()

  require("translator").setup({
    default_target_lang = "zh",
    window = {
      width = 60,
    },
  })

  vim.keymap.set("n", "<leader>uJ", function()
    loader.packadd("nvim-treesitter")
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
