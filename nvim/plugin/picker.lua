local loader = require("loader")

vim.g.fff = {
  lazy_sync = false,
  debug = { enabled = true, show_scores = true },
}

loader.on_very_lazy("picker", function()
  loader.packadd("fff", "xue-picker.nvim")

  require("xue-picker").setup({
    defaults = {
      keymaps = {
        next = { "<C-n>", "<C-j>", "<Down>" },
        previous = { "<C-p>", "<C-k>", "<Up>" },
      },
      preview = { enabled = false, max_bytes = 1024 * 1024, max_lines = 2000 },
      layout = { height = 0.4, max_height = 18, wide = 100 },
      icons = "auto", -- false, function, or installed mini.icons / nvim-web-devicons
      path_format = "filename_first", -- "relative" or function(item, cwd)
      highlights = {
        XuePickerNormal = { link = "Normal" },
      },
    },
    pickers = {
      smart = { filter = { cwd = true }, matcher = { frecency = true } },
      live_grep = {
        backend = "fff",
        fallback = false,
      },
    },
    ui = { select = true, input = true },
  })

  local builtin = require("xue-picker.builtin")

  vim.keymap.set("n", "<leader><CR>", require("xue-picker").resume, { desc = "Resume" })

  vim.keymap.set("n", "<leader><space>", builtin.smart, { desc = "Files" })

  vim.keymap.set("n", "<leader>h", builtin.buffers, { desc = "Buffers" })

  vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Grep" })
  vim.keymap.set("n", "<leader>sw", builtin.grep_word, { desc = "Grep word" })

  vim.keymap.set("n", "<leader>xx", function()
    builtin.diagnostics({
      scope = "cwd",
      sort = true, -- ERROR, WARN, INFO, HINT; "reverse" / 2 reverses; false keeps provider order
      severity = { min = vim.diagnostic.severity.ERROR },
    })
  end, { desc = "Diagnostics" })

  vim.keymap.set("n", "<leader>xe", function()
    builtin.diagnostics({
      scope = "cwd",
      sort = true, -- ERROR, WARN, INFO, HINT; "reverse" / 2 reverses; false keeps provider order
      severity = { min = vim.diagnostic.severity.WARN },
    })
  end, { desc = "Diagnostics(error&warn)" })
end)
