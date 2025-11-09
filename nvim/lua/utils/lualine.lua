local M = {}

local function dart(opts)
  return function()
    if not Dart then
      return {}
    end
    local files = {}
    for _, item in ipairs(Dart.state()) do
      local name = vim.fn.fnamemodify(item.filename, Dart.config.picker.path_format or ":t")
      local text = "%#Keyword#" .. item.mark .. "%*" .. " " .. name
      table.insert(files, text)
    end
    return table.concat(files, " | ")
  end
end

M.dart = dart

return M
