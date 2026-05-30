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

local enabled_servers = {
  "lua_ls",
  -- "emmylua_ls",
  "copilot",
  "bashls",

  "dockerls",
  "docker_compose_language_service",

  "html",
  "cssls",
  "biome",
  "eslint",
  "vtsls",
  "vue_ls",

  "gopls",
  "golangci_lint_ls",

  "jsonls",

  "marksman",

  "pyright",
  "ruff",

  "yamlls",

  "taplo",

  "zls",
}

local function pick(snacks_name, snacks_opts)
  return function()
    local snacks = require("snacks")
    local snacks_method = snacks and snacks.picker and snacks.picker[snacks_name]
    if snacks_method then
      return snacks_method(snacks_opts)
    end

    vim.notify(("Picker unavailable: %s"):format(snacks_name), vim.log.levels.WARN)
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

local lsp_definitions = pick("lsp_definitions")
local lsp_declarations = pick("lsp_declarations")
local lsp_implementations = pick("lsp_implementations")
local lsp_references = pick("lsp_references")
local lsp_type_definitions = pick("lsp_type_definitions")
local lsp_incoming_calls = pick("lsp_incoming_calls")
local lsp_outgoing_calls = pick("lsp_outgoing_calls")
local lsp_symbols = pick("lsp_symbols")
local lsp_workspace_symbols = pick("lsp_workspace_symbols")

local diagnostics_buffer = pick("diagnostics_buffer")
local diagnostics_workspace = pick("diagnostics", diagnostics_opts())
local diagnostics_workspace_warns = pick("diagnostics", diagnostics_opts(vim.diagnostic.severity.WARN))
local diagnostics_workspace_errors = pick("diagnostics", diagnostics_opts(vim.diagnostic.severity.ERROR))

local function lsp_keymaps(opts)
  vim.keymap.set("n", "gd", lsp_definitions, vim.tbl_extend("force", opts, { desc = "Goto Definition" }))
  vim.keymap.set("n", "gD", lsp_declarations, vim.tbl_extend("force", opts, { desc = "Goto Declaration" }))
  vim.keymap.set("n", "gr", lsp_references, vim.tbl_extend("force", opts, { desc = "Goto References" }))
  vim.keymap.set("n", "gi", lsp_implementations, vim.tbl_extend("force", opts, { desc = "Goto Implementation" }))
  vim.keymap.set("n", "gy", lsp_type_definitions, vim.tbl_extend("force", opts, { desc = "Goto TypeDefs" }))
  vim.keymap.set("n", "gI", lsp_incoming_calls, vim.tbl_extend("force", opts, { desc = "Incoming Calls" }))
  vim.keymap.set("n", "gO", lsp_outgoing_calls, vim.tbl_extend("force", opts, { desc = "Outgoing Calls" }))

  vim.keymap.set("n", "<leader>ss", lsp_symbols, { desc = "Lsp symbols" })
  vim.keymap.set("n", "<leader>sS", lsp_workspace_symbols, { desc = "Workspace lsp symbols" })

  vim.keymap.set("n", "<leader>xx", diagnostics_buffer, { desc = "Diagnostics" })
  vim.keymap.set("n", "<leader>xX", diagnostics_workspace, { desc = "Workspace Diagnostics" })
  vim.keymap.set("n", "<leader>xw", diagnostics_workspace_warns, { desc = "Workspace Diagnostics(Warns)" })
  vim.keymap.set("n", "<leader>xe", diagnostics_workspace_errors, { desc = "Workspace Diagnostics(Errors)" })
end

local keymap_setup = function()
  vim.keymap.set("n", "<leader>cl", ":checkhealth vim.lsp<cr>", { desc = "LspInfo" })

  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, { desc = "Hover", silent = true })
  vim.keymap.set("n", "gk", function()
    vim.lsp.buf.signature_help()
  end, { desc = "Signature Help" })

  vim.keymap.set({ "n", "v", "x" }, "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, { desc = "Code Action" })
  --
  vim.keymap.set({ "n", "v" }, "<leader>cc", function()
    vim.lsp.codelens.run()
  end, { desc = "Codelens" })

  vim.keymap.set("n", "<leader>cr", function()
    vim.lsp.buf.rename()
  end, { desc = "Rename" })
  vim.keymap.set("n", "<leader>cR", function()
    local snacks = require("snacks")
    if snacks and snacks.rename and snacks.rename.rename_file then
      return snacks.rename.rename_file()
    end
    vim.notify("Snacks rename is unavailable", vim.log.levels.WARN)
  end, { desc = "Snacks Rename" })

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

-- enable lsp servers
vim.lsp.enable(enabled_servers)

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

    keymap_setup()
    lsp_keymaps({ buffer = args.buf, nowait = true })
    methods_setup(client, args.buf)
  end,
})
