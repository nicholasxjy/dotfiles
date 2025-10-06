local misc = require("utils.misc")

local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
        { path = "dart.nvim", words = { "Dart" } },
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    lazy = true,
    dependencies = { { "rafamadriz/friendly-snippets", lazy = true } },
    config = function()
      local ls = require("luasnip")
      ls.config.setup({
        enable_autosnippets = true,
        history = true,
        updateevents = "TextChanged,TextChangedI",
        delete_check_events = "TextChanged",
        region_check_events = "CursorMoved",
      })
      ls.filetype_extend("typescript", { "javascript" })
      ls.filetype_extend("javascriptreact", { "javascript" })
      ls.filetype_extend("typescriptreact", { "javascript" })

      vim.tbl_map(function(type)
        require("luasnip.loaders.from_" .. type).lazy_load()
      end, { "vscode", "snipmate", "lua" })
    end,
  },
  {
    "Saghen/blink.cmp",
    dependencies = {
      "fang2hou/blink-copilot",
      { "xzbdmw/colorful-menu.nvim", opts = {} },
      "onsails/lspkind.nvim",
    },
    build = "cargo build --release",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = function()
      return {
        fuzzy = {
          implementation = "prefer_rust",
          sorts = {
            function(a, b)
              local sort = require("blink.cmp.fuzzy.sort")
              if a.source_id == "spell" and b.source_id == "spell" then
                return sort.label(a, b)
              end
            end,
            "score",
            "kind",
            "label",
          },
        },
        keymap = {
          ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<C-N>"] = { "select_next", "show" },
          ["<C-P>"] = { "select_prev", "show" },
          ["<C-J>"] = { "snippet_forward", "select_next", "fallback" },
          ["<C-K>"] = { "snippet_backward", "select_prev", "fallback" },
          ["<C-U>"] = { "scroll_documentation_up", "fallback" },
          ["<C-D>"] = { "scroll_documentation_down", "fallback" },
          ["<C-e>"] = { "hide", "fallback" },
          ["<CR>"] = { "accept", "fallback" },
          ["<Tab>"] = {
            "snippet_forward",
            function()
              return require("sidekick").nes_jump_or_apply()
            end,
            function(cmp)
              if has_words_before() or vim.api.nvim_get_mode().mode == "c" then
                return cmp.show()
              end
            end,
            "fallback",
          },
          ["<S-Tab>"] = {
            "snippet_backward",
            "select_prev",
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
        -- appearance = { kind_icons = ui.icons.lazy_kind_icons },
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
                { "kind_icon", "label", gap = 1 },
                { "kind" },
              },
              treesitter = { "lsp" },
              components = {
                kind_icon = {
                  text = function(ctx)
                    return misc.get_kind_icon(ctx).text
                  end,
                  highlight = function(ctx)
                    return misc.get_kind_icon(ctx).highlight
                  end,
                },
                label = {
                  text = function(ctx)
                    return require("colorful-menu").blink_components_text(ctx)
                  end,
                  highlight = function(ctx)
                    return require("colorful-menu").blink_components_highlight(ctx)
                  end,
                },
                source_name = {
                  text = function(ctx)
                    return " " .. "[" .. ctx.source_name .. "]"
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
          default = { "lazydev", "lsp", "path", "snippets", "buffer" },
          providers = {
            copilot = {
              name = "copilot",
              module = "blink-copilot",
              async = true,
              score_offset = 100,
            },
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
