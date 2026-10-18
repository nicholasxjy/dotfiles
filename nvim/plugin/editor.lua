local loader = require("loader")

-- Key combination hints
loader.on_very_lazy("mini-clue", function()
  loader.packadd("mini.clue")
  local clue = require("mini.clue")
  clue.setup({
    triggers = {
      { mode = "n", keys = "<leader>" },
      { mode = "x", keys = "<leader>" },
      { mode = "n", keys = "g" },
      { mode = "x", keys = "g" },
      { mode = "n", keys = "z" },
      { mode = "x", keys = "z" },
      { mode = "n", keys = "[" },
      { mode = "x", keys = "[" },
      { mode = "n", keys = "]" },
      { mode = "x", keys = "]" },
      { mode = "n", keys = "<C-w>" },
      { mode = "i", keys = "<C-x>" },
    },
    clues = {
      clue.gen_clues.builtin_completion(),
      clue.gen_clues.g(),
      clue.gen_clues.square_brackets(),
      clue.gen_clues.windows(),
      clue.gen_clues.z(),
      { mode = { "n", "x" }, keys = "<leader>b", desc = "+buffer" },
      { mode = { "n", "x" }, keys = "<leader>c", desc = "+code" },
      { mode = { "n", "x" }, keys = "<leader>f", desc = "+file/find" },
      { mode = { "n", "x" }, keys = "<leader>g", desc = "+git" },
      { mode = { "n", "x" }, keys = "<leader>s", desc = "+search" },
      { mode = { "n", "x" }, keys = "<leader>u", desc = "+ui" },
      { mode = { "n", "x" }, keys = "<leader>x", desc = "+diagnostics/quickfix" },
      { mode = { "n", "x" }, keys = "gs", desc = "+surround" },
    },
    window = {
      delay = 200,
      config = {
        width = "auto",
        anchor = "SW",
        row = "auto",
        col = "auto",
        border = vim.o.winborder,
      },
    },
  })
end)

vim.keymap.set("n", "<leader>?", function()
  if vim.fn.executable("fzf") ~= 1 then
    vim.notify("Keymap picker requires fzf", vim.log.levels.WARN)
    return
  end

  loader.packadd("fzf-lua")
  require("fzf-lua").keymaps()
end, { desc = "Show Keymaps" })

-- Editor features and text manipulation
loader.on_very_lazy("editor", function()
  loader.packadd("smart-paste.nvim", "mini.trailspace", "mini.surround", "mini.ai")

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
end)

local function setup_treesj()
  loader.packadd("treesj")
  require("treesj").setup({
    use_default_keymaps = false,
    check_syntax_error = true,
    max_join_length = 120,
    cursor_behavior = "hold",
  })
end

vim.keymap.set("n", "<leader>cj", function()
  if loader.load("treesj", setup_treesj) then
    require("treesj").toggle()
  end
end, { desc = "Toggle Split/Join" })
