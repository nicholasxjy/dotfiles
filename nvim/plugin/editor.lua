vim.pack.add({
  "http://github.com/2KAbhishek/nerdy.nvim",
  "https://github.com/arnamak/stay-centered.nvim",
  "https://github.com/NStefan002/screenkey.nvim",
  "https://github.com/mvllow/modes.nvim",
  "https://github.com/brenoprata10/nvim-highlight-colors",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/mcauley-penney/visual-whitespace.nvim",
  "https://github.com/folke/ts-comments.nvim",

  "https://github.com/nicholasxjy/jishiben.nvim",
  "https://github.com/nicholasxjy/translator.nvim",

  "https://github.com/Wansmer/treesj",
}, { load = false })

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

local loaded = false

local function load_editor()
  if loaded then
    return
  end

  vim.cmd.packadd("nerdy.nvim")
  vim.cmd.packadd("stay-centered.nvim")
  vim.cmd.packadd("screenkey.nvim")
  vim.cmd.packadd("modes.nvim")
  vim.cmd.packadd("nvim-highlight-colors")
  vim.cmd.packadd("todo-comments.nvim")
  vim.cmd.packadd("visual-whitespace.nvim")
  vim.cmd.packadd("ts-comments.nvim")
  vim.cmd.packadd("jishiben.nvim")
  vim.cmd.packadd("translator.nvim")
  vim.cmd.packadd("treesj")

  local nerdy = require("nerdy")

  nerdy.setup({
    max_recents = 30, -- Configure recent icons limit
    copy_to_clipboard = false, -- Copy glyph to clipboard instead of inserting
    copy_register = "+", -- Register to use for copying (if `copy_to_clipboard` is true)
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

  local modes_opts = {
    colors = {
      bg = "#2A221E",
      -- bg = "#121358", -- Optional bg param, defaults to Normal hl group
    },
    line_opacity = 0.15,
    set_cursor = false,
    set_cursorline = true,
    set_number = true,
    set_signcolumn = true,
    -- Disable modes highlights for specified filetypes
    -- or enable with prefix "!" if otherwise disabled (please PR common patterns)
    -- Can also be a function fun():boolean that disables modes highlights when true
    ignore = { "NvimTree", "TelescopePrompt", "!minifiles" },
  }

  require("modes").setup(modes_opts)

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

  require("treesj").setup({ use_default_keymaps = false })

  -- local width = math.max(1, vim.o.columns)
  -- local height = math.max(1, math.floor(vim.o.lines * 0.4) - 2)
  require("jishiben").setup({
    win = {
      border = "single",
      -- width = width,
      -- height = height,
      -- row = vim.o.lines - height - 2,
      -- col = 0,
    },
  })

  require("todo-comments").setup()

  require("nvim-highlight-colors").setup({})

  require("translator").setup({
    default_target_lang = "zh",
    default_source_lang = nil,
    window = {
      width = 60,
    },
  })

  loaded = true
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  once = true,
  callback = function()
    load_editor()
  end,
})

vim.keymap.set("n", "<leader>uJ", function()
  load_editor()
  require("treesj").toggle()
end, { desc = "Toggle Split" })

vim.keymap.set("v", "<leader>bv", function()
  load_editor()
  require("translator").transVisualSel()
end, { desc = "Translate Selection" })

vim.keymap.set("n", "<leader>bc", function()
  load_editor()
  require("translator").transCurWord()
end, { desc = "Translate Word" })
