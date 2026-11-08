local loader = require("loader")

local M = {}

local function apply_highlights()
  local p = require("mini.hues").get_palette()
  vim.api.nvim_set_hl(0, "Comment", { fg = p.fg_mid })
  vim.api.nvim_set_hl(0, "Visual", { bg = p.accent_bg })
  vim.api.nvim_set_hl(0, "PmenuSel", { fg = p.fg, bg = p.accent_bg, reverse = false })
end

function M.setup()
  loader.packadd("mini.hues")

  -- Apply overrides after the theme sets its highlights.
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("sjvim_mini_hues_highlights", { clear = true }),
    pattern = { "randomhue", "minispring", "minisummer", "miniautumn", "miniwinter" },
    callback = apply_highlights,
  })

  vim.cmd.colorscheme("minischeme")
end

return M
