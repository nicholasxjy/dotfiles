local util = require("util")

util.ensure_plugin("arborist.nvim", function()
  require("arborist").setup({
    install_popular = false,
    update_cadence = "daily",
    overrides = {},
  })
end, false)
