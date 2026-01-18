return {
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    lazy = true,
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local ls = require("luasnip")
      ls.config.set_config({
        enable_autosnippets = true,
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })
      ls.filetype_extend("typescript", { "javascript" })
      ls.filetype_extend("javascriptreact", { "javascript" })
      ls.filetype_extend("typescriptreact", { "javascript" })
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load({ paths = { "./snippets" } })
    end,
  },
  {
    "Saghen/blink.cmp",
    dependencies = {
      { "L3MON4D3/LuaSnip" },
      { "fang2hou/blink-copilot" },
      { "folke/lazydev.nvim" },
      {
        "onsails/lspkind.nvim",
        config = function()
          require("lspkind").init({
            preset = "codicons",
          })
        end,
      },
      { "xzbdmw/colorful-menu.nvim", opts = { max_width = 40 } },
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
        snippets = { preset = "luasnip" },
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
              border = vim.g.bordered and "rounded" or "none",
              max_height = 20,
              max_width = 40,
            },
          },
          accept = { auto_brackets = { enabled = true } },
          list = { selection = { preselect = true, auto_insert = true } },
          menu = {
            scrollbar = false,
            border = vim.g.bordered and "rounded" or "none",
            draw = {
              gap = 2,
              columns = {
                { "label", gap = 1 },
                { "kind_icon", "kind", gap = 1 },
                { "source_name", gap = 2 },
              },
              -- treesitter = { "lsp" },
              components = {
                label = {
                  text = function(ctx)
                    return require("colorful-menu").blink_components_text(ctx)
                  end,
                  highlight = function(ctx)
                    return require("colorful-menu").blink_components_highlight(ctx)
                  end,
                },
                kind_icon = {
                  text = function(ctx)
                    if ctx.source_name ~= "Path" then
                      return (require("lspkind").symbol_map[ctx.kind] or "") .. ctx.icon_gap
                    end

                    local is_unknown_type =
                      vim.tbl_contains({ "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
                    local mini_icon, _ = require("mini.icons").get(
                      is_unknown_type and "os" or ctx.item.data.type,
                      is_unknown_type and "" or ctx.label
                    )

                    return (mini_icon or ctx.kind_icon) .. ctx.icon_gap
                  end,

                  highlight = function(ctx)
                    if ctx.source_name ~= "Path" then
                      return ctx.kind_hl
                    end

                    local is_unknown_type =
                      vim.tbl_contains({ "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
                    local mini_icon, mini_hl = require("mini.icons").get(
                      is_unknown_type and "os" or ctx.item.data.type,
                      is_unknown_type and "" or ctx.label
                    )
                    return mini_icon ~= nil and mini_hl or ctx.kind_hl
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
            buffer = {
              opts = {
                get_bufnrs = function()
                  return vim.tbl_filter(function(bufnr)
                    return vim.bo[bufnr].buftype == ""
                  end, vim.api.nvim_list_bufs())
                end,
              },
            },
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
