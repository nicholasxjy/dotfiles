local loader = require("loader")

loader.on_very_lazy("search", function()
  loader.packadd("fzf-lua", "fzf-lua-smart", "grug-far.nvim")

  local fzflua = require("fzf-lua")
  local fzfluasmart = require("fzf-lua-smart")

  fzflua.setup({
    "border-fused",
    fzf_colors = true,
    fzf_opts = {},
    winopts = {
      split = "belowright new",
      height = 0.85,
      width = 1,
      row = 0.35,
      col = 0.50,
      border = "rounded",
      backdrop = 100,
      treesitter = {
        enabled = true,
      },
      preview = {
        border = "border-top",
        title = true,
        title_pos = "left",
        vertical = "down:50%",
        horizontal = "right:50%",
        layout = "vertical",
      },
    },
    defaults = {
      formatter = "path.filename_first",
    },
  })

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
    filter = { cwd = true },
    hidden = true,
    multiprocess = true,
  })

  -- Grug-far (project find & replace)
  require("grug-far").setup({
    headerMaxWidth = 80,
  })

  vim.keymap.set({ "n", "v" }, "<leader>sr", function()
    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
    require("grug-far").open({
      transient = true,
      prefills = {
        filesFilter = ext and ext ~= "" and "*." .. ext or nil,
      },
    })
  end, { desc = "Find and replace" })

  -- Fzf-lua keymaps
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

  vim.keymap.set("n", "<leader>sw", fzflua.grep_cword, { desc = "Grep word" })
  vim.keymap.set({ "x", "v" }, "<leader>sv", fzflua.grep_visual, { desc = "Grep Visual" })
  vim.keymap.set("n", "<leader>sg", fzflua.live_grep, { desc = "Live Grep" })
  vim.keymap.set("n", "<leader>xt", "<cmd>TodoFzfLua<cr>", { desc = "TODO/FIXME/NOTE etc" })
end)
