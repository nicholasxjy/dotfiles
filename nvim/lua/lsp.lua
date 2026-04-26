local ui = require("ui")

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = false,
  virtual_lines = false,
  float = {
    spacing = 4,
    source = "if_many",
    prefix = "● ",
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ui.icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = ui.icons.diagnostics.Warn,
      [vim.diagnostic.severity.HINT] = ui.icons.diagnostics.Hint,
      [vim.diagnostic.severity.INFO] = ui.icons.diagnostics.Info,
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
  },
})

vim.lsp.enable({
  "lua_ls",
  -- "emmylua_ls",
  -- "copilot",
  "bashls",

  "dockerls",
  "docker_compose_language_service",

  "html",
  "cssls",
  "biome",
  "eslint",
  "vtsls",
  "vuels",

  "gopls",
  "golangci_lint_ls",

  "jsonls",

  "marksman",

  "pyright",
  "ruff",

  "yamlls",

  "taplo",

  "zls",
})

local snacks = require("snacks")
local fzf_cache = nil

local function get_fzf()
  if fzf_cache == nil then
    if type(_G.__setup_fzf) == "function" then
      _G.__setup_fzf()
    end
    local ok, mod = pcall(require, "fzf-lua")
    fzf_cache = ok and mod or false
  end
  return fzf_cache ~= false and fzf_cache or nil
end

local function pick(snacks_name, snacks_opts, fzf_name, fzf_opts)
  local snacks_method = snacks.picker[snacks_name]
  local fzf_method_name = fzf_name or snacks_name

  return function()
    if vim.g.picker == "fzf" then
      local fzf = get_fzf()
      local fzf_method = fzf and fzf[fzf_method_name]
      if fzf_method then
        return fzf_method(fzf_opts)
      end
    end
    return snacks_method(snacks_opts)
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

local function fzf_diagnostics_opts(min_severity)
  local opts = { sort = true }
  if min_severity then
    opts.severity_limit = min_severity
  end
  return opts
end

local lsp_definitions = pick("lsp_definitions")
local lsp_declarations = pick("lsp_declarations")
local lsp_implementations = pick("lsp_implementations")
local lsp_references = pick("lsp_references")
local lsp_type_definitions = pick("lsp_type_definitions", nil, "lsp_typedefs")
local lsp_incoming_calls = pick("lsp_incoming_calls")
local lsp_outgoing_calls = pick("lsp_outgoing_calls")
local lsp_symbols = pick("lsp_symbols", nil, "lsp_document_symbols")
local lsp_workspace_symbols = pick("lsp_workspace_symbols")

local diagnostics_buffer = pick("diagnostics_buffer", nil, "diagnostics_document", { sort = true })
local diagnostics_workspace = pick("diagnostics", diagnostics_opts(), "diagnostics_workspace", fzf_diagnostics_opts())
local diagnostics_workspace_warns = pick(
  "diagnostics",
  diagnostics_opts(vim.diagnostic.severity.WARN),
  "diagnostics_workspace",
  fzf_diagnostics_opts(vim.diagnostic.severity.WARN)
)
local diagnostics_workspace_errors = pick(
  "diagnostics",
  diagnostics_opts(vim.diagnostic.severity.ERROR),
  "diagnostics_workspace",
  fzf_diagnostics_opts(vim.diagnostic.severity.ERROR)
)

local keymap_setup = function()
  if vim.g.lsp_keymaps_ready then
    return
  end
  vim.g.lsp_keymaps_ready = true

  vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "LspInfo" })

  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", silent = true })

  vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  vim.keymap.set({ "n", "v", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
  --
  vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Codelens" })

  vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
  vim.keymap.set("n", "<leader>cR", Snacks.rename.rename_file, { desc = "Snacks Rename" })

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

  vim.keymap.set("n", "gd", lsp_definitions, { desc = "Goto Definition" })
  vim.keymap.set("n", "gD", lsp_declarations, { desc = "Goto Declaration" })
  vim.keymap.set("n", "gr", lsp_references, { desc = "Goto References" })
  vim.keymap.set("n", "gi", lsp_implementations, { desc = "Goto Implementation" })
  vim.keymap.set("n", "gy", lsp_type_definitions, { desc = "Goto TypeDefs" })
  vim.keymap.set("n", "gI", lsp_incoming_calls, { desc = "Incoming Calls" })
  vim.keymap.set("n", "gO", lsp_outgoing_calls, { desc = "Outgoing Calls" })

  vim.keymap.set("n", "<leader>ss", lsp_symbols, { desc = "Lsp symbols" })
  vim.keymap.set("n", "<leader>sS", lsp_workspace_symbols, { desc = "Workspace lsp symbols" })

  vim.keymap.set("n", "<leader>xx", diagnostics_buffer, { desc = "Diagnostics" })
  vim.keymap.set("n", "<leader>xX", diagnostics_workspace, { desc = "Workspace Diagnostics" })
  vim.keymap.set("n", "<leader>xw", diagnostics_workspace_warns, { desc = "Workspace Diagnostics(Warns)" })
  vim.keymap.set("n", "<leader>xe", diagnostics_workspace_errors, { desc = "Workspace Diagnostics(Errors)" })
end

local methods_setup = function(client, bufnr)
  if vim.lsp.inlay_hint and client:supports_method("textDocument/inlayHint", { bufnr = bufnr }) then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
  if vim.lsp.linked_editing_range and client:supports_method("textDocument/linkedEditingRange", { bufnr = bufnr }) then
    vim.lsp.linked_editing_range.enable(true, { bufnr = bufnr })
  end
  if vim.lsp.on_type_formatting and client:supports_method("textDocument/onTypeFormatting", { bufnr = bufnr }) then
    vim.lsp.on_type_formatting.enable(true, { bufnr = bufnr })
  end

  if client.name == "eslint" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      group = vim.api.nvim_create_augroup("eslint_fix_" .. bufnr, { clear = true }),
      callback = function()
        if vim.fn.exists(":LspEslintFixAll") > 0 then
          vim.cmd("LspEslintFixAll")
        end
      end,
    })
  end
end

keymap_setup()

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(args)
    local client_id = args.data and args.data.client_id
    if not client_id then
      return
    end

    local client = vim.lsp.get_client_by_id(client_id)
    if not client then
      return
    end

    methods_setup(client, args.buf)
  end,
})
