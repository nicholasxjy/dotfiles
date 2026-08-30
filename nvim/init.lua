if vim.loader then
  vim.loader.enable()
end

require("options")
require("keymaps")
require("autocmds")

require("pack")
require("lsp")
