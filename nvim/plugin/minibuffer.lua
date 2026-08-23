vim.pack.add({
  "https://github.com/nicholasxjy/minibuffer.nvim",
})

local minibuffer = require("minibuffer")

vim.ui.select = require("minibuffer.builtin.ui_select")
vim.ui.input = require("minibuffer.builtin.ui_input")
-- Default configuration
vim.g.minibuffer = {
  cmd = {
    enabled = true, -- Enable command line wildmenu replacement through the minibuffer
    dynamic_height = true, -- Automatically shrink and grow the command window as suggestions change
    max_height = math.floor(vim.o.lines * 0.3), -- Maximum height when using the command line
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

local fff_mb = require("minibuffer.integrations.fff")
local opts = {
  show_git_status = true,
  filename_first = true,
  highlights = {
    directory_path = { link = "SnacksPickerDir" },
    matched = { link = "SnacksPickerMatch" },
    grep_match = { link = "SnacksPickerMatch" },
  },
  keymaps = {
    next = { "<C-n>", "<C-j>" },
    previous = { "<C-p>", "<C-k>" },
  },
}

vim.keymap.set("n", "<leader><space>", function()
  fff_mb.file_search(nil, opts)
end, { desc = "FFFind" })

vim.keymap.set("n", "<leader>h", function()
  require("minibuffer.examples.buffers")()
end, { desc = "Find buffers" })

vim.keymap.set("n", "<leader>sg", function()
  fff_mb.content_search(nil, opts)
end, { desc = "FFFGrep" })

vim.keymap.set("n", "<leader>sw", function()
  fff_mb.content_search(vim.fn.expand("<cword>"), opts)
end, { desc = "FFFGrep word" })

vim.keymap.set("n", "<leader><CR>", function()
  minibuffer.resume(true)
end)

vim.keymap.set("n", "<leader>xx", function()
  require("minibuffer.examples.diagnostics")({ scope = "buffer" })
end, { desc = "Find diagnostics" })

vim.keymap.set("n", "<leader>xX", function()
  require("minibuffer.examples.diagnostics")({ scope = "workspace" })
end, { desc = "Find diagnostics (workspace)" })

vim.keymap.set("n", "<leader>xw", function()
  require("minibuffer.examples.diagnostics")({
    scope = "workspace",
    severity = { max = vim.diagnostic.severity.WARN },
    severity_sort = true,
  })
end, { desc = "Workspace Diagnostics(Warns)" })

vim.keymap.set("n", "<leader>xe", function()
  require("minibuffer.examples.diagnostics")({
    scope = "workspace",
    severity = { max = vim.diagnostic.severity.ERROR },
    severity_sort = true,
  })
end, { desc = "Workspace Diagnostics(Errors)" })
