local ui = require("ui")

local colorful_menu_opts = {
  ls = {
    lua_ls = {
      arguments_hl = "LspInlayHint",
    },
    gopls = {
      align_type_to_right = true,
      add_colon_before_type = false,
      preserve_type_when_truncate = true,
    },
    ts_ls = {
      extra_info_hl = "BlinkCmpLabelDescription",
    },
    vtsls = {
      extra_info_hl = "BlinkCmpLabelDescription",
    },
    ["rust-analyzer"] = {
      extra_info_hl = "BlinkCmpLabelDescription",
      align_type_to_right = true,
      preserve_type_when_truncate = true,
    },
    clangd = {
      extra_info_hl = "BlinkCmpLabelDescription",
      align_type_to_right = true,
      import_dot_hl = "@comment",
      preserve_type_when_truncate = true,
    },
    zls = {
      align_type_to_right = true,
    },
    roslyn = {
      extra_info_hl = "BlinkCmpLabelDescription",
    },
    dartls = {
      extra_info_hl = "BlinkCmpLabelDescription",
    },
    jdtls = {
      extra_info_hl = "BlinkCmpLabelDescription",
    },
    basedpyright = {
      extra_info_hl = "BlinkCmpLabelDescription",
    },
    pylsp = {
      extra_info_hl = "BlinkCmpLabelDescription",
      arguments_hl = "LspInlayHint",
    },
    fallback = true,
    fallback_extra_info_hl = "BlinkCmpLabelDescription",
  },
  fallback_highlight = "@variable",
  max_width = 60,
}

local blink_opts = {
  fuzzy = { implementation = "prefer_rust_with_warning" },
  keymap = {
    preset = "enter",
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
  },
  signature = {
    enabled = true,
    trigger = {
      blocked_trigger_characters = { " ", "\n", "\t" },
      blocked_retrigger_characters = { " ", "\n", "\t" },
    },
    window = {
      show_documentation = false,
    },
  },
  appearance = {
    kind_icons = ui.icons.lazy_kind_icons,
  },
  completion = {
    ghost_text = { enabled = true },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
      update_delay_ms = 250,
    },
    accept = { auto_brackets = { enabled = true } },
    list = { selection = { preselect = true, auto_insert = false } },
    menu = {
      scrollbar = true,
      draw = {
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
          kind_icon = {
            text = function(ctx)
              -- local kind_icon = require("mini.icons").get("lsp", ctx.kind)
              return ctx.kind_icon .. " "
            end,
            highlight = function(ctx)
              local _, hl = require("mini.icons").get("lsp", ctx.kind)
              return hl
            end,
          },
          kind = {
            highlight = function(ctx)
              local _, hl = require("mini.icons").get("lsp", ctx.kind)
              return hl
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
      menu = {
        auto_show = function()
          return vim.fn.getcmdtype() == ":"
        end,
      },
    },
  },
  snippets = { preset = "luasnip" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
}

local blink_pairs_opts = {
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
    cmdline = true,
    groups = {
      "BlinkPairsRed",
      "BlinkPairsCyan",
      "BlinkPairsYellow",
      "BlinkPairsGreen",
      "BlinkPairsOrange",
      "BlinkPairsViolet",
      "BlinkPairsBlue",
    },
    unmatched_group = "BlinkPairsUnmatched",
    -- highlights matching pairs under the cursor
    matchparen = {
      enabled = true,
      cmdline = true,
      include_surrounding = false,
      group = "BlinkPairsMatchParen",
      priority = 250,
    },
  },
  debug = false,
}

require("colorful-menu").setup(colorful_menu_opts)

local pairs = require("blink.pairs")

pairs.setup(blink_pairs_opts)
---@diagnostic disable-next-line: undefined-field
pairs.build():pwait()

local cmp = require("blink.cmp")
cmp.setup(blink_opts)
---@diagnostic disable-next-line: undefined-field
cmp.build():pwait()

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend("force", capabilities, {
  workspace = {
    fileOperations = {
      didRename = true,
      willRename = true,
    },
  },
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
})

capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

vim.lsp.config("*", {
  capabilities = capabilities,
})
