local loader = require("loader")

local setup_automatic = function()
  loader.packadd(
    "todo-comments.nvim",
    "smart-paste.nvim",
    "modicator.nvim",
    "stay-centered.nvim",
    "nvim-highlight-colors",
    "ts-comments.nvim",
    "rainbow-delimiters.nvim"
  )

  vim.g.rainbow_delimiters = {
    strategy = {
      [""] = "rainbow-delimiters.strategy.global",
      vim = "rainbow-delimiters.strategy.local",
    },
    query = {
      [""] = "rainbow-delimiters",
      lua = "rainbow-blocks",
    },
    priority = {
      [""] = 110,
      lua = 210,
    },
    highlight = {
      "RainbowDelimiterRed",
      "RainbowDelimiterYellow",
      "RainbowDelimiterBlue",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    },
  }

  require("ts-comments").setup()

  require("modicator").setup()

  require("smart-paste").setup()

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
  loader.packadd("screenkey.nvim", "kd-translator.nvim", "treesj")

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

  require("kd-translator").setup()

  -- vim.keymap.set("n", "gt", "<Plug>(kd-translator-operator)", { desc = "Kd Translate Operator" })
  vim.keymap.set("x", "gt", "<Plug>(kd-translator-visual)", { desc = "Kd Translate Visual" })

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
