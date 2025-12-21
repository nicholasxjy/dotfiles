local M = {}

-- ┃, ┆, ┇, ┊, ┋, ╎, ╏, ║, ╽, ╿

M.border = function()
  return "%#StatusBorder#┃ " -- ┃, ┆, ┇, ┊, ┋, ╎, ╏, ║, ╽, ╿
end

M.number = function()
  local lnum = vim.v.lnum
  local r = vim.v.relnum
  return string.format("%3d ", (r == 0 and lnum or r))
end

M.folds = function()
  local foldlevel = vim.fn.foldlevel(vim.v.lnum)
  local foldlevel_before = vim.fn.foldlevel((vim.v.lnum - 1) >= 1 and vim.v.lnum - 1 or 1)
  local foldlevel_after =
    vim.fn.foldlevel((vim.v.lnum + 1) <= vim.fn.line("$") and (vim.v.lnum + 1) or vim.fn.line("$"))

  local foldclosed = vim.fn.foldclosed(vim.v.lnum)

  if foldlevel == 0 then
    return "  "
  end

  local rainbow_colors = {
    "RainbowDelimiterRed",
    "RainbowDelimiterOrange",
    "RainbowDelimiterYellow",
    "RainbowDelimiterGreen",
    "RainbowDelimiterCyan",
    "RainbowDelimiterBlue",
    "RainbowDelimiterViolet",
  }
  local group = rainbow_colors[(foldlevel - 1) % #rainbow_colors + 1]

  if foldclosed ~= -1 and foldclosed == vim.v.lnum then
    return "%#" .. "String" .. "# "
  end

  if foldlevel > foldlevel_before then
    return "%#" .. group .. "# "
  end

  if foldlevel > foldlevel_after then
    return "%#" .. group .. "# "
  end

  return "%#" .. group .. "#╎ "
end

M.setup = function()
  local text = ""

  text = table.concat({
    " %s",
    M.number(),
    M.folds(),
    M.border(),
  })
  return text
end

return M
