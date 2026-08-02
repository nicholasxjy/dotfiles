local M = {}

local loaded = {}
local groups = {}

local function group(name)
  groups[name] = groups[name] or vim.api.nvim_create_augroup("sjvim_loader_" .. name, { clear = true })
  return groups[name]
end

function M.load(name, setup)
  if loaded[name] then
    return true
  end

  local ok, err = pcall(setup)
  if not ok then
    vim.notify(("Failed to load %s:\n%s"):format(name, err), vim.log.levels.ERROR)
    return false
  end

  loaded[name] = true
  return true
end

function M.defer(name, setup, events)
  vim.api.nvim_create_autocmd(events or "VimEnter", {
    group = group(name),
    once = true,
    callback = function()
      M.load(name, setup)
    end,
  })
end

function M.defer_buffer(name, setup)
  vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile", "BufFilePost" }, {
    group = group(name),
    callback = function(args)
      local bufname = vim.api.nvim_buf_get_name(args.buf)
      if vim.bo[args.buf].buftype ~= "" or bufname == "" then
        return
      end

      M.load(name, setup)
    end,
  })
end

return M
