local misc = require("utils.misc")
local ui = require("core.ui")

return {
  {
    "onsails/lspkind.nvim",
    config = function()
      require("lspkind").init({
        symbol_map = ui.icons.lspkind_kind_icons,
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    lazy = true,
    dependencies = { { "rafamadriz/friendly-snippets", lazy = true } },
    config = function()
      local ls = require("luasnip")
      ls.config.setup({
        enable_autosnippets = true,
        history = true,
        updateevents = "TextChanged,TextChangedI",
        delete_check_events = "TextChanged",
        region_check_events = "CursorMoved",
      })
      ls.filetype_extend("typescript", { "javascript" })
      ls.filetype_extend("javascriptreact", { "javascript" })
      ls.filetype_extend("typescriptreact", { "javascript" })

      vim.tbl_map(function(type)
        require("luasnip.loaders.from_" .. type).lazy_load()
      end, { "vscode", "snipmate", "lua" })
    end,
  },
  {
    "Saghen/blink.cmp",
    dependencies = {
      { "fang2hou/blink-copilot" },
      { "folke/lazydev.nvim" },
      { "folke/sidekick.nvim" },
    },
    build = "cargo build --release",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = function()
      return {
        enabled = function()
          return not vim.tbl_contains({ "bigfile" }, vim.bo.filetype)
        end,
        fuzzy = {
          implementation = "prefer_rust",
          sorts = {
            "exact",
            "score",
            "sort_text",
            "label",
          },
        },
        keymap = {
          ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<C-n>"] = { "select_next", "show" },
          ["<C-p>"] = { "select_prev", "show" },
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<C-u>"] = { "scroll_documentation_up", "fallback" },
          ["<C-d>"] = { "scroll_documentation_down", "fallback" },
          ["<C-e>"] = { "hide", "fallback" },
          ["<CR>"] = { "accept", "fallback" },
          ["<Tab>"] = {
            function()
              return require("sidekick").nes_jump_or_apply()
            end,
            "snippet_forward",
            "select_next",
            "fallback",
          },
          ["<S-Tab>"] = {
            "snippet_backward",
            "select_prev",
            "fallback",
          },
        },
        signature = {
          enabled = true,
          window = {
            show_documentation = true,
            border = "rounded",
          },
        },
        completion = {
          ghost_text = { enabled = true },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 100,
            window = {
              border = {
                { "", "DiagnosticHint" },
                "─",
                "╮",
                "│",
                "╯",
                "─",
                "╰",
                "│",
              },
              max_height = 20,
              max_width = 50,
            },
          },
          accept = { auto_brackets = { enabled = true } },
          list = { selection = { preselect = true, auto_insert = true } },
          menu = {
            scrollbar = false,
            border = {
              { "󱐋", "WarningMsg" },
              "─",
              "╮",
              "│",
              "╯",
              "─",
              "╰",
              "│",
            },
            draw = {
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "kind" },
              },
              treesitter = { "lsp" },
              components = {
                kind_icon = {
                  text = function(ctx)
                    local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                    return kind_icon
                  end,
                },
              },
            },
          },
        },
        cmdline = {
          enabled = true,
          keymap = {
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-n>"] = { "select_next", "show" },
            ["<C-p>"] = { "select_prev", "show" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<CR>"] = { "accept", "hide", "fallback" },
            ["<Tab>"] = {
              function()
                return require("sidekick").nes_jump_or_apply()
              end,
              "snippet_forward",
              "select_next",
              "fallback",
            },
          },
          completion = {
            ghost_text = { enabled = true },
            list = { selection = { preselect = false, auto_insert = true } },
            menu = {
              auto_show = function()
                return vim.fn.getcmdtype() == ":"
              end,
            },
          },
        },
        snippets = { preset = "luasnip" },
        sources = {
          default = { "lazydev", "lsp", "path", "snippets", "buffer", "copilot" },
          providers = {
            copilot = {
              name = "copilot",
              module = "blink-copilot",
              async = true,
              score_offset = 100,
              enabled = function()
                return vim.g.copilot_enabled
              end,
              opts = {
                max_completions = 3,
                max_items = 2,
                max_attempts = 4,
              },
            },
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      require("blink.cmp").setup(opts)

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
    end,
  },
}
