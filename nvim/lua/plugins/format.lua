local util = require("utils.util")

local supported = {
  "css",
  "graphql",
  "handlebars",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "less",
  "markdown",
  "markdown.mdx",
  "scss",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}
--- Checks if a Prettier config file exists for the given context
local has_prettier_config = function(ctx)
  vim.fn.system({ "prettier", "--find-config-path", ctx.filename })
  return vim.v.shell_error == 0
end

--- Checks if a parser can be inferred for the given context:
--- * If the filetype is in the supported list, return true
--- * Otherwise, check if a parser can be inferred
local has_prettier_parser = function(ctx)
  local ft = vim.bo[ctx.buf].filetype --[[@as string]]
  -- default filetypes are always supported
  if vim.tbl_contains(supported, ft) then
    return true
  end
  -- otherwise, check if a parser can be inferred
  local ret = vim.fn.system({ "prettier", "--file-info", ctx.filename })
  ---@type boolean, string?
  local ok, parser = pcall(function()
    return vim.fn.json_decode(ret).inferredParser
  end)
  return ok and parser and parser ~= vim.NIL
end

local cache_has_prettier_config = util.memoize(has_prettier_config)
local cache_has_prettier_parser = util.memoize(has_prettier_parser)

local has_biome_config = util.file_exists_in_root("biome.json") or util.file_exists_in_root("biome.jsonc")

return {
  {

    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(supported) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "prettier")
        table.insert(opts.formatters_by_ft[ft], "biome")
      end

      opts.formatters = opts.formatters or {}
      opts.formatters.prettier = {
        condition = function(_, ctx)
          return cache_has_prettier_parser(ctx) and cache_has_prettier_config(ctx)
        end,
      }

      opts.formatters.biome = {
        condition = function(_, _)
          return has_biome_config
        end,
      }
    end,
  },
}
