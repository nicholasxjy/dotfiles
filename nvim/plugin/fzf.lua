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
    width = 1, -- window width
    row = 1, -- window row position (0=top, 1=bottom)
    -- col = 0.2,
    border = "none",
    backdrop = 90,
    preview = {
      border = "single",
      wrap = true,
      hidden = false,
      layout = "vertical",
      vertical = "up:50%",
    },
  },
})

-- fzflua.register_ui_select()

vim.keymap.set("n", "gd", fzflua.lsp_definitions, { desc = "Goto Definition" })
vim.keymap.set("n", "gD", fzflua.lsp_declarations, { desc = "Goto Declaration" })
vim.keymap.set("n", "gr", fzflua.lsp_references, { desc = "Goto References" })
vim.keymap.set("n", "gi", fzflua.lsp_implementations, { desc = "Goto Implementation" })
vim.keymap.set("n", "gy", fzflua.lsp_typedefs, { desc = "Goto TypeDefs" })
vim.keymap.set("n", "gI", fzflua.lsp_incoming_calls, { desc = "Incoming Calls" })
vim.keymap.set("n", "gO", fzflua.lsp_outgoing_calls, { desc = "Outgoing Calls" })

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

-- local vscode = {
--   winopts = {
--     height = 0.4, -- window height
--     width = 0.7, -- window width
--     row = 1, -- window row position (0=top, 1=bottom)
--     -- col = 0.2,
--     border = "none",
--     backdrop = 90,
--   },
-- }
--
-- vim.keymap.set("n", "<leader><space>", function()
--   fzflua.files({ winopts = vscode.winopts, previewer = false, git_icons = true, hidden = true, cwd_only = true })
-- end, {
--   desc = "Find Files",
--   silent = true,
--   nowait = true,
-- })
--
-- vim.keymap.set("n", "<leader>h", function()
--   fzflua.buffers({ winopts = vscode.winopts, previewer = false, sort_lastused = true, ignore_current_buffer = false })
-- end, { desc = "Find Buffers", silent = true, nowait = true })

vim.keymap.set("n", "<leader>r", fzflua.resume, { desc = "Resume Search" })
vim.keymap.set("n", "<leader>:", fzflua.commands, { desc = "Commands" })
vim.keymap.set("n", "<leader>/", fzflua.grep_curbuf, { desc = "Grep Curbuf" })
vim.keymap.set("n", "<leader>m", fzflua.marks, { desc = "Marks" })

vim.keymap.set("n", "<leader>fa", fzflua.autocmds, { desc = "Autocmds" })
vim.keymap.set("n", "<leader>fc", fzflua.colorschemes, { desc = "Colorschemes" })
vim.keymap.set("n", "<leader>fi", fzflua.filetypes, { desc = "Filetypes" })
vim.keymap.set("n", "<leader>fl", fzflua.loclist, { desc = "Location" })
vim.keymap.set("n", "<leader>fk", fzflua.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fh", fzflua.highlights, { desc = "Highlights" })
vim.keymap.set("n", "<leader>fr", fzflua.registers, { desc = "Registers" })
vim.keymap.set("n", "<leader>fu", fzflua.undotree, { desc = "Undos" })
vim.keymap.set("n", "<leader>fq", fzflua.quickfix, { desc = "Quickfix" })
-- git
vim.keymap.set("n", "<leader>gb", fzflua.git_branches, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gl", fzflua.git_commits, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gL", fzflua.git_bcommits, { desc = "Git Log Line" })
vim.keymap.set("n", "<leader>gs", fzflua.git_status, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gS", fzflua.git_stash, { desc = "Git Stash" })
vim.keymap.set("n", "<leader>gd", fzflua.git_hunks, { desc = "Git Diff (Hunks)" })
vim.keymap.set("n", "<leader>gf", fzflua.git_bcommits, { desc = "Git Log File" })

-- grep
vim.keymap.set("n", "<leader>sw", fzflua.grep_cword, { desc = "Grep word" })
vim.keymap.set("n", "<leader>sc", function()
  fzflua.grep_curbuf({ search = vim.fn.expand("<cword>") })
end, { desc = "Grep word in buffer" })
vim.keymap.set({ "x", "v" }, "<leader>sv", fzflua.grep_visual, { desc = "Grep Visual" })
vim.keymap.set("n", "<leader>sg", fzflua.live_grep, { desc = "Live Grep" })
