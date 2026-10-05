local loader = require("loader")

-- Which-key provides hints for key combinations
local function setup_which_key()
  loader.packadd("which-key.nvim")
  require("which-key").setup({
    spec = {
      {
        mode = { "n", "x" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
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

loader.on_very_lazy("which-key", setup_which_key)

-- Editor features and text manipulation
loader.on_very_lazy("editor", function()
  loader.packadd(
    "plenary.nvim",
    -- "stay-centered.nvim",
    "smart-paste.nvim",
    "mini.trailspace",
    "mini.surround",
    "mini.ai",
    "treesj",
    "todo-comments.nvim"
  )

  -- Stay centered
  -- require("stay-centered").setup({
  --   skip_filetypes = {},
  --   enabled = true,
  --   allow_scroll_move = true,
  --   disable_on_mouse = true,
  -- })

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

  -- Todo comments
  require("todo-comments").setup()
end)

-- Translator: set up on first use, and only when the `kd` binary exists (the
-- plugin throws on every call without it).
local function translator()
  if vim.fn.executable("kd") == 0 then
    vim.notify("kd-translator: `kd` executable not found", vim.log.levels.WARN)
    return nil
  end
  loader.load("kd-translator", function()
    loader.packadd("kd-translator.nvim")
    require("kd-translator").setup()
  end)
  return require("kd-translator")
end

vim.keymap.set("x", "gt", function()
  local kd = translator()
  if kd then
    kd.operator("visual")
  end
end, { desc = "Translate Selection" })
vim.keymap.set("n", "<leader>cw", function()
  local kd = translator()
  if kd then
    kd.translate_preview(vim.fn.expand("<cword>"))
  end
end, { desc = "Translate Word" })
