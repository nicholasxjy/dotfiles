vim.pack.add({
  "https://github.com/windwp/nvim-ts-autotag",
}, { load = false })

local loaded = false

local function load_ts_autotag()
  if loaded then
    return require("nvim-ts-autotag")
  end

  vim.cmd.packadd("nvim-ts-autotag")

  local ts_autotag = require("nvim-ts-autotag")
  ts_autotag.setup()

  loaded = true

  return ts_autotag
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TsAutotagDeferred", { clear = true }),
  once = true,
  pattern = {
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
  },
  callback = function()
    load_ts_autotag()
  end,
})
