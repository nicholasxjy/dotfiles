if vim.loader then
  vim.loader.enable()
end

pcall(function()
  require("vim._core.ui2").enable({})
end)

require("options")
require("keymaps")
require("autocmds")

require("pack")
require("lsp")
