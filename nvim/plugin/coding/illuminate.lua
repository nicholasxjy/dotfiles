local loader = require("loader")

local setup = function()
  loader.packadd("vim-illuminate")
  local illum = require("illuminate")

  illum.configure({
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    delay = 250,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { "lsp" },
      under_cursor = false,
    },
  })

  vim.keymap.set("n", "]]", function()
    illum.goto_next_reference()
  end, { desc = "Next reference" })

  vim.keymap.set("n", "[[", function()
    illum.goto_prev_reference()
  end, { desc = "Prev reference" })
end

loader.defer_buffer("illuminate", setup, { schedule = true })
