local icons = require("core.icons")
return {
  {
    "saghen/blink.cmp",
    dependencies = {
      { "L3MON4D3/LuaSnip", version = "v2.*" },
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
          kind_icons = icons.lazy_kind_icons,
          use_nvim_cmp_as_default = false,
          nerd_font_variant = "mono",
        },
        signature = {
          enabled = true,
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
              treesitter = { "lsp" },
            },
          },
        },
        cmdline = {
          enabled = true,
          -- keymap = {
          --   preset = "enter",
          -- },
          completion = {
            ghost_text = { enabled = true },
            menu = {
              auto_show = true,
            },
          },
        },
        snippets = { preset = "luasnip" },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
      }
    end,
    config = function(_, opts)
      require("blink.cmp").setup(opts)
    end,
  },
}
