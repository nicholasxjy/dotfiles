local loader = require("loader")

-- ============================================================================
-- Completion & Snippets (Eager for LSP capabilities)
-- ============================================================================
loader.packadd("blink.lib", "blink.cmp")

-- Configure lazydev for Neovim / Lua development
loader.defer("lazydev", function()
  loader.packadd("lazydev.nvim")
  require("lazydev").setup({
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  })
end, "FileType", { pattern = "lua" })

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
        columns = { { "kind_icon", gap = 1 }, { "label", "label_description", gap = 1 }, { "kind" } },
        components = {
          label = { width = { max = 32 } },
          label_description = { width = { max = 16 } },
          kind_icon = {
            text = function(ctx)
              if ctx.source_name == "Path" then
                local icon = require("mini.icons").get("file", ctx.label)
                return icon .. ctx.icon_gap
              end
              return ctx.kind_icon .. ctx.icon_gap
            end,
            highlight = function(ctx)
              if ctx.source_name == "Path" then
                local _, hl = require("mini.icons").get("file", ctx.label)
                return hl
              end
              return ctx.kind_hl
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
    default = { "lsp", "path", "snippets", "buffer" },
    per_filetype = {
      lua = { "lazydev", "lsp", "path", "snippets", "buffer" },
    },
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

-- ============================================================================
-- Treesitter (Decorate first buffer render)
-- ============================================================================
local languages = {
  "astro",
  "c",
  "comment",
  "css",
  "csv",
  "diff",
  "dockerfile",
  "fish",
  "git_config",
  "gitcommit",
  "gitignore",
  "go",
  "graphql",
  "html",
  "javascript",
  "jq",
  "jsdoc",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "query",
  "regex",
  "scss",
  "sql",
  "tsx",
  "typescript",
  "yaml",
  "rust",
  "toml",
}

local function install_configured()
  local installed = {}
  for _, lang in ipairs(require("nvim-treesitter.config").get_installed("parsers")) do
    installed[lang] = true
  end

  local missing = vim.tbl_filter(function(lang)
    return not installed[lang]
  end, languages)

  if #missing > 0 then
    require("nvim-treesitter").install(missing)
  end
end

local function setup_treesitter()
  loader.packadd("rainbow-delimiters.nvim", "nvim-treesitter")

  vim.g.rainbow_delimiters = {
    strategy = {
      [""] = "rainbow-delimiters.strategy.global",
      vim = "rainbow-delimiters.strategy.local",
    },
    query = {
      [""] = "rainbow-delimiters",
      lua = "rainbow-blocks",
    },
    priority = {
      [""] = 110,
      lua = 210,
    },
    highlight = {
      "RainbowDelimiterRed",
      "RainbowDelimiterYellow",
      "RainbowDelimiterBlue",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    },
  }

  local function attach_ts(buf, ft)
    local lang = vim.treesitter.language.get_lang(ft)
    if lang and vim.treesitter.language.add(lang) then
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      pcall(vim.treesitter.start, buf, lang)
    end
  end

  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      attach_ts(args.buf, args.match)
    end,
  })

  -- Attach to existing buffer if already loaded
  local cur = vim.api.nvim_get_current_buf()
  if vim.api.nvim_buf_is_valid(cur) and vim.bo[cur].buftype == "" and vim.bo[cur].filetype ~= "" then
    attach_ts(cur, vim.bo[cur].filetype)
  end
end

loader.defer_buffer("treesitter", setup_treesitter)

vim.api.nvim_create_user_command("TSInstallConfigured", function()
  if loader.load("treesitter", setup_treesitter) then
    install_configured()
  end
end, { desc = "Install configured Treesitter parsers" })

-- ============================================================================
-- Syntax Tools (Autotag, Matchup, Illuminate, ts-comments)
-- ============================================================================
loader.defer_buffer("coding-tools", function()
  loader.packadd("nvim-ts-autotag", "vim-matchup", "vim-illuminate", "ts-comments.nvim")

  -- TS Comments
  require("ts-comments").setup()

  -- Autotag
  require("nvim-ts-autotag").setup()

  -- Matchup
  require("match-up").setup({
    matchparen = {
      enabled = 1,
      deferred = 1,
      timeout = 50,
      nomode = "i",
      insert_timeout = 20,
      hi_background = 1,
      hi_surround_always = 0,
      offscreen = {
        method = "status",
      },
    },
    surround = { enabled = 1 },
    text_obj = { enabled = 1 },
    treesitter = {
      enabled = true,
      stopline = 300,
      enable_quotes = true,
      include_match_words = true,
      disable_virtual_text = true,
    },
  })

  -- Illuminate
  local filetypes_denylist = {
    "dirbuf",
    "dirvish",
    "fugitive",
    "markdown",
    "minifiles",
    "fyler_finder",
    "minibuffer",
    "neo-tree",
  }

  require("illuminate").configure({
    providers = { "lsp", "treesitter", "regex" },
    delay = 250,
    filetypes_denylist = filetypes_denylist,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { "lsp" },
      filetypes_denylist = filetypes_denylist,
      under_cursor = false,
    },
  })

  vim.keymap.set("n", "]]", function()
    require("illuminate").goto_next_reference()
  end, { desc = "Next reference" })

  vim.keymap.set("n", "[[", function()
    require("illuminate").goto_prev_reference()
  end, { desc = "Prev reference" })
end, { schedule = true })

-- ============================================================================
-- Autopairs
-- ============================================================================
loader.on_very_lazy("autopairs", function()
  loader.packadd("nvim-autopairs")
  local npairs = require("nvim-autopairs")
  npairs.setup()
  local Rule = require("nvim-autopairs.rule")
  local cond = require("nvim-autopairs.conds")
  local ts_conds = require("nvim-autopairs.ts-conds")

  local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
  npairs.add_rules({
    Rule(" ", " ", "-markdown")
      :with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({
          brackets[1][1] .. brackets[1][2],
          brackets[2][1] .. brackets[2][2],
          brackets[3][1] .. brackets[3][2],
        }, pair)
      end)
      :with_move(cond.none())
      :with_cr(cond.none())
      :with_del(function(opts)
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local context = opts.line:sub(col - 1, col + 2)
        return vim.tbl_contains({
          brackets[1][1] .. "  " .. brackets[1][2],
          brackets[2][1] .. "  " .. brackets[2][2],
          brackets[3][1] .. "  " .. brackets[3][2],
        }, context)
      end),
  })

  for _, bracket in pairs(brackets) do
    npairs.add_rules({
      Rule(bracket[1] .. " ", " " .. bracket[2])
        :with_pair(function()
          return false
        end)
        :with_del(function()
          return false
        end)
        :with_move(function(opts)
          return opts.prev_char:match(".%" .. bracket[2]) ~= nil
        end)
        :use_key(bracket[2]),
      Rule(bracket[1], bracket[2]):with_pair(cond.after_text("$")),
      Rule(bracket[1] .. bracket[2], ""):with_pair(function()
        return false
      end):with_cr(function()
        return false
      end),
    })
  end

  npairs.add_rule(Rule("$", "$", "markdown")
    :with_move(function(opts)
      return opts.next_char == opts.char
        and ts_conds.is_ts_node({
          "inline_formula",
          "displayed_equation",
          "math_environment",
        })(opts)
    end)
    :with_pair(ts_conds.is_not_ts_node({
      "inline_formula",
      "displayed_equation",
      "math_environment",
    }))
    :with_pair(cond.not_before_text("\\")))

  npairs.add_rule(Rule("/**", "  */"):with_pair(cond.not_after_regex(".%*/", -1)):set_end_pair_length(3))

  npairs.add_rule(Rule("**", "**", "markdown"):with_move(function(opts)
    return cond.after_text("*")(opts) and cond.not_before_text("\\")(opts)
  end))
end)
