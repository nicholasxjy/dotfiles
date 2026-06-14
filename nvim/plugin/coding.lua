vim.pack.add({
  "https://github.com/b0o/SchemaStore.nvim",
})

vim.pack.add({
  "https://github.com/mfussenegger/nvim-jdtls",
}, { load = false })

vim.api.nvim_create_autocmd("FileType", {
  once = true,
  pattern = "java",
  callback = function()
    vim.cmd.packadd("nvim-jdtls")
  end,
})

vim.pack.add({
  "https://github.com/windwp/nvim-ts-autotag",
})

local ts_autotag = require("nvim-ts-autotag")
ts_autotag.setup()
