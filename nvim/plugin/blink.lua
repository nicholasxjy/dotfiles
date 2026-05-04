local blink = require("blink.cmp")
local ui = require("ui")

local function setup_blink()
  if vim.g.blink_setup_done then
    return
  end
  vim.g.blink_setup_done = true

  vim.schedule(function()
    pcall(function()
      blink.build():wait(60000)
    end)
  end)

  blink.setup({
    fuzzy = { implementation = "prefer_rust_with_warning" },
    keymap = {
      preset = "enter",
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
    },
    signature = {
      enabled = true,
      window = {
        show_documentation = true,
      },
    },
    appearance = {
      kind_icons = ui.icons.lspkind_kind_icons,
    },
    completion = {
      ghost_text = { enabled = true },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100,
      },
      accept = { auto_brackets = { enabled = true } },
      list = { selection = { preselect = true, auto_insert = false } },
      menu = {
        scrollbar = true,
        draw = {
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
          treesitter = { "lsp" },
          components = {
            kind_icon = {
              text = function(ctx)
                -- local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return ctx.kind_icon .. " "
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
        },
      },
    },
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  })
end

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.schedule(setup_blink)
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.tbl_deep_extend("force", capabilities, {
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

capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities(capabilities, true))

vim.lsp.config("*", {
  capabilities = capabilities,
})
