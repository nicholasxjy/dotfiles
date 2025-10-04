local ui = require("core.ui")

return {
  "neovim/nvim-lspconfig",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    vim.diagnostic.config({
      underline = true,
      update_in_insert = false,
      virtual_text = false,
      virtual_lines = false,
      float = {
        border = vim.g.bordered and "rounded" or "none",
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

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    vim.tbl_deep_extend("force", capabilities, {
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
    capabilities =
      vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities(capabilities, true))

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.lsp.enable({
      "lua_ls",
      -- "emmylua_ls",
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

    --- This file sets up the LSP client, key mappings, and autocommands for LSP features.
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if not client then
          return
        end

        -- keymaps

        vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "LspInfo" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", silent = true })

        vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, { desc = "Signature Help" })
        vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

        vim.keymap.set({ "n", "v", "x" }, "<leader>ca", function()
          vim.lsp.buf.code_action()
        end, { desc = "Code Action", silent = true })
        --
        vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Codelens" })
        vim.keymap.set({ "n", "v" }, "<leader>cC", vim.lsp.codelens.refresh, { desc = "Codelens Refresh" })

        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
        vim.keymap.set("n", "<leader>cR", Snacks.rename.rename_file, { desc = "Snacks Rename" })
        -- Diagnostic keymaps
        local diagnostic_goto = function(count, severity)
          local opts = { count = count, severity = severity and vim.diagnostic.severity[severity] or nil }
          return function()
            vim.diagnostic.jump(opts)
          end
        end

        vim.keymap.set("n", "<leader>xd", "<cmd>OpenFloatDiagnostic<cr>", { desc = "Diagnostic" })
        vim.keymap.set("n", "]d", diagnostic_goto(1), { desc = "Next diagnostic" })
        vim.keymap.set("n", "[d", diagnostic_goto(-1), { desc = "Prev diagnostic" })
        vim.keymap.set("n", "]e", diagnostic_goto(1, "ERROR"), { desc = "Next error" })
        vim.keymap.set("n", "[e", diagnostic_goto(-1, "ERROR"), { desc = "Prev error" })
        vim.keymap.set("n", "]w", diagnostic_goto(1, "WARN"), { desc = "Next warning" })
        vim.keymap.set("n", "[w", diagnostic_goto(-1, "WARN"), { desc = "Prev warning" })

        vim.keymap.set("n", "gd", function()
          require("fzf-lua").lsp_definitions()
        end, { desc = "Goto Definition" })
        vim.keymap.set("n", "gD", function()
          require("fzf-lua").lsp_declarations()
        end, { desc = "Goto Declaration" })
        vim.keymap.set("n", "gr", function()
          require("fzf-lua").lsp_references()
        end, { nowait = true, desc = "Goto References" })
        vim.keymap.set("n", "gi", function()
          require("fzf-lua").lsp_implementations()
        end, { desc = "Goto Implementation" })
        vim.keymap.set("n", "gy", function()
          require("fzf-lua").lsp_typedefs()
        end, { desc = "Goto TypeDefs" })
        vim.keymap.set("n", "gI", function()
          require("fzf-lua").lsp_incoming_calls()
        end, { desc = "Incoming Calls" })
        vim.keymap.set("n", "gO", function()
          require("fzf-lua").lsp_outgoing_calls()
        end, { desc = "Outgoing Calls" })

        vim.keymap.set("n", "<leader>ss", function()
          Snacks.picker.lsp_symbols()
        end, { desc = "Document symbols" })
        vim.keymap.set("n", "<leader>sS", function()
          Snacks.picker.lsp_workspace_symbols()
        end, { desc = "Workspace symbols" })

        vim.keymap.set("n", "<leader>xx", function()
          require("fzf-lua").diagnostics_document()
        end, { desc = "Document Diagnostics" })

        vim.keymap.set("n", "<leader>xw", function()
          require("fzf-lua").diagnostics_workspace()
        end, { desc = "Workspace Diagnostics" })

        vim.keymap.set("n", "<leader>xe", function()
          require("fzf-lua").diagnostics_workspace({
            severity_limit = vim.diagnostic.severity.WARN,
          })
        end, { desc = "Workspace Diagnostics(Errors)" })

        vim.keymap.set("n", "<leader>ff", function()
          require("fzf-lua").lsp_finder()
        end, { desc = "Fzf finder" })

        vim.lsp.document_color.enable(true, bufnr, { style = "virtual" })

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHints) then
          local inlay_hints_group = vim.api.nvim_create_augroup("xue/toggle_inlay_hints", { clear = false })
          if vim.g.inlay_hints then
            -- Initial inlay hint display.
            -- Idk why but without the delay inlay hints aren't displayed at the very start.
            vim.defer_fn(function()
              local mode = vim.api.nvim_get_mode().mode
              vim.lsp.inlay_hint.enable(mode == "n" or mode == "v", { bufnr = bufnr })
            end, 500)
          end

          vim.api.nvim_create_autocmd("InsertEnter", {
            group = inlay_hints_group,
            desc = "Enable inlay hints",
            buffer = bufnr,
            callback = function()
              if vim.g.inlay_hints then
                vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
              end
            end,
          })

          vim.api.nvim_create_autocmd("InsertLeave", {
            group = inlay_hints_group,
            desc = "Disable inlay hints",
            buffer = bufnr,
            callback = function()
              if vim.g.inlay_hints then
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
              end
            end,
          })
        end

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local under_cursor_highlights_group = vim.api.nvim_create_augroup("xue/cursor_highlights", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
            group = under_cursor_highlights_group,
            desc = "Highlight references under the cursor",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
            group = under_cursor_highlights_group,
            desc = "Clear highlight references",
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end
        -- vim.lsp.linked_editing_range.enable()
        -- vim.lsp.on_type_formatting.enable()

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
      end,
    })
  end,
}
