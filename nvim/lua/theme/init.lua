local M = {}

--- Load the configured theme
---@param name? string Theme name, e.g. "mini-hues", "nightfox"
function M.load(name)
  name = name or "mini-hues"

  local theme_name = name:match("^([%w_-]+)") or name
  local ok, mod = pcall(require, "theme." .. theme_name)
  if ok and mod.setup then
    mod.setup(name)
  else
    local cs_ok = pcall(vim.cmd.colorscheme, name)
    if not cs_ok then
      require("theme.mini-hues").setup()
    end
  end
end

return M
