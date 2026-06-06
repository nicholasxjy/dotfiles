vim.pack.add({
  "https://github.com/nicholasxjy/rainbow-tags.nvim",
}, { load = false })

local loaded = false

local function load_rainbow_tags()
  if loaded then
    return require("rainbow-tags")
  end

  vim.cmd.packadd("rainbow-tags.nvim")

  local rainbow_tags = require("rainbow-tags")

  rainbow_tags.setup({
    enabled = true,
    filetypes = { "typescriptreact", "javascriptreact", "tsx" },
    lang = "tsx",
    include_intrinsic = true,
    strategy = "name",
    create_default_highlights = true,
    highlight_groups = {
      "RainbowDelimiterRed",
      "RainbowDelimiterCyan",
      "RainbowDelimiterYellow",
      "RainbowDelimiterGreen",
      "RainbowDelimiterOrange",
      "RainbowDelimiterViolet",
      "RainbowDelimiterBlue",
    },
  })

  loaded = true

  return rainbow_tags
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescriptreact", "javascriptreact", "tsx" },
  once = true,
  callback = function()
    load_rainbow_tags()
  end,
})
