local icons = require("core.icons")
return {
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = { { "L3MON4D3/LuaSnip", version = "v2.*" } },
    build = "cargo build --release",
    event = "InsertEnter",
    opts = {
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
            treesitter = { "lsp" },
            -- columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
          },
        },
      },
      snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },
      sources = {
        default = { "lsp", "path", "luasnip", "buffer" },
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
    },
    config = function(_, opts)
      require("blink.cmp").setup(opts)
    end,
  },
}
