local loader = require("loader")
local ui = require("ui")

-- Only completion capabilities are needed eagerly. Server configs are resolved
-- from this config's lsp/ directory by vim.lsp.enable().
loader.packadd("blink.lib", "blink.cmp")

-- nvim-highlight-colors owns color swatches, including buffers without an LSP.
vim.lsp.document_color.enable(false)

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

local capabilities = require("blink.cmp").get_lsp_capabilities({
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
}, true)

vim.lsp.config("*", {
  capabilities = capabilities,
})

local function lsp_keymaps(bufnr)
  local function picker(method, options)
    return function()
      loader.packadd("fzf-lua")
      require("fzf-lua")[method](options)
    end
  end

  local opts = function(desc)
    return { buffer = bufnr, desc = desc }
  end

  vim.keymap.set("n", "gd", picker("lsp_definitions"), opts("Goto Definition"))
  vim.keymap.set("n", "gD", picker("lsp_declarations"), opts("Goto Declaration"))
  vim.keymap.set("n", "gr", picker("lsp_references"), opts("Goto References"))
  vim.keymap.set("n", "gi", picker("lsp_implementations"), opts("Goto Implementation"))
  vim.keymap.set("n", "gy", picker("lsp_typedefs"), opts("Goto TypeDefs"))
  vim.keymap.set("n", "gI", picker("lsp_incoming_calls"), opts("Incoming Calls"))
  vim.keymap.set("n", "gO", picker("lsp_outgoing_calls"), opts("Outgoing Calls"))

  vim.keymap.set("n", "<leader>ca", picker("lsp_code_actions"), opts("Code Actions"))

  vim.keymap.set("n", "<leader>ss", picker("lsp_document_symbols"), opts("Lsp symbols"))
  vim.keymap.set("n", "<leader>sS", picker("lsp_workspace_symbols"), opts("Workspace lsp symbols"))

  vim.keymap.set("n", "<leader>xx", picker("diagnostics_document", { sort = true }), opts("Diagnostics"))
  vim.keymap.set("n", "<leader>xX", picker("diagnostics_workspace", { sort = true }), opts("Workspace Diagnostics"))
  vim.keymap.set(
    "n",
    "<leader>xw",
    picker("diagnostics_workspace", { severity_limit = vim.diagnostic.severity.WARN, sort = true }),
    opts("Workspace Diagnostics(Warns)")
  )
  vim.keymap.set(
    "n",
    "<leader>xe",
    picker("diagnostics_workspace", { severity_limit = vim.diagnostic.severity.ERROR, sort = true }),
    opts("Workspace Diagnostics(Errors)")
  )
end

local function float_options()
  return {
    max_height = math.floor(vim.o.lines * 0.5),
    max_width = math.floor(vim.o.columns * 0.6),
  }
end

local keymap_setup = function(bufnr)
  local opts = function(desc)
    return { buffer = bufnr, desc = desc }
  end

  vim.keymap.set("n", "<leader>cl", ":checkhealth vim.lsp<cr>", opts("LspInfo"))

  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover(float_options())
  end, opts("Hover"))

  vim.keymap.set("n", "gk", function()
    vim.lsp.buf.signature_help(float_options())
  end, opts("Signature Help"))

  vim.keymap.set({ "n", "v" }, "<leader>cc", function()
    vim.lsp.codelens.run()
  end, opts("Codelens"))

  vim.keymap.set("n", "<leader>cr", function()
    vim.lsp.buf.rename()
  end, opts("Rename"))

  -- Diagnostic keymaps
  local function diagnostic_goto(count, severity)
    local opts1 = { count = count, severity = severity and vim.diagnostic.severity[severity] }
    return function()
      vim.diagnostic.jump(opts1)
    end
  end

  vim.keymap.set("n", "]d", diagnostic_goto(1), opts("Next diagnostic"))
  vim.keymap.set("n", "[d", diagnostic_goto(-1), opts("Prev diagnostic"))
  vim.keymap.set("n", "]e", diagnostic_goto(1, "ERROR"), opts("Next error"))
  vim.keymap.set("n", "[e", diagnostic_goto(-1, "ERROR"), opts("Prev error"))
  vim.keymap.set("n", "]w", diagnostic_goto(1, "WARN"), opts("Next warning"))
  vim.keymap.set("n", "[w", diagnostic_goto(-1, "WARN"), opts("Prev warning"))
end

local methods_setup = function(client, bufnr)
  if client:supports_method("textDocument/inlayHint", bufnr) then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

-- enable lsp servers
vim.lsp.enable(enabled_servers)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("sjvim_lsp_attach", { clear = true }),
  callback = function(args)
    local client_id = args.data and args.data.client_id
    if not client_id then
      return
    end

    local client = vim.lsp.get_client_by_id(client_id)
    if not client then
      return
    end

    if not vim.b[args.buf].sjvim_lsp_keymaps then
      vim.b[args.buf].sjvim_lsp_keymaps = true
      keymap_setup(args.buf)
      lsp_keymaps(args.buf)
    end

    methods_setup(client, args.buf)
  end,
})
