local modes_opts = {
  colors = {
    bg = "#121358", -- Optional bg param, defaults to Normal hl group
  },
  line_opacity = 0.1,
  set_cursor = true,
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

vim.keymap.set("n", "<leader>uJ", function()
  require("treesj").toggle()
end, { desc = "Toggle Split" })

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

local width = math.max(1, vim.o.columns)
local height = math.max(1, math.floor(vim.o.lines * 0.4) - 2)
require("jishiben").setup({
  win = {
    border = "single",
    width = width,
    height = height,
    row = vim.o.lines - height - 2,
    col = 0,
  },
})

require("todo-comments").setup()

require("nvim-highlight-colors").setup({})
