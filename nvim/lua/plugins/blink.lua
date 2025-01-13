local icons = require("core.icons")

return {
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = {
      {
        "xzbdmw/colorful-menu.nvim",
        config = function()
          require("colorful-menu").setup({})
        end,
      },
      "rafamadriz/friendly-snippets",
      "Exafunction/codeium.nvim",
      { "Saghen/blink.compat", opts = { enable_events = true } },
      "MeanderingProgrammer/render-markdown.nvim",
    },
    build = "cargo build --release",
    event = "InsertEnter",
    opts = function()
      return {
        keymap = {
          preset = "enter",
        },
        appearance = {
          kind_icons = icons.lazy_kind_icons,
          use_nvim_cmp_as_default = false,
          nerd_font_variant = "mono",
        },
        signature = { enabled = true },
        completion = {
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
          },
          accept = {
            auto_brackets = {
              enabled = true,
              default_brackets = { "(", ")", "{", "}", "[", "]" },
            },
          },
          menu = {
            draw = {
              treesitter = {},
              columns = { { "kind_icon" }, { "label", gap = 1 } },
              components = {
                label = {
                  text = require("colorful-menu").blink_components_text,
                  highlight = require("colorful-menu").blink_components_highlight,
                },
              },
            },
          },
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer", "markdown", "codeium" },
          providers = {
            codeium = {
              name = "codeium",
              score_offset = 100,
              async = true,
              module = "blink.compat.source",
            },
            markdown = {
              name = "RenderMarkdown",
              module = "render-markdown.integ.blink",
              fallbacks = { "lsp" },
            },
          },
          cmdline = function()
            local type = vim.fn.getcmdtype()
            -- Search forward and backward
            if type == "/" or type == "?" then
              return { "buffer" }
            end
            -- Commands
            if type == ":" or type == "@" then
              return { "cmdline" }
            end
            return {}
          end,
        },
      }
    end,
    config = function(_, opts)
      require("blink.cmp").setup(opts)
    end,
  },
}
