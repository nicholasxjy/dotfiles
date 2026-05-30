local util = require("util")

util.build_fn_on_change("markdown-preview.nvim", { "install", "update" }, function()
  vim.fn["mkdp#util#install"]()
end)

vim.g.mkdp_filetypes = { "markdown" }
