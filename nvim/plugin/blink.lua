local ui = require("ui")

vim.cmd.packadd("blink.cmp")
vim.cmd.packadd("friendly-snippets")
vim.cmd.packadd("LuaSnip")

local blink_opts = {
  fuzzy = { implementation = "prefer_rust_with_warning", sorts = { "exact", "score", "sort_text" } },
  keymap = {
    preset = "enter",
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
  },
  signature = {
    enabled = true,
    window = {
      show_documentation = false,
    },
  },
  appearance = {
    -- Icons in ui.icons.default_kind_icons include trailing spaces (non-mono nerd font).
    nerd_font_variant = "normal",
    kind_icons = ui.icons.default_kind_icons,
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
        treesitter = { "lsp" },
        -- Keep kind_icon in its own column so appearance.kind_icons always renders.
        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
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
        draw = { columns = { { "label" }, { "label_description" } } },
      },
    },
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
if not pairs.library_available() then
  ---@diagnostic disable-next-line: undefined-field
  pairs.build():pwait(60000)
end
pairs.setup(blink_pairs_opts)
vim.cmd.packadd("blink.pairs")

local cmp = require("blink.cmp")
if not cmp.library_available() then
  ---@diagnostic disable-next-line: undefined-field
  cmp.build():pwait(60000)
end
cmp.setup(blink_opts)
vim.cmd.packadd("blink.indent")
