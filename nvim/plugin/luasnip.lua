local util = require("util")

util.build_cmd_on_change("LuaSnip", { "install", "update" }, { "make", "install_jsregexp" })

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
