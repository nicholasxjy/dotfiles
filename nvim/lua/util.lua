local M = {}

local function to_hex(color)
  return color and string.format("#%06x", color) or nil
end

M.build_on_change = function(name, kind, cmd)
  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
      local spec_name, ev_kind = ev.data.spec.name, ev.data.kind
      if spec_name == name and ev_kind == kind then
        if not ev.data.active then
          vim.cmd.packadd(name)
        end
        vim.cmd(cmd)
      end
    end,
  })
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

M.later = function(f, delay, event, once)
  vim.api.nvim_create_autocmd(event, {
    once = once,
    callback = function()
      vim.defer_fn(f, delay)
    end,
  })
end

return M
