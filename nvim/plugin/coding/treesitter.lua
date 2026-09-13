local loader = require("loader")

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

local parsers_checked = false

--- Install only what is actually missing. `install()` on the full list spawns a
--- job per language even when everything is already on disk, which showed up as
--- a stall on the first buffer of every session.
local function install_configured(force)
  if parsers_checked and not force then
    return
  end

  parsers_checked = true

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

local setup = function()
  vim.api.nvim_create_autocmd("FileType", { -- enable treesitter highlighting and indents
    callback = function(args)
      local filetype = args.match
      local lang = vim.treesitter.language.get_lang(filetype)
      if lang and vim.treesitter.language.add(lang) then
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.treesitter.start(args.buf, lang)
      end
    end,
  })

  loader.packadd("nvim-treesitter")
end

loader.defer_buffer("treesitter", setup)

-- Defer missing parser audit to VeryLazy so opening the first buffer stays instant
loader.on_very_lazy("treesitter-parsers", function()
  if loader.load("treesitter", setup) then
    install_configured()
  end
end)

vim.api.nvim_create_user_command("TSInstallConfigured", function()
  if loader.load("treesitter", setup) then
    install_configured(true)
  end
end, { desc = "Install configured Treesitter parsers" })
