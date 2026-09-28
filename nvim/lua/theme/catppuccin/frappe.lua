local M = {}

---@param colors table<string, string>
---@return table<string, string>|nil
M.on_colors = function(colors)
  return {
    mantle = "#252838",
    crust = "#1f2230",
  }
end

---@param highlights table<string, any>
---@param colors table<string, string>
M.on_highlights = function(highlights, colors)
  highlights.CursorLineNr = { fg = colors.rosewater, bold = true }
  highlights.LineNr = { fg = colors.surface1 }
end

return M
