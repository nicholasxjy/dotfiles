local loader = require("loader")

vim.o.cmdheight = 0
vim.g.tiny_cmdline = {
  width = { value = "70%" },
}

local setup = function()
  loader.packadd("tiny-cmdline.nvim")

  require("tiny-cmdline").setup({
    on_reposition = require("tiny-cmdline").adapters.blink,
  })
end

loader.on_very_lazy("tiny-cmdline", setup)
