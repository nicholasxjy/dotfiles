local M = {}

M.expr = "%!v:lua.__statuscolumn()"

local EMPTY = "  "
local MARK_CACHE_TTL_MS = 1000
local GIT_CACHE_TTL_MS = 200
local mark_cache = {}
local git_cache = {}

local function current_winid()
  return vim.g.statusline_winid or vim.api.nvim_get_current_win()
end

local function current_bufnr(winid)
  return vim.api.nvim_win_get_buf(winid)
end

local function line_number_text()
  local number = vim.v.relnum
  if number == 0 then
    number = vim.v.lnum
  end

  if number < 10 then
    return "  " .. number .. " "
  end
  if number < 100 then
    return " " .. number .. " "
  end
  return number .. " "
end

local function clear_mark_cache(bufnr)
  if bufnr and bufnr > 0 then
    mark_cache[bufnr] = nil
  end
end

local function clear_git_cache(bufnr)
  if bufnr and bufnr > 0 then
    git_cache[bufnr] = nil
  end
end

local function add_marks(by_lnum, entries, bufnr, normalized_bufname)
  for _, entry in ipairs(entries) do
    local pos = entry.pos
    local mark = entry.mark
    if pos and mark and mark:match("^'[a-zA-Z]$") then
      local same_buffer = pos[1] == bufnr
      if not same_buffer and normalized_bufname and entry.file then
        same_buffer = vim.fs.normalize(entry.file) == normalized_bufname
      end
      if same_buffer and by_lnum[pos[2]] == nil then
        by_lnum[pos[2]] = mark:sub(2)
      end
    end
  end
end

local function marks_for_buffer(bufnr)
  local now = vim.uv.now()
  local cached = mark_cache[bufnr]
  if cached and cached.expires_at > now then
    return cached.by_lnum
  end

  local by_lnum = {}
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local normalized_bufname = bufname ~= "" and vim.fs.normalize(bufname) or nil

  add_marks(by_lnum, vim.fn.getmarklist(bufnr), bufnr, normalized_bufname)
  add_marks(by_lnum, vim.fn.getmarklist(), bufnr, normalized_bufname)

  mark_cache[bufnr] = {
    by_lnum = by_lnum,
    expires_at = now + MARK_CACHE_TTL_MS,
  }

  return by_lnum
end

local function mark_text(bufnr, lnum)
  local mark = marks_for_buffer(bufnr)[lnum]
  if not mark then
    return EMPTY
  end
  return "%#Keyword#" .. mark .. " "
end

local function git_text(bufnr, lnum)
  local now = vim.uv.now()
  local cached = git_cache[bufnr]
  if cached and cached.expires_at > now and cached.by_lnum[lnum] ~= nil then
    return cached.by_lnum[lnum]
  end
  if not cached or cached.expires_at <= now then
    cached = {
      by_lnum = {},
      expires_at = now + GIT_CACHE_TTL_MS,
    }
    git_cache[bufnr] = cached
  end

  local gitsigns = package.loaded.gitsigns
  if type(gitsigns) ~= "table" or type(gitsigns.statuscolumn) ~= "function" then
    return EMPTY
  end

  local ok, text = pcall(gitsigns.statuscolumn, bufnr, lnum)
  if not ok or text == nil or text == "" then
    text = EMPTY
  end

  cached.by_lnum[lnum] = text

  return text
end

local function fold_text(lnum)
  if vim.fn.foldclosed(lnum) == lnum then
    return "+"
  end

  local level = vim.fn.foldlevel(lnum)
  if level == 0 then
    return " "
  end

  local previous_level = lnum > 1 and vim.fn.foldlevel(lnum - 1) or 0
  local next_level = lnum < vim.fn.line("$") and vim.fn.foldlevel(lnum + 1) or 0
  if level > previous_level or level > next_level then
    return "-"
  end

  return "|"
end

function M.setup()
  local winid = current_winid()
  local bufnr = current_bufnr(winid)
  local lnum = vim.v.lnum

  return table.concat({
    mark_text(bufnr, lnum),
    "%s",
    line_number_text(),
    git_text(bufnr, lnum),
    "%#FoldColumn#" .. fold_text(lnum),
    "%#StatusBorder# ",
  })
end

function M.enabled(winid)
  winid = winid or vim.api.nvim_get_current_win()
  return vim.api.nvim_get_option_value("statuscolumn", { win = winid }) == M.expr
end

function M.enable(winid)
  winid = winid or vim.api.nvim_get_current_win()
  vim.api.nvim_set_option_value("statuscolumn", M.expr, { win = winid })
end

function M.disable(winid)
  winid = winid or vim.api.nvim_get_current_win()
  vim.api.nvim_set_option_value("statuscolumn", "", { win = winid })
end

function M.toggle(winid)
  if M.enabled(winid) then
    M.disable(winid)
  else
    M.enable(winid)
  end
end

vim.api.nvim_create_user_command("StatuscolumnToggle", function()
  M.toggle()
end, { desc = "Toggle statuscolumn in the current window" })

local group = vim.api.nvim_create_augroup("Statuscolumn", { clear = true })
vim.api.nvim_create_autocmd({ "BufDelete", "BufEnter", "BufWritePost", "BufWipeout", "CmdlineLeave", "CursorHold" }, {
  group = group,
  callback = function(ev)
    clear_mark_cache(ev.buf)
    clear_git_cache(ev.buf)
  end,
})

function _G.__statuscolumn()
  return M.setup()
end

return M
