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
  -- "copilot",
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

local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
  workspace = {
    fileOperations = {
      didRename = true,
      willRename = true,
    },
  },
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
})

capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

vim.lsp.config("*", {
  capabilities = capabilities,
})

local keymap_setup = function(bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
  end

  map("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", "LspInfo")

  map("n", "K", function()
    vim.lsp.buf.hover()
  end, "Hover")
  map("n", "gk", function()
    vim.lsp.buf.signature_help()
  end, "Signature Help")

  map({ "n", "v", "x" }, "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, "Code Action")

  map({ "n", "v" }, "<leader>cc", function()
    vim.lsp.codelens.run()
  end, "Codelens")

  map("n", "<leader>cr", function()
    vim.lsp.buf.rename()
  end, "Rename")
  map("n", "<leader>cR", function()
    local snacks = require("snacks")
    if snacks and snacks.rename and snacks.rename.rename_file then
      return snacks.rename.rename_file()
    end
    vim.notify("Snacks rename is unavailable", vim.log.levels.WARN)
  end, "Snacks Rename")

  -- Diagnostic keymaps
  local function diagnostic_goto(count, severity)
    local opts = { count = count, severity = severity and vim.diagnostic.severity[severity] }
    return function()
      vim.diagnostic.jump(opts)
    end
  end

  map("n", "]d", diagnostic_goto(1), "Next Diagnostic")
  map("n", "[d", diagnostic_goto(-1), "Previous Diagnostic")
  map("n", "]e", diagnostic_goto(1, "ERROR"), "Next Error")
  map("n", "[e", diagnostic_goto(-1, "ERROR"), "Previous Error")
  map("n", "]w", diagnostic_goto(1, "WARN"), "Next Warning")
  map("n", "[w", diagnostic_goto(-1, "WARN"), "Previous Warning")
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

    keymap_setup(args.buf)
    methods_setup(client, args.buf)
  end,
})
