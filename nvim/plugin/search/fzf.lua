local loader = require("loader")
local ui = require("ui")

local setup = function()
  loader.packadd("fzf-lua", "fzf-lua-smart")
  local fzflua = require("fzf-lua")
  local fzfluasmart = require("fzf-lua-smart")

  local opts = {
    "border-fused",
    fzf_colors = true,
    fzf_opts = {},
    winopts = {
      split = "belowright new",
      height = 0.85, -- window height
      width = 1, -- window width
      row = 0.35, -- window row position (0=top, 1=bottom)
      col = 0.50, -- window col position (0=left, 1=right)
      border = "none",
      backdrop = 100,
      treesitter = {
        enabled = true,
      },
      preview = {
        border = "rounded",
        title = true, -- preview border title (file/buf)?
        title_pos = "left", -- left|center|right, title alignment
        vertical = "down:55%", -- up|down:size
        horizontal = "right:50%", -- right|left:size
        layout = "vertical", -- horizontal|vertical|flex
      },
    },
    defaults = {
      formatter = "path.filename_first",
    },
  }

  fzflua.setup(opts)
  fzfluasmart.setup({
    matcher = {
      fuzzy = true,
      smartcase = true,
      ignorecase = true,
      sort_empty = true,
      filename_bonus = true,
      file_pos = true,
      cwd_bonus = true,
      frecency = true,
      history_bonus = true,
    },
    sort = { fields = { "score:desc", "#text", "idx" } },
    filter = { cwd = true }, -- restrict buffer/recent candidates to cwd
    hidden = true,
    multiprocess = true,
  })

  vim.keymap.set("n", "<leader><space>", function()
    fzfluasmart.smart({
      git_icons = true,
      hidden = true,
      filter = { cwd = true },
      matcher = { filename_bonus = true, cwd_bonus = true, frecency = true, history_bonus = true },
    })
  end, { desc = "Smart files" })

  vim.keymap.set("n", "<leader>h", function()
    fzflua.buffers({
      previewer = false,
      sort_lastused = true,
      ignore_current_buffer = false,
    })
  end, { desc = "Find Buffers", silent = true, nowait = true })

  vim.keymap.set("n", "<leader><cr>", fzflua.resume, { desc = "Resume Search" })

  vim.keymap.set("n", "<leader>:", fzflua.commands, { desc = "Commands" })
  vim.keymap.set("n", "<leader>/", fzflua.grep_curbuf, { desc = "Grep Curbuf" })
  vim.keymap.set("n", "<leader>m", fzflua.marks, { desc = "Marks" })

  vim.keymap.set("n", "<leader>fa", fzflua.autocmds, { desc = "Autocmds" })
  vim.keymap.set("n", "<leader>fC", fzflua.colorschemes, { desc = "Colorschemes" })
  vim.keymap.set("n", "<leader>fc", fzflua.command_history, { desc = "Command History" })
  vim.keymap.set("n", "<leader>fi", fzflua.filetypes, { desc = "Filetypes" })
  vim.keymap.set("n", "<leader>fl", fzflua.loclist, { desc = "Location" })
  vim.keymap.set("n", "<leader>fk", fzflua.keymaps, { desc = "Keymaps" })
  vim.keymap.set("n", "<leader>fh", fzflua.highlights, { desc = "Highlights" })
  vim.keymap.set("n", "<leader>fr", fzflua.registers, { desc = "Registers" })
  vim.keymap.set("n", "<leader>fu", fzflua.undotree, { desc = "Undos" })
  vim.keymap.set("n", "<leader>fq", fzflua.quickfix, { desc = "Quickfix" })
  vim.keymap.set("n", "<leader>fs", fzflua.search_history, { desc = "Search History" })
  -- git
  vim.keymap.set("n", "<leader>gb", fzflua.git_branches, { desc = "Git Branches" })
  vim.keymap.set("n", "<leader>gl", fzflua.git_commits, { desc = "Git Log" })
  vim.keymap.set("n", "<leader>gL", fzflua.git_bcommits, { desc = "Git Log Line" })
  vim.keymap.set("n", "<leader>gs", fzflua.git_status, { desc = "Git Status" })
  vim.keymap.set("n", "<leader>gS", fzflua.git_stash, { desc = "Git Stash" })
  vim.keymap.set("n", "<leader>gd", fzflua.git_hunks, { desc = "Git Diff (Hunks)" })
  vim.keymap.set("n", "<leader>gf", fzflua.git_bcommits, { desc = "Git Log File" })

  vim.keymap.set("n", "<leader>sw", fzflua.grep_cword, { desc = "Grep word" })
  vim.keymap.set({ "x", "v" }, "<leader>sv", fzflua.grep_visual, { desc = "Grep Visual" })
  vim.keymap.set("n", "<leader>sg", fzflua.live_grep, { desc = "Live Grep" })
  vim.keymap.set("n", "<leader>xt", "<cmd>TodoFzfLua<cr>", { desc = "TODO/FIXME/NOTE etc" })
end

loader.on_very_lazy("fzf", setup)
