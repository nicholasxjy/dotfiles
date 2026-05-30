local M = {}

local function kind_matches(expected, actual)
  if type(expected) == "table" then
    return vim.tbl_contains(expected, actual)
  end

  return expected == actual
end

local function should_load_plugin(action)
  return type(action) ~= "table"
end

local function run_build_action(action, ev)
  if type(action) == "function" then
    return action(ev)
  end

  if type(action) == "string" then
    return vim.cmd(action)
  end

  if type(action) == "table" then
    local result = vim
      .system(action, {
        cwd = ev.data.path,
        text = true,
      })
      :wait()

    if result.code ~= 0 then
      vim.notify(
        ("build command failed for %s\n%s"):format(
          ev.data.spec.name,
          result.stderr ~= "" and result.stderr or result.stdout
        ),
        vim.log.levels.ERROR
      )
    end

    return result
  end

  error("build_on_change action must be a function, string, or table")
end

M.build_on_change = function(name, kinds, action)
  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
      local spec_name, ev_kind = ev.data.spec.name, ev.data.kind
      if spec_name ~= name or not kind_matches(kinds, ev_kind) then
        return
      end

      if should_load_plugin(action) and not ev.data.active then
        vim.cmd.packadd(name)
      end

      run_build_action(action, ev)
    end,
  })
end

M.build_cmd_on_change = function(name, kinds, cmd)
  return M.build_on_change(name, kinds, cmd)
end

M.build_fn_on_change = function(name, kinds, fn)
  return M.build_on_change(name, kinds, fn)
end

return M
