local blink = require("blink.cmp")
local ui = require("ui")
local util = require("util")

util.build_fn_on_change("blink.cmp", { "install", "update" }, function()
  util.packadd("blink.cmp")
  ---@diagnostic disable-next-line: undefined-field
  blink.build():wait(60000)
end)

require("colorful-menu").setup({
  ls = {
    lua_ls = {
      -- Maybe you want to dim arguments a bit.
      arguments_hl = "LspInlayHint",
    },
    gopls = {
      -- By default, we render variable/function's type in the right most side,
      -- to make them not to crowd together with the original label.

      -- when true:
      -- foo             *Foo
      -- ast         "go/ast"

      -- when false:
      -- foo *Foo
      -- ast "go/ast"
      align_type_to_right = true,
      -- When true, label for field and variable will format like "foo: Foo"
      -- instead of go's original syntax "foo Foo". If align_type_to_right is
      -- true, this option has no effect.
      add_colon_before_type = false,
      -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
      preserve_type_when_truncate = true,
    },
    -- for lsp_config or typescript-tools
    ts_ls = {
      -- false means do not include any extra info,
      -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
      extra_info_hl = "BlinkCmpLabelDescription",
    },
    vtsls = {
      -- false means do not include any extra info,
      -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
      extra_info_hl = "BlinkCmpLabelDescription",
    },
    ["rust-analyzer"] = {
      -- Such as (as Iterator), (use std::io).
      extra_info_hl = "BlinkCmpLabelDescription",
      -- Similar to the same setting of gopls.
      align_type_to_right = true,
      -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
      preserve_type_when_truncate = true,
    },
    clangd = {
      -- Such as "From <stdio.h>".
      extra_info_hl = "BlinkCmpLabelDescription",
      -- Similar to the same setting of gopls.
      align_type_to_right = true,
      -- the hl group of leading dot of "•std::filesystem::permissions(..)"
      import_dot_hl = "@comment",
      -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
      preserve_type_when_truncate = true,
    },
    zls = {
      -- Similar to the same setting of gopls.
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
    -- The same applies to pyright/pylance
    basedpyright = {
      -- It is usually import path such as "os"
      extra_info_hl = "BlinkCmpLabelDescription",
    },
    pylsp = {
      extra_info_hl = "BlinkCmpLabelDescription",
      -- Dim the function argument area, which is the main
      -- difference with pyright.
      arguments_hl = "LspInlayHint",
    },
    -- If true, try to highlight "not supported" languages.
    fallback = true,
    -- this will be applied to label description for unsupport languages
    fallback_extra_info_hl = "BlinkCmpLabelDescription",
  },
  -- If the built-in logic fails to find a suitable highlight group for a label,
  -- this highlight is applied to the label.
  fallback_highlight = "@variable",
  -- If provided, the plugin truncates the final displayed text to
  -- this width (measured in display cells). Any highlights that extend
  -- beyond the truncation point are ignored. When set to a float
  -- between 0 and 1, it'll be treated as percentage of the width of
  -- the window: math.floor(max_width * vim.api.nvim_win_get_width(0))
  -- Default 60.
  max_width = 60,
})

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
      -- Keep signature help lightweight while typing.
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
        -- treesitter = { "lsp" },
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
}

local function setup_blink()
  if vim.g.blink_setup_done then
    return
  end

  if type(_G.__setup_luasnip) == "function" then
    _G.__setup_luasnip()
  end

  vim.g.blink_setup_done = true
  blink.setup(blink_opts)
end

vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
  group = vim.api.nvim_create_augroup("BlinkDeferredSetup", { clear = true }),
  once = true,
  callback = function()
    vim.schedule(setup_blink)
  end,
})

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

capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities(capabilities, true))

vim.lsp.config("*", {
  capabilities = capabilities,
})
