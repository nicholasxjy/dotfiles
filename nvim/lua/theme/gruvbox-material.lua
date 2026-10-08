local loader = require("loader")

local M = {}

function M.setup()
  vim.o.background = "light"
  vim.g.gruvbox_material_foreground = "material"
  vim.g.gruvbox_material_background = "soft"
  vim.g.gruvbox_material_better_performance = 1
  vim.g.gruvbox_material_enable_bold = 1
  vim.g.gruvbox_material_enable_italic = 1
  vim.g.gruvbox_material_dim_inactive_windows = 1
  vim.g.gruvbox_material_transparent_background = 0
  vim.g.gruvbox_material_ui_contrast = 1
  vim.g.gruvbox_material_diagnostic_line_highlight = 1

  loader.packadd("gruvbox-material")
  vim.cmd.colorscheme("gruvbox-material")
end

return M
