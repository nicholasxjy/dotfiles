local loader = require("loader")
local ui = require("ui")

local setup = function()
  loader.packadd("fzf-lua", "minibuffer.nvim")
  local fzflua = require("fzf-lua")
  local opts = {
    "border-fused",
    fzf_colors = true,
    fzf_opts = {
      ["--no-separator"] = true,
    },
    defaults = {
      formatter = "path.filename_first",
    },
    hls = {
      normal = "Normal",
    },
    buffers = {
      previewer = "hidden",
    },
    grep = {
      previewer = "hidden",
    },
    live_grep = {
      previewer = "hidden",
    },
    lsp = {
      previewer = "hidden",
      symbols = {
        symbols_icons = ui.icons.lspkind_kind_icons,
      },
    },
    keymap = {
      builtin = { ["alt-k"] = "toggle-preview" },
      fzf = { ["alt-k"] = "toggle-preview" },
    },
  }
  require("fzf-lua").setup(opts)

  -- vim.keymap.set("n", "<leader><space>", function()
  --   mb_fzf.files({
  --     git_icons = true,
  --     smart = {
  --       filename_bonus = true,
  --       cwd_bonus = true,
  --       frecency = true,
  --       history_bonus = true,
  --       query_delay = 30,
  --     },
  --   })
  -- end, { desc = "Smart files" })
  --
  -- vim.keymap.set("n", "<leader>h", function()
  --   fzflua.buffers({
  --     previewer = false,
  --     sort_lastused = true,
  --     ignore_current_buffer = false,
  --   })
  -- end, { desc = "Find Buffers", silent = true, nowait = true })

  -- vim.keymap.set("n", "<leader><cr>", fzflua.resume, { desc = "Resume Search" })

  vim.keymap.set("n", "<leader>:", fzflua.commands, { desc = "Commands" })
  vim.keymap.set("n", "<leader>/", fzflua.grep_curbuf, { desc = "Grep Curbuf" })
  vim.keymap.set("n", "<leader>m", function()
    fzflua.marks()
  end, { desc = "Marks" })

  vim.keymap.set("n", "<leader>fa", fzflua.autocmds, { desc = "Autocmds" })
  vim.keymap.set("n", "<leader>fC", fzflua.colorschemes, { desc = "Colorschemes" })
  vim.keymap.set("n", "<leader>fc", function()
    fzflua.command_history()
  end, { desc = "Command History" })
  vim.keymap.set("n", "<leader>fi", fzflua.filetypes, { desc = "Filetypes" })
  vim.keymap.set("n", "<leader>fl", fzflua.loclist, { desc = "Location" })
  vim.keymap.set("n", "<leader>fk", fzflua.keymaps, { desc = "Keymaps" })
  vim.keymap.set("n", "<leader>fh", fzflua.highlights, { desc = "Highlights" })
  vim.keymap.set("n", "<leader>fr", fzflua.registers, { desc = "Registers" })
  vim.keymap.set("n", "<leader>fu", fzflua.undotree, { desc = "Undos" })
  vim.keymap.set("n", "<leader>fq", fzflua.quickfix, { desc = "Quickfix" })
  vim.keymap.set("n", "<leader>fs", function()
    fzflua.search_history()
  end, { desc = "Search History" })
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

loader.on_very_lazy("fzf", setup)
