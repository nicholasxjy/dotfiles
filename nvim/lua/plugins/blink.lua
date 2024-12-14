local icons = require("core.icons")
return {
  {
    "Saghen/blink.cmp",
    lazy = false,
    dependencies = "rafamadriz/friendly-snippets",
    build = "cargo build --release",
    event = "InsertEnter",
    opts = {
      keymap = {
        preset = "enter",
      },
      appearance = {
        kind_icons = icons.kind_icons,
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
            treesitter = { "lsp" },
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
          },
        },
      },
      sources = {
        cmdline = function()
          return {}
        end,
      },
    },
    config = function(_, opts)
      require("blink.cmp").setup(opts)
    end,
  },
}
