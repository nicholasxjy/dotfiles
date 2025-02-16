local icons = require("core.icons")

return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
    },
    version = "*",
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
        signature = { enabled = false },
        completion = {
          documentation = {
            auto_show = true,
          },
          accept = {
            auto_brackets = {
              enabled = true,
              default_brackets = { "(", ")", "{", "}", "[", "]" },
            },
          },
          menu = {
            draw = {
              treesitter = { "lsp" },
              columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
            },
          },
          ghost_text = { enabled = true },
        },
        snippets = { preset = "luasnip" },
        sources = {
          default = { "lazydev", "lsp", "path", "snippets", "buffer" },
          providers = {
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
