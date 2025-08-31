local icons = require("core.icons")

local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
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
      "fang2hou/blink-copilot",
      { "xzbdmw/colorful-menu.nvim", opts = {} },
    },
    build = "cargo build --release",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = function()
      return {
        fuzzy = { implementation = "prefer_rust" },
        keymap = {
          ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<C-N>"] = { "select_next", "show" },
          ["<C-P>"] = { "select_prev", "show" },
          ["<C-J>"] = { "select_next", "fallback" },
          ["<C-K>"] = { "select_prev", "fallback" },
          ["<C-U>"] = { "scroll_documentation_up", "fallback" },
          ["<C-D>"] = { "scroll_documentation_down", "fallback" },
          ["<C-e>"] = { "hide", "fallback" },
          ["<CR>"] = { "accept", "fallback" },
          ["<Tab>"] = {
            "select_next",
            "snippet_forward",
            function(cmp)
              if has_words_before() or vim.api.nvim_get_mode().mode == "c" then
                return cmp.show()
              end
            end,
            "fallback",
          },
          ["<S-Tab>"] = {
            "select_prev",
            "snippet_backward",
            function(cmp)
              if vim.api.nvim_get_mode().mode == "c" then
                return cmp.show()
              end
            end,
            "fallback",
          },
        },
        signature = {
          enabled = true,
          window = { show_documentation = true, border = vim.g.bordered and "rounded" or "none" },
        },
        appearance = { kind_icons = icons.lspkind },
        completion = {
          ghost_text = { enabled = true },
          documentation = {
            auto_show = true,
            window = {
              border = vim.g.bordered and {
                { "", "DiagnosticHint" },
                "─",
                "╮",
                "│",
                "╯",
                "─",
                "╰",
                "│",
              } or "none",
            },
          },
          accept = { auto_brackets = { enabled = true } },
          list = { selection = { preselect = true, auto_insert = true } },
          menu = {
            scrollbar = false,
            border = vim.g.bordered and {
              { "󱐋", "WarningMsg" },
              "─",
              "╮",
              "│",
              "╯",
              "─",
              "╰",
              "│",
            } or "none",
            draw = {
              columns = {
                { "kind_icon" },
                { "label", "kind", "source_name", gap = 1 },
              },
              treesitter = { "lsp" },
              components = {
                kind = {
                  text = function(ctx)
                    return "(" .. ctx.kind:lower() .. ")"
                  end,
                },
                label = {
                  width = { max = 40 },
                  text = function(ctx)
                    return require("colorful-menu").blink_components_text(ctx)
                  end,
                  highlight = function(ctx)
                    return require("colorful-menu").blink_components_highlight(ctx)
                  end,
                },
                source_name = {
                  text = function(ctx)
                    return "[" .. ctx.source_name:upper() .. "]"
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
            ghost_text = { enabled = false },
            list = { selection = { preselect = false, auto_insert = true } },
            menu = { auto_show = true },
          },
        },
        snippets = { preset = "luasnip" },
        sources = {
          default = { "lsp", "path", "snippets", "buffer", "copilot" },
          providers = {
            copilot = {
              name = "copilot",
              module = "blink-copilot",
              async = true,
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
  {
    "saghen/blink.indent",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      static = {
        enabled = true,
        char = "",
        priority = 1,
        highlights = {
          "BlinkIndentRed",
          "BlinkIndentOrange",
          "BlinkIndentYellow",
          "BlinkIndentGreen",
          "BlinkIndentViolet",
          "BlinkIndentCyan",
        },
      },
      scope = {
        enabled = true,
        char = "║",
        priority = 1024,
        highlights = {
          "BlinkIndentOrange",
          "BlinkIndentViolet",
          "BlinkIndentBlue",
          "BlinkIndentRed",
          "BlinkIndentCyan",
          "BlinkIndentYellow",
          "BlinkIndentGreen",
        },
        underline = {
          enabled = true,
          highlights = {
            "BlinkIndentOrangeUnderline",
            "BlinkIndentVioletUnderline",
            "BlinkIndentBlueUnderline",
            "BlinkIndentRedUnderline",
            "BlinkIndentCyanUnderline",
            "BlinkIndentYellowUnderline",
            "BlinkIndentGreenUnderline",
          },
        },
      },
    },
  },
}
