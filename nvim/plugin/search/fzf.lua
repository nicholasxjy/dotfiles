local loader = require("loader")
local ui = require("ui")

local setup = function()
  loader.packadd("fzf-lua")
  local fzflua = require("fzf-lua")

  fzflua.setup({
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
  })

  -- fzflua.register_ui_select()

  local minibuffer_win_opts = function()
    return {
      height = 0.3,
      width = 1,
      -- row = 0.35,
      -- col = 0.50,
      border = "none",
      backdrop = 100,
      relative = "minibuffer",
      use_minibuffer = true,
      winhl = true,
    }
  end

  local fzf_mb = require("minibuffer.integrations.fzf_lua")

  -- vim.keymap.set("n", "<leader><space>", function()
  --   fzf_mb.files({
  --     smart = {
  --       filename_bonus = true,
  --       cwd_bonus = true,
  --       frecency = true,
  --       history_bonus = true,
  --       query_delay = 30,
  --     },
  --     winopts = vim.tbl_extend("force", minibuffer_win_opts(), { row = 0 }),
  --     previewer = "hidden",
  --     git_icons = true,
  --     hidden = true,
  --     cwd_only = true,
  --   })
  -- end, {
  --   desc = "Find Files",
  --   silent = true,
  --   nowait = true,
  -- })
  --
  -- vim.keymap.set("n", "<leader>h", function()
  --   fzflua.buffers({
  --     winopts = minibuffer_win_opts(),
  --     previewer = false,
  --     sort_lastused = true,
  --     ignore_current_buffer = false,
  --   })
  -- end, { desc = "Find Buffers", silent = true, nowait = true })
  --
  -- vim.keymap.set("n", "<leader><cr>", fzflua.resume, { desc = "Resume Search" })

  vim.keymap.set("n", "<leader>:", fzflua.commands, { desc = "Commands" })
  vim.keymap.set("n", "<leader>/", fzflua.grep_curbuf, { desc = "Grep Curbuf" })
  vim.keymap.set("n", "<leader>m", function()
    fzflua.marks({ winopts = minibuffer_win_opts(), previewer = false })
  end, { desc = "Marks" })

  vim.keymap.set("n", "<leader>fa", fzflua.autocmds, { desc = "Autocmds" })
  vim.keymap.set("n", "<leader>fC", fzflua.colorschemes, { desc = "Colorschemes" })
  vim.keymap.set("n", "<leader>fc", function()
    fzflua.command_history({ winopts = minibuffer_win_opts() })
  end, { desc = "Command History" })
  vim.keymap.set("n", "<leader>fi", fzflua.filetypes, { desc = "Filetypes" })
  vim.keymap.set("n", "<leader>fl", fzflua.loclist, { desc = "Location" })
  vim.keymap.set("n", "<leader>fk", fzflua.keymaps, { desc = "Keymaps" })
  vim.keymap.set("n", "<leader>fh", fzflua.highlights, { desc = "Highlights" })
  vim.keymap.set("n", "<leader>fr", fzflua.registers, { desc = "Registers" })
  vim.keymap.set("n", "<leader>fu", fzflua.undotree, { desc = "Undos" })
  vim.keymap.set("n", "<leader>fq", fzflua.quickfix, { desc = "Quickfix" })
  vim.keymap.set("n", "<leader>fs", function()
    fzflua.search_history({ winopts = minibuffer_win_opts() })
  end, { desc = "Search History" })
  -- git
  vim.keymap.set("n", "<leader>gb", fzflua.git_branches, { desc = "Git Branches" })
  vim.keymap.set("n", "<leader>gl", fzflua.git_commits, { desc = "Git Log" })
  vim.keymap.set("n", "<leader>gL", fzflua.git_bcommits, { desc = "Git Log Line" })
  vim.keymap.set("n", "<leader>gs", fzflua.git_status, { desc = "Git Status" })
  vim.keymap.set("n", "<leader>gS", fzflua.git_stash, { desc = "Git Stash" })
  vim.keymap.set("n", "<leader>gd", fzflua.git_hunks, { desc = "Git Diff (Hunks)" })
  vim.keymap.set("n", "<leader>gf", fzflua.git_bcommits, { desc = "Git Log File" })

  -- vim.keymap.set("n", "<leader>sw", function()
  --   fzflua.grep_cword({ winopts = minibuffer_win_opts() })
  -- end, { desc = "Grep word" })
  -- vim.keymap.set({ "x", "v" }, "<leader>sv", function()
  --   fzflua.grep_visual({ winopts = minibuffer_win_opts() })
  -- end, { desc = "Grep Visual" })
  -- vim.keymap.set("n", "<leader>sg", function()
  --   fzflua.live_grep({ winopts = minibuffer_win_opts() })
  -- end, { desc = "Live Grep" })
end

loader.on_very_lazy("fzf", setup)
