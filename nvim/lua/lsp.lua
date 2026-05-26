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

local lsp_enabled = false
local missing_lsp_configs = {}
local replay_lsp_filetype_scheduled = false
local go_env_checked = false

local function notify_missing_configs()
  local missing = vim.tbl_keys(missing_lsp_configs)
  table.sort(missing)
  if #missing == 0 then
    return
  end

  vim.notify(("Missing LSP configs: %s"):format(table.concat(missing, ", ")), vim.log.levels.ERROR)
end

local function schedule_lsp_filetype_replay()
  if replay_lsp_filetype_scheduled then
    return
  end

  replay_lsp_filetype_scheduled = true
  vim.schedule(function()
    replay_lsp_filetype_scheduled = false
    if lsp_enabled then
      vim.cmd.doautoall("nvim.lsp.enable FileType")
    end
  end)
end

local function configure_completion_capabilities()
  if type(_G.__setup_blink_lsp_capabilities) == "function" then
    _G.__setup_blink_lsp_capabilities()
  end
end

local function normalize_go_env()
  if go_env_checked or vim.fn.executable("go") == 0 or not vim.env.GOROOT or vim.env.GOROOT == "" then
    go_env_checked = true
    return
  end

  go_env_checked = true
  local result = vim.system({ "env", "-u", "GOROOT", "go", "env", "GOROOT" }, { text = true }):wait()
  local detected_goroot = result.code == 0 and vim.trim(result.stdout) or ""
  if detected_goroot ~= "" and detected_goroot ~= vim.env.GOROOT then
    vim.env.GOROOT = detected_goroot
  end
end

local function prepare_buffer_lsp(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "" then
    return false
  end

  local filetype = vim.bo[bufnr].filetype
  if filetype == "go" or filetype == "gomod" or filetype == "gosum" or filetype == "gowork" or filetype == "gotmpl" then
    normalize_go_env()
  end

  return true
end

local function prepend_path(path)
  local separator = package.config:sub(1, 1) == "\\" and ";" or ":"
  local current_path = vim.env.PATH or ""
  local paths = vim.split(current_path, separator, { plain = true })

  if not vim.tbl_contains(paths, path) then
    vim.env.PATH = path .. separator .. current_path
  end
end

local function configure_lsp_prerequisites()
  prepend_path(vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin"))

  if type(_G.__setup_lazydev) == "function" then
    _G.__setup_lazydev()
  end
end

local function enable_lsp()
  if lsp_enabled then
    return
  end

  configure_lsp_prerequisites()
  configure_completion_capabilities()
  require("lazy").load({ plugins = { "nvim-lspconfig" }, wait = true })

  local found_missing_config = false
  local servers_to_enable = {}
  for _, server in ipairs(enabled_servers) do
    if vim.lsp.config[server] == nil then
      missing_lsp_configs[server] = true
      found_missing_config = true
    else
      servers_to_enable[#servers_to_enable + 1] = server
    end
  end

  if found_missing_config then
    vim.schedule(notify_missing_configs)
  end

  if #servers_to_enable > 0 then
    vim.lsp.enable(servers_to_enable)
    lsp_enabled = true
    schedule_lsp_filetype_replay()
  end
end

local snacks_cache = nil
local fzf_cache = nil

local function get_snacks()
  if snacks_cache == nil then
    local ok, mod = pcall(require, "snacks")
    snacks_cache = ok and mod or false
  end
  return snacks_cache ~= false and snacks_cache or nil
end

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
  local fzf_method_name = fzf_name or snacks_name

  return function()
    if vim.g.picker == "fzf" then
      local fzf = get_fzf()
      local fzf_method = fzf and fzf[fzf_method_name]
      if fzf_method then
        return fzf_method(fzf_opts)
      end
    end

    local snacks = get_snacks()
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

local function lsp_navigation_keymaps(opts)
  vim.keymap.set("n", "gd", lsp_definitions, vim.tbl_extend("force", opts, { desc = "Goto Definition" }))
  vim.keymap.set("n", "gD", lsp_declarations, vim.tbl_extend("force", opts, { desc = "Goto Declaration" }))
  vim.keymap.set("n", "gr", lsp_references, vim.tbl_extend("force", opts, { desc = "Goto References" }))
  vim.keymap.set("n", "gi", lsp_implementations, vim.tbl_extend("force", opts, { desc = "Goto Implementation" }))
  vim.keymap.set("n", "gy", lsp_type_definitions, vim.tbl_extend("force", opts, { desc = "Goto TypeDefs" }))
  vim.keymap.set("n", "gI", lsp_incoming_calls, vim.tbl_extend("force", opts, { desc = "Incoming Calls" }))
  vim.keymap.set("n", "gO", lsp_outgoing_calls, vim.tbl_extend("force", opts, { desc = "Outgoing Calls" }))
end

local keymap_setup = function()
  if vim.g.lsp_keymaps_ready then
    return
  end
  vim.g.lsp_keymaps_ready = true

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
    local snacks = get_snacks()
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

  lsp_navigation_keymaps({})

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

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "FileType" }, {
  group = vim.api.nvim_create_augroup("LspAttachReplay", { clear = true }),
  callback = function(args)
    if not prepare_buffer_lsp(args.buf) then
      return
    end

    if not lsp_enabled then
      enable_lsp()
    else
      schedule_lsp_filetype_replay()
    end
  end,
})

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

    lsp_navigation_keymaps({ buffer = args.buf, nowait = true })
    methods_setup(client, args.buf)
  end,
})
