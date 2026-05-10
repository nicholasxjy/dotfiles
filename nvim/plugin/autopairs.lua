local util = require("util")

util.later(function()
  util.ensure_plugin("nvim-autopairs", function()
    require("nvim-autopairs").setup({})
  end)
end, 20, "InsertEnter", true)
