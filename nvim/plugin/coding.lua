vim.pack.add({
  "https://github.com/b0o/SchemaStore.nvim",
})

vim.pack.add({
  "https://github.com/mfussenegger/nvim-jdtls",
})

vim.pack.add({
  "https://github.com/windwp/nvim-ts-autotag",
})

local ts_autotag = require("nvim-ts-autotag")
ts_autotag.setup()
