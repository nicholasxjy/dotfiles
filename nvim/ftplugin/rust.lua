local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<leader>ca", function()
  vim.cmd.RustLsp("codeAction")
end, { desc = "Code Action", buffer = bufnr, remap = true })

vim.keymap.set("n", "<leader>dr", function()
  vim.cmd.RustLsp("debuggables")
end, { desc = "Rust Debuggables", buffer = bufnr })

-- vim.keymap.set("n", "K", function()
--   vim.cmd.RustLsp({ "hover", "actions" })
-- end, { silent = true, buffer = bufnr })
