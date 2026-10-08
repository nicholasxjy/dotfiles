local loader = require("loader")

local M = {}

function M.setup()
  vim.o.background = "light"
  vim.g.everforest_background = "medium"
  vim.g.everforest_better_performance = 1
  vim.g.everforest_enable_italic = 1
  vim.g.everforest_transparent_background = 2

  loader.packadd("everforest")
  vim.cmd.colorscheme("everforest")
end

return M
