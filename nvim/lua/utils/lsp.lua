local M = {}

local function using_fzf_picker()
  return vim.g.picker == "fzf"
end

local function picker_call(fzf_name, snacks_name, fzf_opts, snacks_opts)
  return function()
    if using_fzf_picker() then
      require("fzf-lua")[fzf_name](fzf_opts)
    else
      Snacks.picker[snacks_name](snacks_opts)
    end
  end
end

local diagnostics_sort = {
  sort = {
    fields = {
      "severity",
      "is_current",
      "is_cwd",
      "file",
      "lnum",
    },
  },
}

local function diagnostics_opts(min_severity)
  local opts = vim.deepcopy(diagnostics_sort)
  if min_severity then
    opts.severity = { min = min_severity }
  end
  return opts
end

local lsp_definitions = picker_call("lsp_definitions", "lsp_definitions")
local lsp_declarations = picker_call("lsp_declarations", "lsp_declarations")
local lsp_implementations = picker_call("lsp_implementations", "lsp_implementations")
local lsp_references = picker_call("lsp_references", "lsp_references")
local lsp_type_definitions = picker_call("lsp_typedefs", "lsp_type_definitions")
local lsp_incoming_calls = picker_call("lsp_incoming_calls", "lsp_incoming_calls")
local lsp_outgoing_calls = picker_call("lsp_outgoing_calls", "lsp_outgoing_calls")
local lsp_symbols = picker_call("lsp_document_symbols", "lsp_symbols")
local lsp_workspace_symbols = picker_call("lsp_workspace_symbols", "lsp_workspace_symbols")

local diagnostics_buffer = picker_call("diagnostics_document", "diagnostics_buffer", { sort = true })
local diagnostics_workspace = picker_call("diagnostics_workspace", "diagnostics", { sort = true }, diagnostics_opts())
local diagnostics_workspace_warns = picker_call("diagnostics_workspace", "diagnostics", {
  severity_limit = vim.diagnostic.severity.WARN,
  sort = true,
}, diagnostics_opts(vim.diagnostic.severity.WARN))
local diagnostics_workspace_errors = picker_call("diagnostics_workspace", "diagnostics", {
  severity_limit = vim.diagnostic.severity.ERROR,
  sort = true,
}, diagnostics_opts(vim.diagnostic.severity.ERROR))
M.keymap_setup = function()
  if vim.g.lsp_keymaps_ready then
    return
  end
  vim.g.lsp_keymaps_ready = true

  vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "LspInfo" })

  -- vim.keymap.set("n", "K", function()
  --   vim.lsp.buf.hover()
  -- end, { desc = "Hover", silent = true })

  vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  vim.keymap.set({ "n", "v", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
  --
  vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Codelens" })

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

M.methods_setup = function(client, bufnr)
  local Methods = vim.lsp.protocol.Methods

  vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  vim.lsp.linked_editing_range.enable(true, { bufnr = bufnr })
  vim.lsp.on_type_formatting.enable(true, { bufnr = bufnr })

  if client:supports_method(Methods.textDocument_documentHighlight) then
    local under_cursor_highlights_group =
      vim.api.nvim_create_augroup("xue_cursor_highlights_" .. bufnr, { clear = true })
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

  if client and client.name == "eslint" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      group = vim.api.nvim_create_augroup("eslint_fix_" .. bufnr, { clear = true }),
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
  if vim.b[bufnr].lsp_attached then
    return
  end
  vim.b[bufnr].lsp_attached = true
  M.keymap_setup()
  M.methods_setup(client, bufnr)
end

return M
