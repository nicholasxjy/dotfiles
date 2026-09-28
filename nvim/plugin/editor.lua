local loader = require("loader")

-- Which-key provides hints for key combinations; defer until first buffer
local function setup_which_key()
  loader.packadd("which-key.nvim")
  require("which-key").setup({
    spec = {
      {
        mode = { "n", "x" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>q", group = "quit/session" },
        { "<leader>s", group = "search" },
        { "<leader>u", group = "ui" },
        { "<leader>x", group = "diagnostics/quickfix" },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
        { "z", group = "fold" },
        {
          "<leader>b",
          group = "buffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        {
          "<leader>w",
          group = "windows",
          proxy = "<c-w>",
          expand = function()
            return require("which-key.extras").expand.win()
          end,
        },
        { "gx", desc = "Open Externally" },
      },
    },
    preset = "classic",
    delay = 200,
    icons = {
      separator = " ",
    },
    win = {
      width = { min = 0.2, max = 0.3 },
      height = { min = 0.2, max = 0.6 },
      col = 0,
      border = vim.o.winborder,
      title = false,
      title_pos = "center",
    },
    plugins = {
      registers = false,
      marks = false,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
  })

  vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = false })
  end, { desc = "Keymaps hint" })
end

loader.defer_buffer("wk", setup_which_key, { schedule = true })

-- Editor features and text manipulation
loader.on_very_lazy("editor", function()
  loader.packadd(
    "plenary.nvim",
    "stay-centered.nvim",
    "smart-paste.nvim",
    "mini.trailspace",
    "mini.surround",
    "mini.ai",
    "treesj",
    "kd-translator.nvim",
    "todo-comments.nvim"
  )

  -- Stay centered
  require("stay-centered").setup({
    skip_filetypes = {},
    enabled = true,
    allow_scroll_move = true,
    disable_on_mouse = true,
  })

  -- Smart paste
  require("smart-paste").setup()

  -- Mini trailspace
  require("mini.trailspace").setup({
    only_in_normal_buffers = true,
  })

  vim.keymap.set("n", "<leader>ut", function()
    require("mini.trailspace").trim()
  end, { desc = "Trim Trailing Space" })

  -- Mini surround
  require("mini.surround").setup({
    mappings = {
      add = "gsa",
      delete = "gsd",
      replace = "gsr",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
    },
  })

  -- Mini text-objects
  require("mini.ai").setup()

  -- Treesj (split/join syntax blocks)
  require("treesj").setup({
    use_default_keymaps = false,
    check_syntax_error = true,
    max_join_length = 120,
    cursor_behavior = "hold",
  })

  vim.keymap.set("n", "<leader>cj", function()
    require("treesj").toggle()
  end, { desc = "Toggle Split/Join" })

  vim.keymap.set("n", "<leader>uJ", function()
    require("treesj").toggle()
  end, { desc = "Toggle Split/Join" })

  -- Translator
  require("kd-translator").setup()

  vim.keymap.set("x", "gt", "<Plug>(kd-translator-visual)", { desc = "Translate Visual" })
  vim.keymap.set("x", "<leader>ct", function()
    require("kd-translator").operator("visual")
  end, { desc = "Translate Selection" })
  vim.keymap.set("n", "<leader>cw", function()
    require("kd-translator").translate_preview(vim.fn.expand("<cword>"))
  end, { desc = "Translate Word" })

  -- Todo comments
  require("todo-comments").setup()
end)
