local loader = require("loader")

-- ============================================================================
-- Completion & Snippets (blink.cmp is packadded eagerly by lua/lsp.lua)
-- ============================================================================
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

-- Keep capabilities eager; initialize completion before its first input event.
local function setup_completion()
  loader.packadd("LuaSnip")
  require("blink.cmp").setup(blink_opts)
end

loader.defer("completion", setup_completion, { "InsertEnter", "CmdlineEnter" })

local function setup_snippets()
  loader.packadd("friendly-snippets")
  local ls = require("luasnip")
  ls.config.set_config({
    enable_autosnippets = true,
    keep_roots = true,
    link_roots = true,
    exit_roots = false,
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
  -- Set before packadd so rainbow-delimiters reads it on its first attach.
  vim.g.rainbow_delimiters = {
    -- Global rainbow queries scan the whole tree synchronously on attach.
    condition = function(bufnr)
      local lines = vim.api.nvim_buf_line_count(bufnr)
      return lines <= 5000 and vim.api.nvim_buf_get_offset(bufnr, lines) <= 512 * 1024
    end,
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
  loader.packadd("rainbow-delimiters.nvim", "nvim-treesitter")

  local function attach_ts(buf, ft)
    local lang = vim.treesitter.language.get_lang(ft)
    if lang and vim.treesitter.language.add(lang) then
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      pcall(vim.treesitter.start, buf, lang)
    end
  end

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("sjvim_treesitter", { clear = true }),
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

vim.api.nvim_create_user_command("RainbowDelimitersEnable", function()
  if loader.load("treesitter", setup_treesitter) then
    require("rainbow-delimiters").enable(0)
  end
end, { desc = "Enable rainbow delimiters in this buffer, including large files" })

vim.api.nvim_create_user_command("TSInstallConfigured", function()
  if loader.load("treesitter", setup_treesitter) then
    install_configured()
  end
end, { desc = "Install configured Treesitter parsers" })

-- Commenting needs mappings even when starting without a file.
loader.on_very_lazy("mini-comment", function()
  loader.packadd("mini.comment")
  require("mini.comment").setup()
end)

-- Pattern and hex color highlights attach to real file buffers.
loader.defer_buffer("mini-hipatterns", function()
  loader.packadd("mini.hipatterns")
  local hipatterns = require("mini.hipatterns")
  hipatterns.setup({
    highlighters = {
      fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
      hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
      todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
      note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end, { schedule = true })

-- ============================================================================
-- Syntax Tools (Autotag, Matchup, Illuminate)
-- ============================================================================
-- Matchup must load before FileType to initialize the first buffer and its mappings.
-- Its Lua setup helper only sets globals, so set them before packadd.
vim.g.matchup_matchparen_enabled = 1
vim.g.matchup_matchparen_deferred = 1
vim.g.matchup_matchparen_timeout = 50
vim.g.matchup_matchparen_nomode = "i"
vim.g.matchup_matchparen_insert_timeout = 20
vim.g.matchup_matchparen_hi_background = 0
vim.g.matchup_matchparen_hi_surround_always = 0
vim.g.matchup_matchparen_offscreen = { method = "status" }
vim.g.matchup_surround_enabled = 1
vim.g.matchup_text_obj_enabled = 1
vim.g.matchup_treesitter_enabled = true
vim.g.matchup_treesitter_stopline = 300
vim.g.matchup_treesitter_enable_quotes = true
vim.g.matchup_treesitter_include_match_words = true
vim.g.matchup_treesitter_disable_virtual_text = true
loader.packadd("vim-matchup")

local function setup_coding_tools()
  loader.packadd("nvim-ts-autotag", "vim-illuminate")

  -- Autotag
  require("nvim-ts-autotag").setup()

  -- Illuminate
  local filetypes_denylist = {
    "dirbuf",
    "dirvish",
    "fugitive",
    "markdown",
    "oil",
    "minifiles",
    "snacks_picker_input",
    "snacks_picker_list",
    "snacks_picker_preview",
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
end

loader.defer_buffer("coding-tools", setup_coding_tools, { schedule = true })

for _, direction in ipairs({
  { "]]", "goto_next_reference", "Next reference" },
  { "[[", "goto_prev_reference", "Prev reference" },
}) do
  vim.keymap.set("n", direction[1], function()
    if loader.load("coding-tools", setup_coding_tools) then
      require("illuminate")[direction[2]]()
    end
  end, { desc = direction[3] })
end

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
