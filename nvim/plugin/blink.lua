local ui = require("ui")
local util = require("util")

vim.pack.add({
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/nicholasxjy/colorful-menu.nvim",
  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/saghen/blink.pairs",
  "https://github.com/saghen/blink.indent",
}, { load = false })

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

local get_kind_hl = function(ctx)
  local highlight_colors_avail, highlight_colors = pcall(require, "nvim-highlight-colors")
  if highlight_colors_avail then
    local kinds = require("blink.cmp.types").CompletionItemKind
    if ctx.item.kind == kinds.Color then
      local doc = vim.tbl_get(ctx, "item", "documentation")
      if doc then
        local color_item = highlight_colors_avail and highlight_colors.format(doc, { kind = kinds[kinds.Color] })
        if color_item and color_item.abbr_hl_group then
          return color_item.abbr_hl_group
        end
      end
    end
  end
end

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
        columns = { { "label", gap = 1 }, { "kind_icon", "kind" } },
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
              return get_kind_hl(ctx) or hl
            end,
          },
          kind = {
            highlight = function(ctx)
              local _, hl = require("mini.icons").get("lsp", ctx.kind)
              return get_kind_hl(ctx) or hl
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
      ghost_text = { enabled = false },
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

util.build_cmd_on_change("LuaSnip", { "install", "update" }, { "make", "install_jsregexp" })

local loaded = false

local function load_blink()
  if loaded then
    return
  end

  vim.cmd.packadd("friendly-snippets")
  vim.cmd.packadd("LuaSnip")
  vim.cmd.packadd("colorful-menu.nvim")
  vim.cmd.packadd("blink.lib")
  vim.cmd.packadd("blink.cmp")
  vim.cmd.packadd("blink.pairs")
  vim.cmd.packadd("blink.indent")

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

  require("colorful-menu").setup(colorful_menu_opts)

  require("blink.indent").setup({
    blocked = {
      buftypes = { include_defaults = true },
      filetypes = { include_defaults = true },
    },
    mappings = {
      -- which lines around the scope are included for 'ai': 'top', 'bottom', 'both', or 'none'
      border = "both",
      -- set to '' to disable
      -- textobjects (e.g. `y2ii` to yank current and outer scope)
      object_scope = "ii",
      object_scope_with_border = "ai",
      -- motions
      goto_top = "[i",
      goto_bottom = "]i",
    },
    static = {
      enabled = false,
      char = "▎",
      whitespace_char = nil, -- inherits from `vim.opt.listchars:get().space` when `nil` (see `:h listchars`)
      priority = 1,
      -- specify multiple highlights here for rainbow-style indent guides
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
      enabled = true, -- highlight highest level of indentation on the current line
      indent_at_cursor = true, -- clamp to indent level of cursor
      -- char = "▎",
      char = "│",
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
      -- enable to show underlines on the line above the current scope
      underline = {
        enabled = false,
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
  })

  local pairs = require("blink.pairs")
  ---@diagnostic disable-next-line: undefined-field
  pairs.build():pwait(60000)
  pairs.setup(blink_pairs_opts)

  local cmp = require("blink.cmp")
  ---@diagnostic disable-next-line: undefined-field
  cmp.build():pwait(60000)
  cmp.setup(blink_opts)

  loaded = true
end

vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
  once = true,
  callback = function()
    vim.schedule(load_blink)
  end,
})
