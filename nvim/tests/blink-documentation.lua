-- Run with: nvim --headless -i NONE "+luafile tests/blink-documentation.lua"
local fixture = vim.fn.tempname() .. ".json"
local errors = {}
local notify = vim.notify
vim.notify = function(message, level, opts)
  if level == vim.log.levels.ERROR then
    errors[#errors + 1] = tostring(message)
  end
  return notify(message, level, opts)
end

vim.defer_fn(function()
  local ok, err = xpcall(function()
    vim.fn.writefile({ "{", '  "name": "example-package"', "}" }, fixture)
    vim.cmd.edit(vim.fn.fnameescape(fixture))
    vim.api.nvim_exec_autocmds("InsertEnter", { modeline = false })
    assert(package.loaded["blink.cmp"], "completion did not load")
    assert(vim.fn.maparg("<leader>uc", "n") ~= "", "Treesitter context keymap missing")

    local docs = require("blink.cmp.lib.window.docs")
    local ns = require("blink.cmp.config").appearance.highlight_ns
    local buf = vim.api.nvim_create_buf(false, true)
    docs.render_detail_and_documentation({
      bufnr = buf,
      detail = "string",
      documentation = { kind = "markdown", value = "The **package name**." },
      max_width = 80,
      use_treesitter_highlighting = true,
    })
    assert(vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == "string", "standard documentation missing")
    assert(#vim.api.nvim_buf_get_extmarks(buf, ns, 0, -1, {}) > 1, "standard documentation highlighting missing")
    assert(#errors == 0, table.concat(errors, "\n"))
    print("PASS: standard JSON completion documentation, highlighting, and keymaps")
  end, debug.traceback)
  local fixture_buf = vim.fn.bufnr(fixture)
  if fixture_buf > 0 then
    vim.api.nvim_buf_delete(fixture_buf, { force = true })
  end
  vim.fn.delete(fixture)
  vim.notify = notify
  if not ok then
    io.stderr:write(tostring(err) .. "\n")
    vim.cmd("cquit 1")
  else
    vim.cmd("qa!")
  end
end, 200)
