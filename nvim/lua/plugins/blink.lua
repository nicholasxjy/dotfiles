local icons = require("core.icons")

return {
  {
    "Saghen/blink.cmp",
    dependencies = {
      { "L3MON4D3/LuaSnip", version = "v2.*" },
      "xzbdmw/colorful-menu.nvim",
      {
        "Exafunction/windsurf.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        config = function()
          require("codeium").setup({
            enable_cmp_source = false,
          })
        end,
      },
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
              accept = false, -- handled by nvim-cmp / blink.cmp
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
        keymap = { preset = "enter" },
        appearance = { kind_icons = icons.symbol_map, use_nvim_cmp_as_default = false, nerd_font_variant = "mono" },
        signature = { enabled = true, window = { show_documentation = true } },
        completion = {
          ghost_text = { enabled = true },
          documentation = { auto_show = true },
          accept = { auto_brackets = { enabled = true } },
          menu = {
            scrollbar = false,
            draw = {
              columns = { { "kind_icon" }, { "label", gap = 1 }, { "kind", "source_name", gap = 1 } },
              components = {
                label = {
                  width = { fill = true, max = 40 },
                  text = function(ctx)
                    return require("colorful-menu").blink_components_text(ctx)
                  end,
                  highlight = function(ctx)
                    return require("colorful-menu").blink_components_highlight(ctx)
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
          keymap = { preset = "enter" },
          completion = {
            ghost_text = { enabled = true },
            list = { selection = { preselect = false, auto_insert = false } },
            menu = { auto_show = true },
          },
        },
        snippets = { preset = "luasnip" },
        sources = {
          default = { "lsp", "path", "snippets", "buffer", "copilot" },
          providers = {
            codeium = { name = "Codeium", module = "codeium.blink", async = true },
            copilot = { name = "copilot", module = "blink-cmp-copilot", async = true },
          },
        },
      }
    end,
    config = function(_, opts)
      require("blink.cmp").setup(opts)
    end,
  },
  {
    "saghen/blink.pairs",
    event = { "BufReadPre", "BufNewFile" },
    build = "cargo build --release",
    opts = {
      highlights = {
        enabled = true,
        groups = {
          "BlinkPairsRed",
          "BlinkPairsOrange",
          "BlinkPairsYellow",
          "BlinkPairsGreen",
          "BlinkPairsCyan",
          "BlinkPairsBlue",
          "BlinkPairsViolet",
        },
      },
    },
  },
}
