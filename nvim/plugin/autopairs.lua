local util = require("util")

util.later(function()
  require("nvim-autopairs").setup({})
end, 20, "InsertEnter", true)
