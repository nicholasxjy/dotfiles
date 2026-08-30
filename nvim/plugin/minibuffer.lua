vim.g.minibuffer = {
  dynamic_window_resize = true, -- Shrink other windows when the minibuffer is expanded
  cmd = {
    -- NOTE: minibuffer cmd is not compatible with command line plugins that force `wildtrigger()` each `wildchar` such as mini.cmdline
    enabled = false, -- Enable command line wildmenu replacement through the minibuffer
    autotrigger = false, -- Display completion suggestions as you type
    dynamic_height = true, -- Whether the completion window should shrink as items disappear.
    max_height = 15, -- Maximum height when using the command line
  },
  select = {
    dynamic_height = false,
    max_height = math.floor(vim.o.lines * 0.3),
    keymaps = {
      -- Each action accepts one key or a list of keys. Use {} to disable an action's mappings.
      cancel = "<Esc>",
      accept = { "<C-y>", "<CR>" },
      previous = { "<C-p>", "<C-k>", "<Up>", "<S-Tab>" },
      next = { "<C-n>", "<C-j>", "<Down>", "<Tab>" },
      delete_word = "<C-w>",
      toggle = "<C-x>", -- Only active for multi-select sessions
      toggle_all = "<C-a>", -- Only active for multi-select sessions
    },
  },
}

local loader = require("loader")

loader.on_very_lazy("minibuffer", function()
  loader.packadd("minibuffer.nvim")
  vim.lsp.buf.hover = require("minibuffer.builtin.hover")
  local hover = vim.lsp.buf.hover
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.lsp.buf.hover = function()
    return hover({ border = "none" })
  end
end)
