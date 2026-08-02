local loader = require("loader")

local setup = function()
  vim.cmd.packadd("fzf-lua")
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

  -- fzflua.register_ui_select()

  -- local vscode = {
  --   winopts = {
  --     height = 0.4, -- window height
  --     width = 0.7, -- window width
  --     row = 1, -- window row position (0=top, 1=bottom)
  --     -- col = 0.2,
  --     border = "none",
  --     backdrop = 50,
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

  -- vim.keymap.set("n", "<leader>r", fzflua.resume, { desc = "Resume Search" })
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

  -- vim.keymap.set("n", "<leader>sw", fzflua.grep_cword, { desc = "Grep word" })
  -- vim.keymap.set({ "x", "v" }, "<leader>sv", fzflua.grep_visual, { desc = "Grep Visual" })
  -- vim.keymap.set("n", "<leader>sg", fzflua.live_grep, { desc = "Live Grep" })
end

loader.defer("fzf", setup)
