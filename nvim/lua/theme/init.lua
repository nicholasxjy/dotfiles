local M = {}

local group = vim.api.nvim_create_augroup("sjvim_theme_load", { clear = true })
local themes = {
  catppuccin = { "catppuccin", "catppuccin-*" },
  tokyonight = { "tokyonight", "tokyonight-*" },
  ["mini-hues"] = { "randomhue", "minispring", "minisummer", "miniautumn", "miniwinter", "minischeme" },
}

-- Commands and picker previews must configure optional plugins before their colors files run.
for name, patterns in pairs(themes) do
  vim.api.nvim_create_autocmd("ColorSchemePre", {
    group = group,
    pattern = patterns,
    callback = function()
      require("theme." .. name).setup()
      vim.api.nvim_clear_autocmds({ group = group, pattern = patterns })
    end,
  })
end

local aliases = {
  ["mini-hues"] = "minischeme",
  catppuccin = "catppuccin-nvim",
}

--- Load a theme or colorscheme variant, falling back to mini.hues on failure.
---@param name? string Theme name, e.g. "catppuccin-mocha"
function M.load(name)
  name = aliases[name] or name or "minischeme"
  local ok, err = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.notify(("Failed to load colorscheme %s:\n%s"):format(name, err), vim.log.levels.WARN)
    vim.cmd.colorscheme("minischeme")
  end
end

return M
