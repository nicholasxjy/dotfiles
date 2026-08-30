local loader = require("loader")
local ui = require("ui")

-- Only completion capabilities are needed eagerly. Server configs are resolved
-- from this config's lsp/ directory by vim.lsp.enable().
loader.packadd("blink.lib", "blink.cmp")

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

local minibuffer_win_opts = function()
  return {
    height = 0.3,
    width = 1,
    row = 0,
    col = 0.50,
    border = "none",
    backdrop = 100,
    relative = "minibuffer",
    use_minibuffer = true,
    winhl = true,
  }
end

local function lsp_keymaps(bufnr)
  loader.packadd("fzf-lua")
  local fzflua = require("fzf-lua")
  local with_minibuffer = function(fn, fzf_opts)
    return function()
      fn(vim.tbl_extend("force", fzf_opts or {}, { winopts = minibuffer_win_opts(), previewer = "hidden" }))
    end
  end

  local opts = function(desc)
    return { buffer = bufnr, desc = desc }
  end

  vim.keymap.set("n", "gd", with_minibuffer(fzflua.lsp_definitions), opts("Goto Definition"))
  vim.keymap.set("n", "gD", with_minibuffer(fzflua.lsp_declarations), opts("Goto Declaration"))
  vim.keymap.set("n", "gr", with_minibuffer(fzflua.lsp_references), opts("Goto References"))
  vim.keymap.set("n", "gi", with_minibuffer(fzflua.lsp_implementations), opts("Goto Implementation"))
  vim.keymap.set("n", "gy", with_minibuffer(fzflua.lsp_typedefs), opts("Goto TypeDefs"))
  vim.keymap.set("n", "gI", with_minibuffer(fzflua.lsp_incoming_calls), opts("Incoming Calls"))
  vim.keymap.set("n", "gO", with_minibuffer(fzflua.lsp_outgoing_calls), opts("Outgoing Calls"))

  vim.keymap.set("n", "<leader>ca", with_minibuffer(fzflua.lsp_code_actions, opts("Code Actions")))

  vim.keymap.set("n", "<leader>ss", with_minibuffer(fzflua.lsp_document_symbols), opts("Lsp symbols"))
  vim.keymap.set("n", "<leader>sS", with_minibuffer(fzflua.lsp_workspace_symbols), opts("Workspace lsp symbols"))

  vim.keymap.set("n", "<leader>xx", with_minibuffer(fzflua.diagnostics_document, { sort = true }), opts("Diagnostics"))
  vim.keymap.set(
    "n",
    "<leader>xX",
    with_minibuffer(fzflua.diagnostics_workspace, { sort = true }),
    opts("Workspace Diagnostics")
  )
  vim.keymap.set(
    "n",
    "<leader>xw",
    with_minibuffer(fzflua.diagnostics_workspace, { severity_limit = vim.diagnostic.severity.WARN, sort = true }),
    opts("Workspace Diagnostics(Warns)")
  )
  vim.keymap.set(
    "n",
    "<leader>xe",
    with_minibuffer(fzflua.diagnostics_workspace, { severity_limit = vim.diagnostic.severity.ERROR, sort = true }),
    opts("Workspace Diagnostics(Errors)")
  )
end

-- local hover = vim.lsp.buf.hover
-- ---@diagnostic disable-next-line: duplicate-set-field
-- vim.lsp.buf.hover = function()
--   return hover({
--     border = "none",
--   })
-- end

local signature_help = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
  return signature_help({
    max_height = math.floor(vim.o.lines * 0.5),
    max_width = math.floor(vim.o.columns * 0.6),
  })
end

local keymap_setup = function(bufnr)
  local opts = function(desc)
    return { buffer = bufnr, desc = desc }
  end

  vim.keymap.set("n", "<leader>cl", ":checkhealth vim.lsp<cr>", opts("LspInfo"))

  -- Nvim installs buffer-local `K` for hover-capable clients. Its callback
  -- resolves the patched `vim.lsp.buf.hover` above when invoked.
  vim.keymap.set("n", "gk", function()
    vim.lsp.buf.signature_help()
  end, opts("Signature Help"))

  -- vim.keymap.set({ "n", "x" }, "<leader>ca", function()
  --   vim.lsp.buf.code_action()
  -- end, opts("Code Action"))

  vim.keymap.set({ "n", "v" }, "<leader>cc", function()
    vim.lsp.codelens.run()
  end, opts("Codelens"))

  vim.keymap.set("n", "<leader>cr", function()
    vim.lsp.buf.rename()
  end, opts("Rename"))
  vim.keymap.set("n", "<leader>cR", function()
    local snacks = require("snacks")
    if snacks and snacks.rename and snacks.rename.rename_file then
      return snacks.rename.rename_file()
    end
    vim.notify("Snacks rename is unavailable", vim.log.levels.WARN)
  end, opts("Snacks Rename"))

  -- Diagnostic keymaps
  local function diagnostic_goto(count, severity)
    local opts = { count = count, severity = severity and vim.diagnostic.severity[severity] }
    return function()
      vim.diagnostic.jump(opts)
    end
  end

  vim.keymap.set("n", "]d", diagnostic_goto(1), opts("Next diagnostic"))
  vim.keymap.set("n", "[d", diagnostic_goto(-1), opts("Prev diagnostic"))
  vim.keymap.set("n", "]e", diagnostic_goto(1, "ERROR"), opts("Next error"))
  vim.keymap.set("n", "[e", diagnostic_goto(-1, "ERROR"), opts("Prev error"))
  vim.keymap.set("n", "]w", diagnostic_goto(1, "WARN"), opts("Next warning"))
  vim.keymap.set("n", "[w", diagnostic_goto(-1, "WARN"), opts("Prev warning"))
end

-- Keep formatting/tag edits single-owner: Conform and nvim-ts-autotag handle them.
local methods_setup = function(client, bufnr)
  if vim.lsp.inlay_hint and client:supports_method("textDocument/inlayHint", { bufnr = bufnr }) then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
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

    if not vim.b[args.buf].sjvim_lsp_keymaps then
      vim.b[args.buf].sjvim_lsp_keymaps = true
      keymap_setup(args.buf)
      lsp_keymaps(args.buf)
    end

    methods_setup(client, args.buf)
  end,
})
