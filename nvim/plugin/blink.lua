local loader = require("loader")

-- blink.cmp must be up before `lua/lsp.lua` asks it for LSP capabilities.
-- The snippet engine and the pairs/indent decorations are not needed to draw
-- the first frame, so they are set up on VeryLazy instead.
loader.packadd("lspkind.nvim", "nvim-web-devicons", "blink.lib", "mini.icons", "blink.cmp")

require("lspkind").init({
  mode = "symbol_text",
  preset = "codicons",
  symbol_map = {},
})
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
        treesitter = { "lsp" },
        columns = { { "kind_icon", gap = 1 }, { "label", "label_description", gap = 1 }, { "kind" } },
        components = {
          label = { width = { max = 32 } },
          label_description = { width = { max = 16 } },
          kind_icon = {
            text = function(ctx)
              local icon = ctx.kind_icon
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then
                  icon = dev_icon
                end
              else
                icon = require("lspkind").symbol_map[ctx.kind] or ""
              end
              return icon .. ctx.icon_gap
            end,
            highlight = function(ctx)
              local hl = ctx.kind_hl
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then
                  hl = dev_hl
                end
              end
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

require("blink.cmp").setup(blink_opts)

local function setup_snippets()
  loader.packadd("LuaSnip", "friendly-snippets")
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
  local snippets_dir = vim.fn.stdpath("config") .. "/snippets"
  if vim.uv.fs_stat(snippets_dir) then
    require("luasnip.loaders.from_lua").lazy_load({ paths = { snippets_dir } })
  end
end

loader.defer("luasnip", setup_snippets, "InsertEnter")
loader.on_very_lazy("luasnip", setup_snippets)
