local icons = require("core.icons")
return {
  {
    "xzbdmw/colorful-menu.nvim",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("colorful-menu").setup({
        max_width = 60,
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
        keymap = {
          accept = false,
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "Saghen/blink.cmp",
    dependencies = {
      { "L3MON4D3/LuaSnip", version = "v2.*" },
      "xzbdmw/colorful-menu.nvim",
      "giuxtaposition/blink-cmp-copilot",
    },
    -- version = "*",
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
          -- use noice
          enabled = false,
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
              -- treesitter = { "lsp" },
              --
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
        },
      }
    end,
    config = function(_, opts)
      require("blink.cmp").setup(opts)
    end,
  },
}
