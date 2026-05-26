local M = {}

local function to_hex(color)
  return color and string.format("#%06x", color) or nil
end

M.get_hl_colors = function(groups)
  groups = type(groups) == "table" and groups or { groups }

  for _, group in ipairs(groups) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, {
      name = group,
      link = false,
      create = false,
    })

    if ok and hl and (hl.fg or hl.bg) then
      return {
        fg = to_hex(hl.fg),
        bg = to_hex(hl.bg),
      }
    end
  end

  return {}
end

return M
