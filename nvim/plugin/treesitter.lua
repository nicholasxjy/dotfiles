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
local install_scheduled = false
local textobjects_ready = false
local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

local function get_ts()
  ts = ts or require("nvim-treesitter")
  return ts
end

local function ensure_caches()
  if caches_ready then
    return get_ts()
  end

  local ts_mod = get_ts()
  for _, lang in ipairs(ts_mod.get_installed()) do
    installed_cache[lang] = true
  end

  for _, lang in ipairs(ts_mod.get_available()) do
    available_cache[lang] = true
  end

  caches_ready = true
  return ts_mod
end

local function ensure_missing_installed()
  if install_scheduled then
    return
  end
  install_scheduled = true

  vim.schedule(function()
    local ts_mod = ensure_caches()
    local missing = {}

    for _, lang in ipairs(languages) do
      if available_cache[lang] and not installed_cache[lang] then
        missing[#missing + 1] = lang
        installed_cache[lang] = true
      end
    end

    if #missing > 0 then
      ts_mod.install(missing)
    end
  end)
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

util.later(ensure_missing_installed, 20, "VimEnter", true)

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  desc = "Enable highlight and indent",
  callback = function(ev)
    local ts_mod = ensure_caches()
    local lang = vim.treesitter.language.get_lang(ev.match)
    if lang and available_cache[lang] then
      if not installed_cache[lang] then
        ts_mod.install(lang)
        installed_cache[lang] = true
      end
      vim.treesitter.start()
      ts_mod.indentexpr()
    end
  end,
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function()
    ensure_caches().update()
  end,
})

local map = vim.keymap.set

-- Globally map Tree-sitter text object binds
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
