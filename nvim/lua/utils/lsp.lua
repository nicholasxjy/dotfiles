local M = {}

M.set_keymaps = function()
  vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "LspInfo" })

  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })

  vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
  vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Codelens" })
  vim.keymap.set({ "n", "v" }, "<leader>cC", vim.lsp.codelens.refresh, { desc = "Codelens Refresh" })
  vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
  vim.keymap.set("n", "<leader>cR", Snacks.rename.rename_file, { desc = "Snacks Rename" })

  vim.keymap.set("n", "]]", function()
    Snacks.words.jump(vim.v.count1)
  end, { desc = "Next Reference" })
  vim.keymap.set("n", "[[", function()
    Snacks.words.jump(-vim.v.count1)
  end, { desc = "Prev Reference" })

  vim.keymap.set("n", "gd", function()
    Snacks.picker.lsp_definitions({
      focus = "list",
      layout = {
        preset = "dropdown",
      },
    })
  end, { desc = "Goto Definition" })

  vim.keymap.set("n", "gD", function()
    Snacks.picker.lsp_declarations({
      focus = "list",
      layout = {
        preset = "dropdown",
      },
    })
  end, { desc = "Goto Declaration" })

  vim.keymap.set("n", "gr", function()
    Snacks.picker.lsp_references({
      focus = "list",
      layout = {
        preset = "dropdown",
      },
    })
  end, { desc = "Goto References" })

  vim.keymap.set("n", "gi", function()
    Snacks.picker.lsp_implementations({
      focus = "list",
      layout = {
        preset = "dropdown",
      },
    })
  end, { desc = "Goto Implementation" })

  vim.keymap.set("n", "gy", function()
    Snacks.picker.lsp_type_definitions({
      focus = "list",
      layout = {
        preset = "dropdown",
      },
    })
  end, { desc = "Goto TypeDefs" })

  vim.keymap.set("n", "gI", function()
    require("fzf-lua").lsp_incoming_calls()
  end, { desc = "Incoming Calls" })

  vim.keymap.set("n", "gO", function()
    require("fzf-lua").lsp_outgoing_calls()
  end, { desc = "Outgoing Calls" })

  vim.keymap.set("n", "<leader>ss", function()
    Snacks.picker.lsp_symbols({
      layout = {
        preset = "dropdown",
      },
    })
  end, { desc = "Document symbols" })

  vim.keymap.set("n", "<leader>sS", function()
    Snacks.picker.lsp_workspace_symbols({
      layout = {
        preset = "dropdown",
      },
    })
  end, { desc = "Workspace symbols" })

  vim.keymap.set("n", "<leader>xx", function()
    Snacks.picker.diagnostics_buffer({
      focus = "list",
      layout = { preset = "dropdown" },
    })
  end, { desc = "Document Diagnostics" })

  vim.keymap.set("n", "<leader>xw", function()
    Snacks.picker.diagnostics({
      focus = "list",
      layout = { preset = "dropdown" },
    })
  end, { desc = "Workspace Diagnostics" })

  -- vim.keymap.set("n", "<leader>ca", function()
  --   require("fzf-lua").lsp_code_actions()
  -- end, { desc = "Code Actions" })
end

M.on_attach = function(fn)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        return fn(client, buffer)
      end
    end,
  })
end

M.set_method = function(method, fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "LspSupportsMethod",
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local buffer = args.data.buffer
      if client and method == args.data.method then
        return fn(client, buffer)
      end
    end,
  })
end

M.setup = function(opts)
  local register_capability = vim.lsp.handlers["client/registerCapability"]
  vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
    local ret = register_capability(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if client then
      for buffer in pairs(client.attached_buffers) do
        vim.api.nvim_exec_autocmds("User", {
          pattern = "LspDynamicCapability",
          data = { client_id = client.id, buffer = buffer },
        })
      end
    end
    return ret
  end

  ---@diagnostic disable-next-line: unused-local
  M.set_method("textDocument/inlayHint", function(client, buffer)
    -- inlay hints
    if opts.inlay_hints.enabled then
      if
        vim.api.nvim_buf_is_valid(buffer)
        and vim.bo[buffer].buftype == ""
        and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
      then
        vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
      end
    end
  end)

  ---@diagnostic disable-next-line: unused-local
  M.set_method("textDocument/codeLens", function(client, buffer)
    -- code lens
    if opts.codelens.enabled and vim.lsp.codelens then
      vim.lsp.codelens.refresh()
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = buffer,
        callback = vim.lsp.codelens.refresh,
      })
    end
  end)
end

M.action = setmetatable({}, {
  __index = function(_, action)
    return function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { action },
          diagnostics = {},
        },
      })
    end
  end,
})

function M.execute(opts)
  local params = {
    command = opts.command,
    arguments = opts.arguments,
  }
  return vim.lsp.buf_request(0, "workspace/executeCommand", params, opts.handler)
end

function M.get_raw_config(server)
  local ok, ret = pcall(require, "lspconfig.configs." .. server)
  if ok then
    return ret
  end
  return require("lspconfig.server_configurations." .. server)
end

return M
