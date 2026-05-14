local M = {}

-- ┃, ┆, ┇, ┊, ┋, ╎, ╏, ║, ╽, ╿

M.border = function()
  return "%#StatusBorder#│ " -- │┃, ┆, ┇, ┊, ┋, ╎, ╏, ║, ╽, ╿
end

M.number = function()
  local lnum = vim.v.lnum
  local r = vim.v.relnum
  return string.format("%3d ", (r == 0 and lnum or r))
end

local function current_bufnr()
  local winid = vim.g.statusline_winid or 0
  if winid == 0 then
    return vim.api.nvim_get_current_buf()
  end
  return vim.api.nvim_win_get_buf(winid)
end

local function find_mark(bufnr, lnum)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local normalized_bufname = bufname ~= "" and vim.fs.normalize(bufname) or nil

  local function pick(entries)
    for _, entry in ipairs(entries) do
      local pos = entry.pos
      local mark = entry.mark
      local same_buffer = pos and pos[1] == bufnr

      if not same_buffer and normalized_bufname and entry.file then
        same_buffer = vim.fs.normalize(entry.file) == normalized_bufname
      end

      if same_buffer and pos and pos[2] == lnum and mark and mark:match("^'[a-zA-Z]$") then
        return mark:sub(2)
      end
    end
  end

  return pick(vim.fn.getmarklist(bufnr)) or pick(vim.fn.getmarklist())
end

M.marks = function()
  local mark = find_mark(current_bufnr(), vim.v.lnum)
  if not mark then
    return "  "
  end
  return "%#Keyword#" .. mark .. " "
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

  -- local rainbow_colors = {
  --   "RainbowDelimiterRed",
  --   "RainbowDelimiterOrange",
  --   "RainbowDelimiterYellow",
  --   "RainbowDelimiterGreen",
  --   "RainbowDelimiterCyan",
  --   "RainbowDelimiterBlue",
  --   "RainbowDelimiterViolet",
  -- }
  -- local group = rainbow_colors[(foldlevel - 1) % #rainbow_colors + 1]

  local group = "LineNr"
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
    M.marks(),
    M.number(),
    "%s",
    M.border(),
    M.folds(),
  })
  return text
end

return M
