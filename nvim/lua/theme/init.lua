local M = {}

--- Load the configured theme
---@param name? string Theme name, e.g. "catppuccin-mocha", "catppuccin-macchiato", "catppuccin-frappe", "tokyonight"
function M.load(name)
  name = name or "tokyonight"

  if name:match("^tokyonight") then
    local style = name:match("^tokyonight%-(.+)$") or "moon"
    require("theme.tokyonight").setup(style)
  elseif name:match("^catppuccin") then
    local ok, catppuccin = pcall(require, "theme.catppuccin")
    local setup_ok = false
    if ok and catppuccin.setup then
      local flavour = name:match("^catppuccin%-(.+)$") or "mocha"
      setup_ok = pcall(catppuccin.setup, flavour)
    end
    if not setup_ok then
      vim.notify("Catppuccin theme not available, falling back to tokyonight", vim.log.levels.WARN)
      require("theme.tokyonight").setup("moon")
    end
  else
    local theme_name = name:match("^([%w_-]+)") or name
    local ok, mod = pcall(require, "theme." .. theme_name)
    if ok and mod.setup then
      mod.setup(name)
    else
      local cs_ok = pcall(vim.cmd.colorscheme, name)
      if not cs_ok then
        require("theme.tokyonight").setup("moon")
      end
    end
  end
end

return M
