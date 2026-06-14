local ok, extui = pcall(require, "vim._extui")
if ok then
  extui.enable({})
end

require("options")
require("keymaps")
require("autocmds")

require("pack")
require("lsp")

-- vim.cmd.colorscheme("wolf")
