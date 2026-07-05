vim.pack.add({
  -- "https://github.com/mikavilpas/yazi.nvim",
  "https://github.com/nicholasxjy/yazi.nvim",
}, { load = false })

local yazi_loaded = false

local function load_yazi()
  if yazi_loaded then
    return
  end

  vim.cmd.packadd("yazi.nvim")
  require("yazi").setup({})

  yazi_loaded = true
end

vim.keymap.set("n", "<leader>-", function()
  require("yazi").yazi({
    open_for_directories = true,
  })
end, { desc = "Yazi" })
-- 👇 if you use `open_for_directories=true`, this is recommended.
--
-- mark netrw as loaded so it's not loaded at all.
-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
vim.g.loaded_netrwPlugin = 1
vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    load_yazi()
  end,
})
