local M = {}

local is_fzf_picker = vim.g.picker == "fzf"
local fzflua = require("fzf-lua")

local function lsp_definitions()
  if is_fzf_picker then
    fzflua.lsp_definitions()
  else
    Snacks.picker.lsp_definitions()
  end
end

local function lsp_declarations()
  if is_fzf_picker then
    fzflua.lsp_declarations()
  else
    Snacks.picker.lsp_declarations()
  end
end

local function lsp_implementations()
  if is_fzf_picker then
    fzflua.lsp_implementations()
  else
    Snacks.picker.lsp_implementations()
  end
end
local function lsp_references()
  if is_fzf_picker then
    fzflua.lsp_references()
  else
    Snacks.picker.lsp_references()
  end
end
local function lsp_type_definitions()
  if is_fzf_picker then
    fzflua.lsp_typedefs()
  else
    Snacks.picker.lsp_type_definitions()
  end
end
local function lsp_incoming_calls()
  if is_fzf_picker then
    fzflua.lsp_incoming_calls()
  else
    Snacks.picker.lsp_incoming_calls()
  end
end
local function lsp_outgoing_calls()
  if is_fzf_picker then
    fzflua.lsp_outgoing_calls()
  else
    Snacks.picker.lsp_outgoing_calls()
  end
end
local function lsp_symbols()
  if is_fzf_picker then
    fzflua.lsp_document_symbols()
  else
    Snacks.picker.lsp_symbols()
  end
end
local function lsp_workspace_symbols()
  if is_fzf_picker then
    fzflua.lsp_workspace_symbols()
  else
    Snacks.picker.lsp_workspace_symbols()
  end
end

local function diagnostics_buffer()
  if is_fzf_picker then
    fzflua.diagnostics_document()
  else
    Snacks.picker.diagnostics_buffer()
  end
end

local function diagnostics_workspace()
  if is_fzf_picker then
    fzflua.diagnostics_workspace()
  else
    Snacks.picker.diagnostics({
      sort = {
        fields = {
          "severity",
          "is_current",
          "is_cwd",
          "file",
          "lnum",
        },
      },
    })
  end
end

local function diagnostics_workspace_warns()
  if is_fzf_picker then
    fzflua.diagnostics_workspace({
      severity_limit = vim.diagnostic.severity.WARN,
      sort = true,
    })
  else
    Snacks.picker.diagnostics({
      sort = {
        fields = {
          "severity",
          "is_current",
          "is_cwd",
          "file",
          "lnum",
        },
      },
      severity = { min = vim.diagnostic.severity.WARN },
    })
  end
end
local function diagnostics_workspace_errors()
  if is_fzf_picker then
    fzflua.diagnostics_workspace({
      sort = true,
      severity_limit = vim.diagnostic.severity.ERROR,
    })
  else
    Snacks.picker.diagnostics({
      sort = {
        fields = {
          "severity",
          "is_current",
          "is_cwd",
          "file",
          "lnum",
        },
      },
      severity = { min = vim.diagnostic.severity.ERROR },
    })
  end
end
M.keymap_setup = function()
  vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "LspInfo" })
  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover({
      border = "single",
    })
  end, { desc = "Hover", silent = true, noremap = true })

  vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

  vim.keymap.set({ "n", "v", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
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

  vim.keymap.set("n", "gd", lsp_definitions, { desc = "Goto Definition", noremap = true })
  vim.keymap.set("n", "gD", lsp_declarations, { desc = "Goto Declaration", noremap = true })
  vim.keymap.set("n", "gr", lsp_references, { desc = "Goto References", noremap = true })
  vim.keymap.set("n", "gi", lsp_implementations, { desc = "Goto Implementation", noremap = true })
  vim.keymap.set("n", "gy", lsp_type_definitions, { desc = "Goto TypeDefs", noremap = true })
  vim.keymap.set("n", "gI", lsp_incoming_calls, { desc = "Incoming Calls", noremap = true })
  vim.keymap.set("n", "gO", lsp_outgoing_calls, { desc = "Outgoing Calls", noremap = true })
  vim.keymap.set("n", "<leader>ss", lsp_symbols, { desc = "Lsp symbols" })
  vim.keymap.set("n", "<leader>sS", lsp_workspace_symbols, { desc = "Workspace lsp symbols" })

  vim.keymap.set("n", "<leader>xx", diagnostics_buffer, { desc = "Diagnostics" })
  vim.keymap.set("n", "<leader>xX", diagnostics_workspace, { desc = "Workspace Diagnostics" })
  vim.keymap.set("n", "<leader>xw", diagnostics_workspace_warns, { desc = "Workspace Diagnostics(Warns)" })
  vim.keymap.set("n", "<leader>xe", diagnostics_workspace_errors, { desc = "Workspace Diagnostics(Errors)" })
end

-- local disable_semantic_ls = {
--   "jdtls",
--   "gopls",
--   "lua_ls",
-- }

M.methods_setup = function(client, bufnr)
  local Methods = vim.lsp.protocol.Methods

  -- NOTE: disalbe semantic tokens
  -- if client.server_capabilities.semanticTokensProvider and vim.tbl_contains(disable_semantic_ls, client.name) then
  --   client.server_capabilities.semanticTokensProvider = nil
  -- end

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

  -- NOTE: use nvim-highlight-colors instead
  -- Handle textDocument/documentColor support
  if client:supports_method(Methods.textDocument_documentColor) and vim.fn.has("nvim-0.12") == 1 then
    vim.lsp.document_color.enable(true, bufnr, { style = "background" }) --background, foreground, virtual
  end

  -- disable inlay hints by default
  if client:supports_method(Methods.textDocument_inlayHints) then
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
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
