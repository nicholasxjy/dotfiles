vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
})
local fzflua = require("fzf-lua")

fzflua.setup({
  "border-fused",
  fzf_colors = true,
  defaults = {
    formatter = "path.filename_first",
  },
  winopts = {
    height = 1, -- window height
    width = 0.9, -- window width
    row = 1, -- window row position (0=top, 1=bottom)
    -- col = 0.2,
    border = "none",
    backdrop = 50,
    preview = {
      border = "rounded",
      wrap = true,
      hidden = false,
      layout = "vertical",
      vertical = "up:50%",
    },
  },
})

vim.keymap.set("n", "<leader>ss", fzflua.lsp_document_symbols, { desc = "Lsp symbols" })
vim.keymap.set("n", "<leader>sS", fzflua.lsp_workspace_symbols, { desc = "Workspace lsp symbols" })

vim.keymap.set("n", "<leader>xx", function()
  fzflua.diagnostics_document({ sort = true })
end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>xX", function()
  fzflua.diagnostics_workspace({ sort = true })
end, { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "<leader>xw", function()
  fzflua.diagnostics_workspace({ severity_limit = vim.diagnostic.severity.WARN, sort = true })
end, { desc = "Workspace Diagnostics(Warns)" })
vim.keymap.set("n", "<leader>xe", function()
  fzflua.diagnostics_workspace({ severity_limit = vim.diagnostic.severity.ERROR, sort = true })
end, { desc = "Workspace Diagnostics(Errors)" })
