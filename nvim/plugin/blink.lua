local util = require("util")

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

local blink_completion_capabilities = {
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = true,
        commitCharactersSupport = false,
        documentationFormat = { "markdown", "plaintext" },
        deprecatedSupport = true,
        preselectSupport = false,
        tagSupport = { valueSet = { 1 } },
        insertReplaceSupport = true,
        resolveSupport = {
          properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
            "command",
            "data",
          },
        },
        insertTextModeSupport = {
          valueSet = { 1 },
        },
        labelDetailsSupport = true,
      },
      completionList = {
        itemDefaults = {
          "commitCharacters",
          "editRange",
          "insertTextFormat",
          "insertTextMode",
          "data",
        },
      },
      contextSupport = true,
      insertTextMode = 1,
    },
  },
}

util.build_fn_on_change("blink.cmp", { "install", "update" }, function()
  util.packadd("blink.lib", false)
  util.packadd("blink.cmp", false)
  ---@diagnostic disable-next-line: undefined-field
  require("blink.cmp").build():wait(60000)
end)

local function setup_colorful_menu()
  if vim.g.colorful_menu_setup_done then
    return
  end

  util.ensure_plugin("colorful-menu.nvim", function()
    require("colorful-menu").setup(colorful_menu_opts)
    vim.g.colorful_menu_setup_done = true
  end, false)
end

-- util.build_cmd_on_change("blink.pairs", { "install", "update" }, { "cargo", "build", "--release" })

local function setup_blink_pairs()
  if vim.g.blink_pairs_setup_done then
    return
  end
  util.ensure_plugin("blink.pairs", function()
    require("blink.pairs").setup({
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
    })
    vim.g.blink_pairs_setup_done = true
  end, false)
end

setup_blink_pairs()

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
  appearance = {},
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
        columns = { { "kind_icon" }, { "label", gap = 1 }, { "kind" } },
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
              local kind_icon = require("mini.icons").get("lsp", ctx.kind)
              return kind_icon .. " "
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

local function setup_blink()
  if vim.g.blink_setup_done then
    return
  end

  if type(_G.__setup_luasnip) == "function" then
    _G.__setup_luasnip()
  end

  setup_colorful_menu()

  util.packadd("blink.lib", false)
  util.ensure_plugin("blink.cmp", function()
    require("blink.cmp").setup(blink_opts)
    vim.g.blink_setup_done = true
  end, false)
end

vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
  group = vim.api.nvim_create_augroup("BlinkDeferredSetup", { clear = true }),
  once = true,
  callback = function()
    vim.schedule(setup_blink)
  end,
})

function _G.__setup_blink_lsp_capabilities()
  if vim.g.blink_lsp_capabilities_setup_done then
    return
  end

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

  capabilities = vim.tbl_deep_extend("force", capabilities, blink_completion_capabilities)

  vim.lsp.config("*", {
    capabilities = capabilities,
  })

  vim.g.blink_lsp_capabilities_setup_done = true
end
