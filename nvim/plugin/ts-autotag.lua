local util = require("util")

local function setup_autotag()
  util.ensure_plugin("nvim-ts-autotag", function()
    require("nvim-ts-autotag").setup()
  end)
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
  callback = setup_autotag,
})
