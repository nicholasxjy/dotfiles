local ui = require("core.ui")

local M = {}

M.keymap_setup = function()
  vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "LspInfo" })
  -- vim.keymap.set("n", "K", function()
  --   vim.lsp.buf.hover({
  --     border = "rounded",
  --   })
  -- end, { desc = "Hover", silent = true, noremap = true })

  vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

  vim.keymap.set({ "n", "v", "x" }, "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, { desc = "Code Action", noremap = true, silent = true })
  --
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

  -- Diagnostic keymaps
  local diagnostic_goto = function(count, severity)
    local opts = { count = count, severity = severity and vim.diagnostic.severity[severity] or nil }
    return function()
      vim.diagnostic.jump(opts)
    end
  end

  vim.keymap.set("n", "]d", diagnostic_goto(1), { desc = "Next diagnostic" })
  vim.keymap.set("n", "[d", diagnostic_goto(-1), { desc = "Prev diagnostic" })
  vim.keymap.set("n", "]e", diagnostic_goto(1, "ERROR"), { desc = "Next error" })
  vim.keymap.set("n", "[e", diagnostic_goto(-1, "ERROR"), { desc = "Prev error" })
  vim.keymap.set("n", "]w", diagnostic_goto(1, "WARN"), { desc = "Next warning" })
  vim.keymap.set("n", "[w", diagnostic_goto(-1, "WARN"), { desc = "Prev warning" })

  vim.keymap.set("n", "gd", function()
    require("fzf-lua").lsp_definitions({ winopts = ui.fzf.dropdown.winopts })
  end, { desc = "Goto Definition" })

  vim.keymap.set("n", "gD", function()
    require("fzf-lua").lsp_declarations({ winopts = ui.fzf.dropdown.winopts })
  end, { desc = "Goto Declaration" })

  vim.keymap.set("n", "gr", function()
    require("fzf-lua").lsp_references({ winopts = ui.fzf.dropdown.winopts })
  end, { desc = "Goto References" })

  vim.keymap.set("n", "gi", function()
    require("fzf-lua").lsp_implementations({ winopts = ui.fzf.dropdown.winopts })
  end, { desc = "Goto Implementation" })

  vim.keymap.set("n", "gy", function()
    require("fzf-lua").lsp_typedefs({ winopts = ui.fzf.dropdown.winopts })
  end, { desc = "Goto TypeDefs" })

  vim.keymap.set("n", "gI", function()
    require("fzf-lua").lsp_incoming_calls({ winopts = ui.fzf.dropdown.winopts })
  end, { desc = "Incoming Calls" })

  vim.keymap.set("n", "gO", function()
    require("fzf-lua").lsp_outgoing_calls({ winopts = ui.fzf.dropdown.winopts })
  end, { desc = "Outgoing Calls" })

  vim.keymap.set("n", "<leader>ss", function()
    require("fzf-lua").lsp_document_symbols({ winopts = ui.fzf.dropdown.winopts })
  end, { desc = "Lsp symbols" })

  vim.keymap.set("n", "<leader>sS", function()
    require("fzf-lua").lsp_workspace_symbols({ winopts = ui.fzf.dropdown.winopts })
  end, { desc = "Workspace lsp symbols" })

  vim.keymap.set("n", "<leader>xx", function()
    require("fzf-lua").lsp_document_diagnostics({ winopts = ui.fzf.dropdown.winopts })
  end, { desc = "Diagnostics" })

  vim.keymap.set("n", "<leader>xX", function()
    require("fzf-lua").lsp_workspace_diagnostics({ winopts = ui.fzf.dropdown.winopts })
  end, { desc = "Workspace Diagnostics" })

  vim.keymap.set("n", "<leader>xw", function()
    require("fzf-lua").lsp_workspace_diagnostics({
      winopts = vim.tbl_extend("force", ui.fzf.dropdown.winopts, {
        title = "Diagnostics Warns",
      }),
      severity_limit = vim.diagnostic.severity.WARN,
    })
  end, { desc = "Workspace Diagnostics(Warns)" })

  vim.keymap.set("n", "<leader>xe", function()
    require("fzf-lua").lsp_workspace_diagnostics({
      winopts = vim.tbl_extend("force", ui.fzf.dropdown.winopts, {
        title = "Diagnostics Errors",
      }),
      severity_limit = vim.diagnostic.severity.ERROR,
    })
  end, { desc = "Workspace Diagnostics(Errors)" })
end

M.methods_setup = function(client, bufnr)
  local Methods = vim.lsp.protocol.Methods

  if client:supports_method(Methods.textDocument_linkedEditingRange) and vim.fn.has("nvim-0.12") == 1 then
    vim.lsp.linked_editing_range.enable(true, {
      client_id = client.id,
    })
  end
  -- Handle textDocument/onTypeFormatting support
  if client:supports_method(Methods.textDocument_onTypeFormatting) and vim.fn.has("nvim-0.12") == 1 then
    vim.lsp.on_type_formatting.enable(true, {
      client_id = client.id,
    })
  end

  -- Handle textDocument/documentColor support
  if client:supports_method(Methods.textDocument_documentColor) and vim.fn.has("nvim-0.12") == 1 then
    vim.lsp.document_color.enable(true, bufnr, { style = "virtual" })
  end

  if client:supports_method(Methods.textDocument_inlayHints) then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  if client:supports_method(Methods.textDocument_documentHighlight) then
    local under_cursor_highlights_group = vim.api.nvim_create_augroup("xue/cursor_highlights", { clear = false })
    -- When cursor movement is paused or we jump to the normal mode, enable instance highlighting
    vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
      group = under_cursor_highlights_group,
      desc = "Highlight references under the cursor",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })

    -- If the cursor has moved or we go to insert mode or close buffer, disable all instance highlighting
    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
      group = under_cursor_highlights_group,
      desc = "Clear highlight references",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  -- Handle textDocument/codeLens support
  if client:supports_method(Methods.textDocument_codeLens) then
    if vim.g.codelens then
      vim.lsp.codelens.refresh({ bufnr = bufnr })
    end
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
      buffer = bufnr,
      callback = function()
        if vim.g.codelens then
          vim.lsp.codelens.refresh({ bufnr = bufnr })
        else
          vim.lsp.codelens.clear(nil, bufnr)
        end
      end,
    })
  end

  if client and client.name == "eslint" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      group = vim.api.nvim_create_augroup("eslintFix", { clear = true }),
      callback = function()
        if vim.fn.exists(":LspEslintFixAll") > 0 then
          Snacks.notifier("EslintFixAll", "info")
          vim.cmd("LspEslintFixAll")
        end
      end,
    })
  end
end

M.on_attach = function(client, bufnr)
  M.keymap_setup()
  M.methods_setup(client, bufnr)
end

return M
