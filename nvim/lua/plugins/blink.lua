return {
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    lazy = true,
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local ls = require("luasnip")
      ls.config.set_config({
        enable_autosnippets = true,
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })
      ls.filetype_extend("typescript", { "javascript" })
      ls.filetype_extend("javascriptreact", { "javascript" })
      ls.filetype_extend("typescriptreact", { "javascript" })
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load({ paths = { "./snippets" } })
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      { "L3MON4D3/LuaSnip" },
      { "fang2hou/blink-copilot" },
      { "folke/lazydev.nvim" },
    },
    build = "cargo build --release",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = function()
      return {
        enabled = function()
          return not vim.tbl_contains(
            { "bigfile", "grug-far", "snacks_picker", "snacks_picker_input", "fyler", "minifiles" },
            vim.bo.filetype
          ) and vim.b.completion ~= false and vim.bo.buftype ~= "prompt"
        end,
        fuzzy = {
          implementation = "prefer_rust",
        },
        snippets = { preset = "luasnip" },
        keymap = {
          preset = "enter",
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<C-u>"] = { "scroll_documentation_up", "fallback" },
          ["<C-d>"] = { "scroll_documentation_down", "fallback" },
          ["<Tab>"] = {
            -- nes
            function() -- sidekick next edit suggestion
              return require("sidekick").nes_jump_or_apply()
            end,
            "snippet_forward",
            "select_next",
            "fallback",
          },
          ["<S-Tab>"] = {
            "snippet_backward",
            "select_prev",
            "fallback",
          },
        },
        signature = {
          enabled = true,
          window = {
            show_documentation = true,
            border = vim.g.border_style,
          },
        },
        appearance = {
          -- use_nvim_cmp_as_default = true,
          -- nerd_font_variant = "mono",
          -- kind_icons = ui.icons.lspkind_kind_icons,
        },
        completion = {
          ghost_text = { enabled = true },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
            window = {
              border = vim.g.border_style,
              max_height = 20,
              max_width = 40,
            },
          },
          accept = { auto_brackets = { enabled = true } },
          list = { selection = { preselect = true, auto_insert = true } },
          menu = {
            scrollbar = true,
            border = vim.g.border_style,
            draw = {
              columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
              treesitter = { "lsp" },
              components = {
                kind_icon = {
                  text = function(ctx)
                    local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                    return kind_icon .. " "
                  end,
                  highlight = function(ctx)
                    local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                    return hl
                  end,
                },
                kind = {
                  highlight = function(ctx)
                    local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                    return hl
                  end,
                },
                source_name = {
                  text = function(ctx)
                    if ctx.source_name == "LSP" then
                      return "[LSP]"
                    end
                    if ctx.source_name == "Snippets" then
                      return "[SNIP]"
                    end
                    if ctx.source_name == "Buffer" then
                      return "[BUF]"
                    end
                    if ctx.source_name == "Path" then
                      return "[PATH]"
                    end
                  end,
                  highlight = function()
                    return "BlinkCmpSource"
                  end,
                },
              },
            },
          },
        },
        cmdline = {
          enabled = true,
          keymap = {
            preset = "cmdline",
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
          },
          completion = {
            ghost_text = { enabled = true },
            list = { selection = { preselect = false, auto_insert = true } },
          },
        },
        sources = {
          default = { "lazydev", "snippets", "lsp", "path", "buffer", "copilot" },
          providers = {
            buffer = {
              opts = {
                get_bufnrs = function()
                  local current = vim.api.nvim_get_current_buf()
                  local bufnrs = { current }
                  local seen = { [current] = true }

                  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                    local bufnr = vim.api.nvim_win_get_buf(win)
                    if not seen[bufnr] and vim.bo[bufnr].buftype == "" then
                      seen[bufnr] = true
                      table.insert(bufnrs, bufnr)
                    end
                  end

                  return bufnrs
                end,
              },
            },
            copilot = {
              name = "copilot",
              module = "blink-copilot",
              async = true,
              score_offset = 100,
              enabled = function()
                return vim.g.copilot_enabled
              end,
              opts = {
                max_completions = 2,
                max_items = 2,
                max_attempts = 3,
              },
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
  {
    "saghen/blink.indent",
    --- @module 'blink.indent'
    --- @type blink.indent.Config
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      blocked = {
        -- default: 'terminal', 'quickfix', 'nofile', 'prompt'
        buftypes = { include_defaults = true },
        -- default: 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'gitcommit', 'dashboard', ''
        filetypes = { include_defaults = true },
      },
      static = {
        enabled = false,
        char = "▎",
        whitespace_char = nil, -- inherits from `vim.opt.listchars:get().space` when `nil` (see `:h listchars`)
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
        char = "▎",
        priority = 1000,
        highlights = {
          "BlinkIndentRed",
          "BlinkIndentCyan",
          "BlinkIndentYellow",
          "BlinkIndentGreen",
          "BlinkIndentOrange",
          "BlinkIndentViolet",
          "BlinkIndentBlue",
        },
        underline = {
          enabled = true,
          highlights = {
            "BlinkIndentRedUnderline",
            "BlinkIndentCyanUnderline",
            "BlinkIndentYellowUnderline",
            "BlinkIndentGreenUnderline",
            "BlinkIndentOrangeUnderline",
            "BlinkIndentVioletUnderline",
            "BlinkIndentBlueUnderline",
          },
        },
      },
    },
  },
  {
    "saghen/blink.pairs",
    dependencies = "saghen/blink.download",
    build = "cargo build --release",
    event = { "InsertEnter" },
    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      mappings = {
        -- you can call require("blink.pairs.mappings").enable()
        -- and require("blink.pairs.mappings").disable()
        -- to enable/disable mappings at runtime
        enabled = true,
        cmdline = true,
        -- or disable with `vim.g.pairs = false` (global) and `vim.b.pairs = false` (per-buffer)
        -- and/or with `vim.g.blink_pairs = false` and `vim.b.blink_pairs = false`
        disabled_filetypes = {},
        wrap = {
          -- move closing pair via motion
          ["<C-b>"] = "motion",
          -- move opening pair via motion
          ["<C-S-b>"] = "motion_reverse",
          -- set to 'treesitter' or 'treesitter_reverse' to use treesitter instead of motions
          -- set to nil, '' or false to disable the mapping
          -- normal_mode = {} <- for normal mode mappings, only supports 'motion' and 'motion_reverse'
        },
        -- see the defaults:
        -- https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L52
        pairs = {},
      },
      highlights = {
        enabled = true,
        -- requires require('vim._extui').enable({}), otherwise has no effect
        cmdline = true,
        -- set to { 'BlinkPairs' } to disable rainbow highlighting
        groups = {
          "BlinkPairsRed",
          "BlinkPairsOrange",
          "BlinkPairsYellow",
          "BlinkPairsBlue",
          "BlinkPairsGreen",
          "BlinkPairsViolet",
          "BlinkPairsCyan",
        },
        unmatched_group = "BlinkPairsUnmatched",

        -- highlights matching pairs under the cursor
        matchparen = {
          enabled = true,
          -- known issue where typing won't update matchparen highlight, disabled by default
          cmdline = true,
          -- also include pairs not on top of the cursor, but surrounding the cursor
          include_surrounding = true,
          group = "BlinkPairsMatchParen",
          priority = 250,
        },
      },
      debug = false,
    },
  },
}
