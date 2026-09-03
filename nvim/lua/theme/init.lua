local M = {
  current = nil,
}

local themes = {
  tokyonight = {
    setup = function()
      require("theme.tokyonight").setup()
    end,
    colorscheme = "tokyonight",
  },
  catppuccin = {
    setup = function()
      require("theme.catppuccin").setup()
    end,
    colorscheme = "catppuccin",
  },
  hues = {
    setup = function()
      require("theme.hues").setup()
    end,
    colorscheme = "hues",
  },
}

local function init_autocmds()
  vim.api.nvim_create_autocmd("ColorSchemePre", {
    group = vim.api.nvim_create_augroup("sjvim_theme_setup", { clear = true }),
    callback = function(args)
      if vim.startswith(args.match, "tokyonight") then
        themes.tokyonight.setup()
        M.current = "tokyonight"
      elseif vim.startswith(args.match, "catppuccin") then
        themes.catppuccin.setup()
        M.current = "catppuccin"
      elseif vim.startswith(args.match, "hues") then
        themes.hues.setup()
        M.current = "hues"
      end
    end,
  })
end

--- Return list of supported theme names.
---@return string[]
function M.available()
  return { "tokyonight", "catppuccin", "hues" }
end

--- Switch to the specified theme.
---@param name string
---@return boolean
function M.set(name)
  local target = themes[name]
  if not target then
    vim.notify(
      string.format("Unknown theme '%s'. Available: %s", tostring(name), table.concat(M.available(), ", ")),
      vim.log.levels.ERROR
    )
    return false
  end

  target.setup()
  vim.cmd.colorscheme(target.colorscheme)
  M.current = name
  return true
end

--- Toggle / cycle between available themes.
function M.toggle()
  local list = M.available()
  local idx = 1
  for i, name in ipairs(list) do
    if name == M.current then
      idx = i
      break
    end
  end
  local next_theme = list[(idx % #list) + 1]
  M.set(next_theme)
  vim.notify("Theme switched to: " .. next_theme, vim.log.levels.INFO)
end

--- Initialize theme with the default or given theme name.
---@param name? string
function M.setup(name)
  require("loader").packadd("tokyonight.nvim", "catppuccin", "mini.hues")
  init_autocmds()
  M.set(name or "tokyonight")
end

return M
