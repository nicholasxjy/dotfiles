local icons = require("core.icons")

return {
  {
    "saghen/blink.cmp",
    dependencies = {
      { "L3MON4D3/LuaSnip", version = "v2.*" },
      "giuxtaposition/blink-cmp-copilot",
      "saghen/blink.compat",
      "Exafunction/codeium.nvim",
      {
        "xzbdmw/colorful-menu.nvim",
        config = function()
          require("colorful-menu").setup()
        end,
      },
    },
    build = "cargo build --release",
    event = "InsertEnter",
    opts = function()
      return {
        keymap = {
          preset = "enter",
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<C-j>"] = { "select_next", "fallback" },
        },
        appearance = {
          kind_icons = icons.kind_icons,
          use_nvim_cmp_as_default = false,
          nerd_font_variant = "mono",
        },
        signature = {
          enabled = true,
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
          },
        },
        completion = {
          ghost_text = {
            enabled = true,
          },
          documentation = {
            auto_show = true,
            -- window = {
            --   border = {
            --     { "", "DiagnosticHint" },
            --     "─",
            --     "╮",
            --     "│",
            --     "╯",
            --     "─",
            --     "╰",
            --     "│",
            --   },
            -- },
          },
          accept = {
            auto_brackets = {
              enabled = true,
              default_brackets = { "(", ")", "{", "}", "[", "]" },
            },
          },
          menu = {
            scrollbar = false,
            -- border = {
            --   { "󱐋", "WarningMsg" },
            --   "─",
            --   "╮",
            --   "│",
            --   "╯",
            --   "─",
            --   "╰",
            --   "│",
            -- },
            draw = {
              -- treesitter = { "lsp" },
              -- We don't need label_description now because label and label_description are already
              -- combined together in label by colorful-menu.nvim.
              columns = { { "kind_icon" }, { "label", gap = 1 } },
              components = {
                label = {
                  text = function(ctx)
                    return require("colorful-menu").blink_components_text(ctx)
                  end,
                  highlight = function(ctx)
                    return require("colorful-menu").blink_components_highlight(ctx)
                  end,
                },
              },
            },
          },
        },
        cmdline = {
          enabled = true,
          keymap = {
            preset = "enter",
          },
          completion = {
            ghost_text = { enabled = true },
            menu = {
              auto_show = true,
            },
          },
        },
        snippets = { preset = "luasnip" },
        sources = {
          default = { "lsp", "path", "snippets", "buffer", "copilot", "codeium" },
          providers = {
            copilot = {
              name = "copilot",
              module = "blink-cmp-copilot",
              score_offset = 100,
              max_items = 1,
              async = true,
              transform_items = function(_, items)
                local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                local kind_idx = #CompletionItemKind + 1
                CompletionItemKind[kind_idx] = "Copilot"
                for _, item in ipairs(items) do
                  item.kind = kind_idx
                end
                return items
              end,
            },
            codeium = {
              name = "codeium",
              module = "blink.compat.source",
              score_offset = 100,
              max_items = 1,
              async = true,
              transform_items = function(_, items)
                local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                local kind_idx = #CompletionItemKind + 1
                CompletionItemKind[kind_idx] = "Codeium"
                for _, item in ipairs(items) do
                  item.kind = kind_idx
                end
                return items
              end,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      require("blink.cmp").setup(opts)
    end,
  },
}
