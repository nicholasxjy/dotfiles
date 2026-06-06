vim.pack.add({
  "https://github.com/rrethy/vim-illuminate",
}, { load = false })

local loaded = false

local function load_illuminate()
  if loaded then
    return require("illuminate")
  end

  vim.cmd.packadd("vim-illuminate")

  local illum = require("illuminate")

  illum.configure({
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    delay = 250,
  })

  vim.keymap.set("n", "]]", function()
    illum.goto_next_reference()
  end, { desc = "Next reference" })

  vim.keymap.set("n", "[[", function()
    illum.goto_prev_reference()
  end, { desc = "Prev reference" })

  loaded = true

  return illum
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  once = true,
  callback = function()
    load_illuminate()
  end,
})
