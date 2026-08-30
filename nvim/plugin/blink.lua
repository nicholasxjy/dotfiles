local loader = require("loader")

-- blink.cmp must be up before `lua/lsp.lua` asks it for LSP capabilities.
-- The snippet engine and the pairs/indent decorations are not needed to draw
-- the first frame, so they are set up on VeryLazy instead.
loader.packadd("blink.lib", "mini.icons", "LuaSnip", "friendly-snippets", "blink.cmp")

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
      scrollbar = false,
      draw = {
        -- treesitter = { "lsp" },
        columns = { { "label", "label_description" }, { "kind_icon", "kind", gap = 2 } },
        components = {
          label = { width = { max = 26 } },
          label_description = { width = { max = 16 } },
          kind_icon = {
            text = function(ctx)
              local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
              return kind_icon
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
        draw = {
          columns = { { "label", "label_description", gap = 2 } },
        },
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

local cmp = require("blink.cmp")
if not cmp.library_available() then
  ---@diagnostic disable-next-line: undefined-field
  cmp.build():pwait(60000)
end
cmp.setup(blink_opts)

loader.on_very_lazy("luasnip", function()
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
end)
