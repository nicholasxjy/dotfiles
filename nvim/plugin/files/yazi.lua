local loader = require("loader")

local setup = function()
  -- Disable netrw before activating yazi.
  vim.g.loaded_netrwPlugin = 1
  loader.packadd("yazi.nvim")

  require("yazi").setup({})

  vim.keymap.set("n", "<leader>y", function()
    require("yazi").yazi({
      open_for_directories = true,
    })
  end, { desc = "Yazi" })
end

loader.on_very_lazy("yazi", setup)
