local icons = require("core.icons")
return {
  {
    "Saghen/blink.cmp",
    dependencies = {
      { "L3MON4D3/LuaSnip", version = "v2.*" },
      "xzbdmw/colorful-menu.nvim",
      "onsails/lspkind.nvim",
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "BufReadPost",
        opts = {
          suggestion = {
            enabled = false,
            auto_trigger = true,
            hide_during_completion = true,
            keymap = {
              accept = false,
              next = "<M-]>",
              prev = "<M-[>",
            },
          },
          panel = { enabled = false },
          filetypes = {
            markdown = true,
            help = true,
          },
        },
      },
      "giuxtaposition/blink-cmp-copilot",
    },
    build = "cargo build --release",
    event = "InsertEnter",
    opts = function()
      return {
        fuzzy = { implementation = "prefer_rust" },
        keymap = {
          preset = "enter",
        },
        appearance = {
          kind_icons = icons.symbol_map,
          use_nvim_cmp_as_default = false,
          nerd_font_variant = "mono",
        },
        signature = {
          enabled = true,
          window = {
            show_documentation = true,
          },
        },
        completion = {
          ghost_text = {
            enabled = true,
          },
          documentation = {
            auto_show = true,
          },
          accept = {
            auto_brackets = {
              enabled = true,
            },
          },
          menu = {
            scrollbar = false,
            draw = {
              columns = { { "kind_icon" }, { "label", gap = 1 }, { "kind", "source_name", gap = 1 } },
              components = {
                label = {
                  -- width = { fill = true, max = 40 },
                  text = function(ctx)
                    return require("colorful-menu").blink_components_text(ctx)
                  end,
                  highlight = function(ctx)
                    return require("colorful-menu").blink_components_highlight(ctx)
                  end,
                },
                kind_icon = {
                  text = function(item)
                    local kind = require("lspkind").symbol_map[item.kind] or ""
                    return kind .. ""
                  end,
                },
                source_name = {
                  text = function(ctx)
                    return "[" .. ctx.source_name .. "]"
                  end,
                  highlight = function()
                    return "Comment"
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
            list = {
              selection = {
                preselect = false,
                auto_insert = false,
              },
            },
            menu = {
              auto_show = true,
            },
          },
        },
        snippets = { preset = "luasnip" },
        sources = {
          default = { "lsp", "path", "snippets", "buffer", "copilot" },
          providers = {
            copilot = {
              name = "copilot",
              module = "blink-cmp-copilot",
              score_offset = 100,
              async = true,
            },
          },
          per_filetype = {
            text = { "dictionary" },
            markdown = { "thesaurus" },
          },
        },
      }
    end,
    config = function(_, opts)
      require("lspkind").init({
        mode = "symbol_text",
        preset = "codicons",
        symbol_map = icons.symbol_map,
      })

      require("blink.cmp").setup(opts)
    end,
  },
}
