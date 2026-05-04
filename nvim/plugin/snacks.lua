local vscode = {
  hidden = { "preview" },
  layout = {
    backdrop = false,
    row = -1,
    width = 0.5,
    min_width = 80,
    height = 0.4,
    border = "none",
    box = "vertical",
    { win = "input", height = 1, border = true, title = "{title} {live} {flags}", title_pos = "center" },
    { win = "list", border = "hpad" },
    { win = "preview", title = "{preview}", border = true },
  },
}

require("snacks").setup({
  dashboard = { enabled = false },
  explorer = { enabled = true, replace_netrw = false },
  image = { enabled = true },
  dim = { enabled = false },
  bigfile = { enabled = true },
  zen = { enabled = false },
  scroll = { enabled = false },
  input = { enabled = true },
  words = { enabled = false },
  statuscolumn = {
    enabled = true,
    left = { "mark", "sign" }, -- priority of signs on the left (high to low)
    right = { "fold", "git" }, -- priority of signs on the right (high to low)
    folds = {
      open = true, -- show open fold icons
      git_hl = true, -- use Git Signs hl for fold icons
    },
  },
  notifier = { enabled = false },
  toggle = { enabled = true },
  lazygit = { enabled = true },
  terminal = { enabled = true },
  scope = { enabled = true },
  gitbrowse = { enabled = true },
  picker = {
    enabled = true,
    prompt = "> ", -- --
    ui_select = true,
    layout = {
      circle = false,
      layout = {
        ---@diagnostic disable-next-line: assign-type-mismatch
        backdrop = true,
        row = -1,
        width = 0.9,
        min_width = 80,
        border = "single",
        box = "vertical",
        { win = "preview", title = "{preview}", height = 0.45, border = "rounded" },
        {
          box = "vertical",
          border = "rounded",
          title = "{title} {live} {flags}",
          title_pos = "center",
          { win = "input", height = 1, border = "none" },
          { win = "list", border = "rounded" },
        },
      },
    },
    matcher = {
      cwd_bonus = true,
      frecency = true,
      history_bonus = true,
    },
    formatters = {
      file = {
        filename_first = true,
        truncate = "center",
        git_status_hl = true,
      },
      severity = {
        icons = true, -- show severity icons
        level = true, -- show severity level
        pos = "left", -- position of the diagnostics
      },
    },
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
          ["<a-a>"] = {
            "sidekick_send",
            mode = { "n", "i" },
          },
        },
      },
      list = {
        keys = {
          ["<c-j>"] = "list_down",
          ["<c-k>"] = "list_up",
          ["<c-n>"] = "list_down",
          ["<c-p>"] = "list_up",
        },
      },
    },
  },
})

vim.api.nvim_create_autocmd("User", {
  once = true,
  callback = function()
    -- Create some toggle mappings
    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
    Snacks.toggle.diagnostics():map("<leader>ud")
    Snacks.toggle.line_number():map("<leader>ul")
    Snacks.toggle
      .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
      :map("<leader>uc")
    Snacks.toggle.treesitter():map("<leader>uT")
    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
    Snacks.toggle.inlay_hints():map("<leader>uh")
    Snacks.toggle.indent():map("<leader>ug")
    Snacks.toggle.dim():map("<leader>uD")
  end,
})

--- Create a picker keymap callback, optionally with default opts
local function pick(method, opts)
  return function()
    Snacks.picker[method](opts)
  end
end

--- Picker opts scoped to cwd
local cwd = { filter = { cwd = true } }

vim.keymap.set("n", "<leader>E", function()
  Snacks.explorer()
end, { desc = "Explorer" })

vim.keymap.set("n", "<leader>r", pick("resume"), { desc = "Resume Search" })
-- vim.keymap.set("n", "<leader>/", pick("lines"), { desc = "Blines" })
-- vim.keymap.set("n", "<leader>m", pick("marks"), { desc = "Marks" })

vim.keymap.set("n", "<leader>ff", pick("files", { hidden = true }), { desc = "Find Files", silent = true })

vim.keymap.set("n", "ff", pick("smart", { hidden = true, filter = cwd.filter, layout = vscode }), {
  desc = "Find Files",
  silent = true,
})

vim.keymap.set(
  "n",
  "nn",
  pick("buffers", {
    sort_lastused = true,
    current = false,
    layout = vscode,
    win = {
      input = { keys = { ["<c-x>"] = { "bufdelete", mode = { "n", "i" } } } },
      list = { keys = { ["dd"] = "bufdelete" } },
    },
  }),
  { desc = "Find Buffers", silent = true }
)
-- vim.keymap.set("n", "<leader>fa", pick("autocmds"), { desc = "Autocmds" })
-- vim.keymap.set("n", "<leader>fc", pick("colorschemes"), { desc = "Colorschemes" })
-- vim.keymap.set("n", "<leader>fC", pick("commands"), { desc = "Commands" })
-- vim.keymap.set("n", "<leader>fi", pick("icons"), { desc = "Icons" })
-- vim.keymap.set("n", "<leader>fl", pick("loclist"), { desc = "Location" })
-- vim.keymap.set("n", "<leader>fk", pick("keymaps"), { desc = "Keymaps" })
-- vim.keymap.set("n", "<leader>fr", pick("registers"), { desc = "Registers" })
-- vim.keymap.set("n", "<leader>fu", pick("undo"), { desc = "Undos" })
-- vim.keymap.set("n", "<leader>fq", pick("qflist"), { desc = "Quickfix" })
--
-- -- git
-- vim.keymap.set("n", "<leader>gb", pick("git_branches"), { desc = "Git Branches" })
-- vim.keymap.set("n", "<leader>gl", pick("git_log"), { desc = "Git Log" })
-- vim.keymap.set("n", "<leader>gL", pick("git_log_line"), { desc = "Git Log Line" })
-- vim.keymap.set("n", "<leader>gs", pick("git_status"), { desc = "Git Status" })
-- vim.keymap.set("n", "<leader>gS", pick("git_stash"), { desc = "Git Stash" })
-- vim.keymap.set("n", "<leader>gd", pick("git_diff"), { desc = "Git Diff (Hunks)" })
-- vim.keymap.set("n", "<leader>gf", pick("git_log_file"), { desc = "Git Log File" })

-- search
vim.keymap.set(
  { "n", "x", "v" },
  "<leader>sw",
  pick("grep_word", {
    formatters = { file = { filename_first = false } },
    filter = { cwd = true },
  }),
  { desc = "Grep Word" }
)
vim.keymap.set(
  "n",
  "<leader>sg",
  pick("grep", {
    formatters = { file = { filename_first = false } },
    filter = { cwd = true },
  }),
  { desc = "Live Grep" }
)
vim.keymap.set(
  "n",
  "<leader>sG",
  pick("grep", {
    formatters = { file = { filename_first = false } },
  }),
  { desc = "Global Grep" }
)

vim.keymap.set("n", "<leader>xt", function()
  pick("todo_comments", { { keywords = { "TODO", "FIX", "FIXME", "NOTE", "PERF", "HACK" } } })
end, { desc = "TODO/FIXME/NOTE etc" })
