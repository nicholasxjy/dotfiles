local icons = require("core.icons")
return {
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "Exafunction/codeium.nvim",
      { "saghen/blink.compat" },
    },
    version = "*",
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
            treesitter = {},
            components = {
              label = {
                width = { fill = true, max = 60 },
                text = function(ctx)
                  local highlights_info = require("colorful-menu").highlights(ctx.item, vim.bo.filetype)
                  if highlights_info ~= nil then
                    return highlights_info.text
                  else
                    return ctx.label
                  end
                end,
                highlight = function(ctx)
                  local highlights_info = require("colorful-menu").highlights(ctx.item, vim.bo.filetype)
                  local highlights = {}
                  if highlights_info ~= nil then
                    for _, info in ipairs(highlights_info.highlights) do
                      table.insert(highlights, {
                        info.range[1],
                        info.range[2],
                        group = ctx.deprecated and "BlinkCmpLabelDeprecated" or info[1],
                      })
                    end
                  end
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                  end
                  return highlights
                end,
              },
            },
          },
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "codeium" },
        providers = {
          codeium = {
            name = "codeium",
            score_offset = 100,
            module = "blink.compat.source",
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
    },
    config = function(_, opts)
      require("blink.cmp").setup(opts)
    end,
  },
}
