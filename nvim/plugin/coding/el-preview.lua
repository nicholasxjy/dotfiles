local loader = require("loader")

local setup = function()
  loader.packadd("el-preview.nvim")

  require("el-preview").setup()

  vim.keymap.set("n", "K", require("el-preview").hover, {
    desc = "LSP hover in UI2 message window",
  })
end

loader.defer_buffer("el-preview", setup, { schedule = true })
