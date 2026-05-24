local util = require("util")

local function setup_illuminate()
  util.ensure_plugin("vim-illuminate", function()
    require("illuminate").configure({
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
      delay = 250,
    })
  end)

  return require("illuminate")
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("IlluminateDeferredSetup", { clear = true }),
  once = true,
  callback = setup_illuminate,
})

vim.keymap.set("n", "]]", function()
  setup_illuminate().goto_next_reference()
end, { desc = "Next reference" })

vim.keymap.set("n", "[[", function()
  setup_illuminate().goto_prev_reference()
end, { desc = "Prev reference" })
