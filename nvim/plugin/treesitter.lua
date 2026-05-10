local util = require("util")

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
  "java",
  "toml",
  "rust",
}

util.build_ex_on_change("nvim-treesitter", { "install", "update" }, "TSUpdate")

local ts
local installed_cache = {}
local available_cache = {}
local caches_ready = false
local textobjects_ready = false
local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

local function get_ts()
  ts = ts or require("nvim-treesitter")
  return ts
end

local function reset_caches()
  installed_cache = {}
  available_cache = {}
  caches_ready = false
end

local function ensure_caches()
  if caches_ready then
    return get_ts()
  end

  local ts_mod = get_ts()
  reset_caches()

  for _, lang in ipairs(ts_mod.get_installed()) do
    installed_cache[lang] = true
  end

  for _, lang in ipairs(ts_mod.get_available()) do
    available_cache[lang] = true
  end

  caches_ready = true
  return ts_mod
end

local function collect_missing_languages()
  local ts_mod = ensure_caches()
  local missing = {}

  for _, lang in ipairs(languages) do
    if available_cache[lang] and not installed_cache[lang] then
      missing[#missing + 1] = lang
    end
  end

  return ts_mod, missing
end

local function install_configured_languages()
  local ts_mod, missing = collect_missing_languages()
  if #missing == 0 then
    vim.notify("All configured Tree-sitter parsers are installed", vim.log.levels.INFO)
    return
  end

  for _, lang in ipairs(missing) do
    installed_cache[lang] = true
  end

  ts_mod.install(missing)
  vim.notify("Installing Tree-sitter parsers: " .. table.concat(missing, ", "), vim.log.levels.INFO)
end

local include_surrounding_whitespace = {
  ["@function.outer"] = true,
  ["@class.outer"] = true,
  ["@parameter.outer"] = true,
}

local function ensure_textobjects()
  if textobjects_ready then
    return require("nvim-treesitter-textobjects.select")
  end
  textobjects_ready = true

  vim.g.no_plugin_maps = true
  require("nvim-treesitter-textobjects").setup({
    select = {
      include_surrounding_whitespace = function(capture)
        return include_surrounding_whitespace[capture.query_string] or false
      end,
    },
  })

  return require("nvim-treesitter-textobjects.select")
end

vim.api.nvim_create_user_command("TSInstallConfigured", install_configured_languages, {
  desc = "Install configured Tree-sitter parsers",
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  desc = "Enable highlight and indent",
  callback = function(ev)
    local ts_mod = ensure_caches()
    local lang = vim.treesitter.language.get_lang(ev.match)
    if not (lang and available_cache[lang] and installed_cache[lang]) then
      return
    end

    vim.treesitter.start()
    ts_mod.indentexpr()
  end,
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" then
      reset_caches()
      ensure_caches().update()
    end
  end,
})

local map = vim.keymap.set

local function textobj_map(key, query)
  local outer = "@" .. query .. ".outer"
  local inner = "@" .. query .. ".inner"
  local opts = {
    desc = "Selection for " .. query .. " text objects",
    silent = true,
  }

  map({ "x", "o" }, "i" .. key, function()
    ensure_textobjects().select_textobject(inner)
  end, opts)

  map({ "x", "o" }, "a" .. key, function()
    ensure_textobjects().select_textobject(outer)
  end, opts)
end

textobj_map("$", "math")
textobj_map("m", "math")
textobj_map("f", "call")
textobj_map("F", "function")
textobj_map("L", "loop")
textobj_map("c", "conditional")
textobj_map("C", "class")
textobj_map("/", "comment")
textobj_map("a", "parameter")
textobj_map("r", "return")
