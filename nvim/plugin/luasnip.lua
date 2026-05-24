local util = require("util")

util.build_cmd_on_change("LuaSnip", { "install", "update" }, { "make", "install_jsregexp" })

local function setup_luasnip()
  if vim.g.luasnip_setup_done then
    return require("luasnip")
  end

  util.packadd("friendly-snippets", false)
  util.ensure_plugin("LuaSnip", function()
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
  end)

  return require("luasnip")
end

_G.__setup_luasnip = setup_luasnip

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("LuaSnipDeferredSetup", { clear = true }),
  once = true,
  callback = setup_luasnip,
})
