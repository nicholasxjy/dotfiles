local ui = require("ui")

local function has_config(ctx, files)
  return not vim.tbl_isempty(vim.fs.find(files, { path = ctx.dirname, upward = true }))
end

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
    -- use_nvim_cmp_as_default = true,
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
    per_filetype = {
      lua = { inherit_defaults = true, "lazydev" },
    },
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100, -- show at a higher priority than lsp
      },
      buffer = {
        opts = {
          -- get all buffers, even ones like neo-tree
          -- get_bufnrs = vim.api.nvim_list_bufs,
          -- or (recommended) filter to only "normal" buffers
          get_bufnrs = function()
            return vim.tbl_filter(function(bufnr)
              return vim.bo[bufnr].buftype == ""
            end, vim.api.nvim_list_bufs())
          end,
        },
      },
    },
  },
}

local blink_pairs_opts = {
  mappings = {
    enabled = true,
    cmdline = true,
    disabled_filetypes = {},
    wrap = {
      ["<C-b>"] = "motion",
      ["<C-S-b>"] = "motion_reverse",
    },
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

local ensure_installed = {
  "lua-language-server",
  "copilot-language-server",
  "emmylua_ls",
  "stylua",
  "marksman",
  "dockerfile-language-server",
  "docker-compose-language-service",
  "bash-language-server",
  "shfmt",
  "shellcheck",
  "hadolint",
  "html-lsp",
  "css-lsp",
  "eslint-lsp",
  "prettier",
  "biome",
  "vtsls",
  "vue-language-server",
  "js-debug-adapter",
  "json-lsp",
  "gopls",
  "goimports",
  "golines",
  "golangci-lint-langserver",
  "delve",
  "gomodifytags",
  "gotests",
  "iferr",
  "impl",
  "rust-analyzer",
  "jdtls",
  "java-debug-adapter",
  "java-test",
  "codelldb",
  "pyright",
  "taplo",
  "lemminx",
  "ruff",
  "yaml-language-server",
  "zls",
}

local structured_filetypes = {
  "bash",
  "c",
  "cpp",
  "css",
  "dockerfile",
  "go",
  "html",
  "java",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "lua",
  "markdown",
  "python",
  "rust",
  "sh",
  "toml",
  "tsx",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
  "zsh",
}

local tag_filetypes = {
  "astro",
  "blade",
  "eruby",
  "glimmer",
  "handlebars",
  "hbs",
  "heex",
  "html",
  "htmlangular",
  "htmldjango",
  "javascript",
  "javascriptreact",
  "liquid",
  "markdown",
  "php",
  "rescript",
  "svelte",
  "templ",
  "twig",
  "typescript",
  "typescriptreact",
  "vue",
  "xml",
}

local function rustacean_opts()
  local opts = {
    tools = {
      float_win_config = {
        border = "rounded",
      },
    },
    server = {
      on_attach = function(_, _) end,
      default_settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },
          checkOnSave = true,
          diagnostics = {
            enable = true,
          },
          procMacro = {
            enable = true,
            ignored = {
              ["async-trait"] = { "async_trait" },
              ["napi-derive"] = { "napi" },
              ["async-recursion"] = { "async_recursion" },
            },
          },
          files = {
            excludeDirs = {
              ".direnv",
              ".git",
              ".github",
              ".gitlab",
              "bin",
              "node_modules",
              "target",
              "venv",
              ".venv",
            },
          },
        },
      },
    },
  }

  if vim.fn.executable("rust-analyzer") == 0 then
    vim.schedule(function()
      vim.notify(
        "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
        vim.log.levels.ERROR,
        { title = "rustaceanvim" }
      )
    end)
  end

  local codelldb_path = vim.fn.exepath("codelldb")
  ---@diagnostic disable-next-line: undefined-field
  local this_os = vim.uv.os_uname().sysname
  local liblldb_path = vim.fn.expand("$HOME/.local/share/nvim/mason/share/lldb")

  if this_os:find("Windows") then
    liblldb_path = liblldb_path .. "\\bin\\lldb.dll"
  else
    liblldb_path = liblldb_path .. "/lib/liblldb" .. (this_os == "Linux" and ".so" or ".dylib")
  end

  opts.dap = {
    adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path),
  }

  return opts
end

return {
  { "nvim-lua/plenary.nvim" },
  { "kevinhwang91/promise-async" },
  { "saghen/blink.lib" },
  { "saghen/blink.download" },
  { "b0o/SchemaStore.nvim" },
  { "mfussenegger/nvim-jdtls", ft = "java" },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    init = function()
      _G.__setup_lazydev = function()
        require("lazy").load({ plugins = { "lazydev.nvim" }, wait = true })
      end
    end,
    opts = {
      library = {
        "~/.local/share/nvim/lazy/",
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
  },

  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonToolsInstall", "MasonUninstall", "MasonUpdate" },
    keys = {
      { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" },
    },
    opts = {
      pip = {
        upgrade_pip = true,
      },
      ui = {
        backdrop = 100,
        height = 0.65,
        width = 0.7,
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)

      local registry = require("mason-registry")
      registry:on("package:install:success", function()
        vim.defer_fn(function()
          vim.api.nvim_exec_autocmds("FileType", {
            buffer = vim.api.nvim_get_current_buf(),
            modeline = false,
          })
        end, 100)
      end)

      vim.api.nvim_create_user_command("MasonToolsInstall", function()
        local missing = {}
        registry.refresh(function()
          for _, tool in ipairs(ensure_installed) do
            local ok, pkg = pcall(registry.get_package, tool)
            if not ok then
              vim.notify(("Mason package not found: %s"):format(tool), vim.log.levels.WARN)
            elseif not pkg:is_installed() then
              missing[#missing + 1] = tool
              pkg:install()
            end
          end

          if #missing == 0 then
            vim.notify("All Mason tools are installed", vim.log.levels.INFO)
            return
          end

          vim.notify("Installing Mason tools: " .. table.concat(missing, ", "), vim.log.levels.INFO)
        end)
      end, {
        desc = "Install configured Mason tools",
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      function _G.__conform_formatexpr()
        require("lazy").load({ plugins = { "conform.nvim" }, wait = true })
        return require("conform").formatexpr()
      end

      vim.schedule(function()
        vim.o.formatexpr = "v:lua.__conform_formatexpr()"
      end)
    end,
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format()
        end,
        mode = { "n", "v", "x" },
        desc = "Format code using Conform",
      },
    },
    opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
      format_on_save = function(bufnr)
        if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
          return
        end
        return {
          lsp_format = "fallback",
          timeout_ms = 500,
        }
      end,
      formatters_by_ft = {
        javascript = { "biome", "prettier", stop_after_first = true },
        javascriptreact = { "biome", "prettier", stop_after_first = true },
        typescript = { "biome", "prettier", stop_after_first = true },
        typescriptreact = { "biome", "prettier", stop_after_first = true },
        css = { "biome", "prettier", stop_after_first = true },
        scss = { "biome", "prettier", stop_after_first = true },
        json = { "biome", "prettier", stop_after_first = true },
        html = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        go = { "goimports", "gofmt" },
        sql = { "sqruff" },
        rust = { "rustfmt" },
      },
      formatters = {
        prettier = {
          condition = function(_, ctx)
            return has_config(ctx, {
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.js",
              ".prettierrc.cjs",
              ".prettierrc.mjs",
              ".prettierrc.toml",
              "prettier.config.js",
              "prettier.config.cjs",
              "prettier.config.mjs",
            })
          end,
        },
        biome = {
          condition = function(_, ctx)
            return has_config(ctx, { "biome.json", "biome.jsonc" })
          end,
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        sh = { "shellcheck" },
        dockerfile = { "hadolint" },
        javascript = { "eslint" },
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
        javascriptreact = { "eslint" },
        go = { "golangcilint" },
      }

      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function(args)
          if vim.bo[args.buf].modifiable then
            lint.try_lint(nil, { ignore_errors = true })
          end
        end,
      })
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    init = function()
      _G.__setup_luasnip = function()
        require("lazy").load({ plugins = { "LuaSnip" }, wait = true })
        return require("luasnip")
      end
    end,
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
      vim.g.luasnip_setup_done = true
    end,
  },

  {
    "saghen/blink.pairs",
    version = "*",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = blink_pairs_opts,
  },

  {
    "nicholasxjy/colorful-menu.nvim",
    opts = colorful_menu_opts,
  },

  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    build = function()
      ---@diagnostic disable-next-line: undefined-field
      require("blink.cmp").build():wait(60000)
    end,
    dependencies = {
      "saghen/blink.lib",
      "saghen/blink.download",
      "L3MON4D3/LuaSnip",
      "nicholasxjy/colorful-menu.nvim",
      "nvim-mini/mini.icons",
    },
    init = function()
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
    end,
    opts = blink_opts,
    config = function(_, opts)
      if type(_G.__setup_luasnip) == "function" then
        _G.__setup_luasnip()
      end
      require("blink.cmp").setup(opts)
      vim.g.blink_setup_done = true
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    opts = {
      file_types = { "markdown" },
      completions = { blink = { enabled = false }, lsp = { enabled = true } },
      code = {
        width = "block",
        right_pad = 1,
      },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },

  {
    "arborist-ts/arborist.nvim",
    event = "VeryLazy",
    opts = {
      install_popular = true,
      update_cadence = "daily",
      overrides = {},
    },
  },

  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "windwp/nvim-ts-autotag",
    ft = tag_filetypes,
    opts = {},
  },

  {
    "andymass/vim-matchup",
    ft = structured_filetypes,
    main = "match-up",
    opts = {
      matchparen = {
        enabled = 1,
        nomode = "i",
        insert_timeout = 20,
        hi_background = 0,
        hi_surround_always = 0,
        offscreen = {
          method = "status",
        },
      },
      surround = {
        enabled = 1,
      },
      text_obj = {
        enabled = 1,
      },
      treesitter = {
        enabled = true,
        stopline = 300,
        enable_quotes = true,
        include_match_words = true,
        disable_virtual_text = true,
      },
    },
  },

  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^9",
    ft = "rust",
    init = function()
      vim.g.rustaceanvim = rustacean_opts
    end,
  },
}
