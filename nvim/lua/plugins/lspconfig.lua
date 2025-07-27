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
    local icons = require("core.icons")
    vim.diagnostic.config({
      underline = true,
      update_in_insert = false,
      virtual_text = false,
      virtual_lines = false,
      float = {
        border = "rounded",
        spacing = 4,
        source = "if_many",
        prefix = "● ",
      },
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
          [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
          [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
        },
      },
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    vim.tbl_deep_extend("keep", capabilities, {
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
      vim.tbl_deep_extend("keep", capabilities, require("blink.cmp").get_lsp_capabilities(capabilities, true))

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.lsp.enable({
      "lua_ls",
      "bashls",

      "dockerls",
      "docker_compose_language_service",

      "html",
      "cssls",
      "biome",
      "eslint",
      "tailwindcss",
      "vtsls",
      "vuels",
      "emmet_ls",
      "emmet_language_server",

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
      callback = function(args)
        local buffer = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- keymaps
        vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "LspInfo" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
        vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, { desc = "Signature Help" })
        vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

        -- vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
        --
        vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Codelens" })
        vim.keymap.set({ "n", "v" }, "<leader>cC", vim.lsp.codelens.refresh, { desc = "Codelens Refresh" })
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
        vim.keymap.set("n", "<leader>cR", Snacks.rename.rename_file, { desc = "Snacks Rename" })
        vim.keymap.set({ "n", "v" }, "<leader>cf", function()
          vim.lsp.buf.format({
            async = true,
            range = { ["start"] = vim.api.nvim_buf_get_mark(0, "<"), ["end"] = vim.api.nvim_buf_get_mark(0, ">") },
          })
        end, { desc = "Lsp format", silent = true, remap = false })
        -- Diagnostic keymaps
        local diagnostic_goto = function(count, severity)
          local opts = { count = count, severity = severity and vim.diagnostic.severity[severity] or nil }
          return function()
            vim.diagnostic.jump(opts)
          end
        end
        -- stylua: ignore start
        vim.keymap.set("n", "<leader>xd", "<cmd>OpenFloatDiagnostic<cr>", { desc = "Diagnostic" })
        vim.keymap.set("n", "]d", diagnostic_goto(1), { desc = "Next diagnostic" })
        vim.keymap.set("n", "[d", diagnostic_goto(-1), { desc = "Prev diagnostic" })
        vim.keymap.set("n", "]e", diagnostic_goto(1, "ERROR"), { desc = "Next error" })
        vim.keymap.set("n", "[e", diagnostic_goto(-1, "ERROR"), { desc = "Prev error" })
        vim.keymap.set("n", "]w", diagnostic_goto(1, "WARN"), { desc = "Next warning" })
        vim.keymap.set("n", "[w", diagnostic_goto(-1, "WARN"), { desc = "Prev warning" })

        vim.keymap.set("n", "gd", Snacks.picker.lsp_definitions, { desc = "Goto Definition" })
        vim.keymap.set("n", "gD", Snacks.picker.lsp_declarations, { desc = "Goto Declaration" })
        vim.keymap.set("n", "gr", Snacks.picker.lsp_references, { desc = "Goto References" })
        vim.keymap.set("n", "gi", Snacks.picker.lsp_implementations, { desc = "Goto Implementation" })
        vim.keymap.set("n", "gy", Snacks.picker.lsp_type_definitions, { desc = "Goto TypeDefs" })

        vim.keymap.set("n", "gI", function() require("fzf-lua").lsp_incoming_calls() end, { desc = "Incoming Calls" })
        vim.keymap.set("n", "gO", function() require("fzf-lua").lsp_outgoing_calls() end, { desc = "Outgoing Calls" })

        vim.keymap.set("n", "<leader>ss", Snacks.picker.lsp_symbols, { desc = "Document symbols" })
        vim.keymap.set("n", "<leader>sS", Snacks.picker.lsp_workspace_symbols, { desc = "Workspace symbols" })

        vim.keymap.set("n", "<leader>xx", function() require("fzf-lua").diagnostics_document() end, { desc = "Document Diagnostics" })
        vim.keymap.set("n", "<leader>xw", function() require("fzf-lua").diagnostics_workspace() end, { desc = "Workspace Diagnostics" })

        vim.keymap.set("n", "<leader>ca", function()
          require("fzf-lua").lsp_code_actions({ winopts = { height = 0.33, width = 0.33, relative = "cursor" } })
        end, { desc = "Code Actions" })

        if client then
          if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          end

          -- if client:supports_method("textDocument/codeLens") then
          --   vim.lsp.codelens.refresh()
          --   -- vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          --   --   buffer = buffer,
          --   --   callback = vim.lsp.codelens.refresh,
          --   -- })
          -- end
          --
          if client:supports_method("textDocument/documentColor") then
            vim.lsp.document_color.enable(true, buffer)
          end
          if client.name == "eslint" then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = buffer,
              group = vim.api.nvim_create_augroup("eslintFix", { clear = true }),
              callback = function()
                if vim.fn.exists(":LspEslintFixAll") > 0 then
                  print("EslintFixAll")
                  vim.cmd("LspEslintFixAll")
                end
              end,
            })
          end
        end
      end,
    })
  end,
}
