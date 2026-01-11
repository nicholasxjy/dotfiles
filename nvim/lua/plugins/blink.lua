local cmpUtil = require("utils.cmp")
local ui = require("core.ui")

return {
  {
    "Saghen/blink.cmp",
    dependencies = {
      { "rafamadriz/friendly-snippets" },
      { "fang2hou/blink-copilot" },
      { "folke/lazydev.nvim" },
      {
        "onsails/lspkind.nvim",
        config = function()
          require("lspkind").init({
            symbol_map = ui.icons.codicons,
          })
        end,
      },
    },
    build = "cargo build --release",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = function()
      return {
        enabled = function()
          return not vim.tbl_contains(
            { "bigfile", "grug-far", "snacks_picker", "snacks_picker_input", "fyler", "minifiles" },
            vim.bo.filetype
          ) and vim.b.completion ~= false and vim.bo.buftype ~= "prompt"
        end,
        fuzzy = {
          implementation = "prefer_rust",
        },
        keymap = {
          preset = "enter",
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<C-u>"] = { "scroll_documentation_up", "fallback" },
          ["<C-d>"] = { "scroll_documentation_down", "fallback" },
          ["<Tab>"] = {
            -- nes
            function() -- sidekick next edit suggestion
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
            border = vim.g.bordered and "rounded" or "none",
          },
        },
        completion = {
          ghost_text = { enabled = true },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 100,
            window = {
              border = vim.g.bordered and {
                { "", "DiagnosticHint" },
                "─",
                "╮",
                "│",
                "╯",
                "─",
                "╰",
                "│",
              } or "none",
              max_height = 20,
              max_width = 40,
            },
          },
          accept = { auto_brackets = { enabled = true } },
          list = { selection = { preselect = true, auto_insert = true } },
          menu = {
            scrollbar = false,
            border = vim.g.bordered and {
              { "󱐋", "WarningMsg" },
              "─",
              "╮",
              "│",
              "╯",
              "─",
              "╰",
              "│",
            } or "none",
            draw = {
              gap = 2,
              columns = {
                { "kind_icon", "label", gap = 1 },
                { "kind", "source_name", gap = 2 },
              },
              treesitter = { "lsp" },
              components = {
                kind_icon = {
                  text = function(ctx)
                    return cmpUtil.get_kind_icon(ctx).text
                  end,
                  highlight = function(ctx)
                    return cmpUtil.get_kind_icon(ctx).highlight
                  end,
                },
                kind = {
                  text = function(ctx)
                    return ctx.kind
                  end,
                  highlight = function(ctx)
                    return cmpUtil.get_kind_icon(ctx).highlight
                  end,
                },
                source_name = {
                  text = function(ctx)
                    if ctx.source_name == "LSP" then
                      return "[LSP]"
                    end
                    if ctx.source_name == "Snippets" then
                      return "[SNIP]"
                    end
                    if ctx.source_name == "Buffer" then
                      return "[BUF]"
                    end
                    if ctx.source_name == "Path" then
                      return "[PATH]"
                    end
                  end,
                  highlight = function()
                    return "BlinkCmpSource"
                  end,
                },
              },
            },
          },
        },
        cmdline = {
          enabled = true,
          keymap = {
            preset = "cmdline",
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
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
        sources = {
          default = { "lazydev", "snippets", "lsp", "path", "buffer", "copilot" },
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
    end,
  },
}
