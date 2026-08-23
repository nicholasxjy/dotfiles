require("loader").packadd("snacks.nvim")

local ui = require("ui")

require("snacks").setup({
  animate = { enabled = false },
  dashboard = { enabled = false },
  explorer = { enabled = true, replace_netrw = false },
  image = { enabled = true },
  dim = { enabled = false },
  bigfile = { enabled = true },
  zen = { enabled = false },
  scroll = { enabled = false },
  input = { enabled = true },
  words = { enabled = false },
  indent = { enabled = false },
  statuscolumn = {
    enabled = true,
    left = { "mark", "sign" }, -- priority of signs on the left (high to low)
    right = { "fold", "git" }, -- priority of signs on the right (high to low)
    folds = {
      open = true, -- show open fold icons
      git_hl = false, -- use Git Signs hl for fold icons
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
    sources = {
      explorer = {
        hidden = true,
        ignored = true,
      },
    },
    prompt = "> ", -- --
    ui_select = true,
    layout = {
      circle = false,
      layout = {
        ---@diagnostic disable-next-line: assign-type-mismatch
        backdrop = false,
        row = -1,
        -- width = 1,
        min_width = 80,
        border = "solid",
        box = "vertical",
        { win = "preview", title = "{preview}", height = 0.5, border = "single" },
        {
          box = "vertical",
          border = "none",
          title = "{title} {live} {flags}",
          title_pos = "center",
          { win = "input", height = 1, border = "bottom" },
          { win = "list", border = "none" },
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
    icons = {
      kinds = ui.icons.default_kind_icons,
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

Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle
  .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
  :map("<leader>uc")
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
Snacks.toggle.inlay_hints():map("<leader>uh")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.dim():map("<leader>uD")

--- Create a picker keymap callback, optionally with default opts
local function pick(method, opts)
  return function()
    Snacks.picker[method](type(opts) == "function" and opts() or opts)
  end
end

--- Picker opts scoped to cwd
local cwd = { filter = { cwd = true } }

local function current_root()
  return Snacks.git.get_root() or vim.fn.getcwd(0)
end

local function root_prompt(root)
  return ("%s/"):format(vim.fn.fnamemodify(root, ":~"))
end

local function grep_buffer_word()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    Snacks.notify.warn("Current buffer has no file")
    return
  end

  Snacks.picker.grep_word({
    dirs = { file },
  })
end

vim.keymap.set("n", "<leader>E", function()
  Snacks.explorer({
    layout = ui.snacks_layout.sidebar,
  })
end, { desc = "Explorer" })

-- vim.keymap.set("n", "<leader><cr>", pick("resume"), { desc = "Resume Search" })
-- vim.keymap.set("n", "<leader>:", pick("commands"), { desc = "Commands" })
-- vim.keymap.set("n", "<leader>/", pick("lines"), { desc = "Blines" })
-- vim.keymap.set("n", "<leader>m", pick("marks"), { desc = "Marks" })

vim.keymap.set("n", "<leader>ff", pick("files", { hidden = true }), { desc = "Find Files", silent = true })

-- vim.keymap.set(
--   "n",
--   "<leader><space>",
--   pick("smart", function()
--     local root = current_root()
--     return {
--       cwd = root,
--       prompt = root_prompt(root),
--       hidden = true,
--       filter = cwd.filter,
--       layout = ui.snacks_layout.ivy,
--     }
--   end),
--   {
--     desc = "Find Files",
--     silent = true,
--     nowait = true,
--   }
-- )
--
-- vim.keymap.set(
--   "n",
--   "<leader>h",
--   pick("buffers", {
--     sort_lastused = true,
--     current = true,
--     layout = ui.snacks_layout.vscode,
--     win = {
--       input = { keys = { ["<c-x>"] = { "bufdelete", mode = { "n", "i" } } } },
--       list = { keys = { ["dd"] = "bufdelete" } },
--     },
--   }),
--   { desc = "Find Buffers", silent = true, nowait = true }
-- )
-- vim.keymap.set("n", "<leader>fa", pick("autocmds"), { desc = "Autocmds" })
-- vim.keymap.set("n", "<leader>fc", pick("colorschemes"), { desc = "Colorschemes" })
-- vim.keymap.set("n", "<leader>fi", pick("icons"), { desc = "Icons" })
-- vim.keymap.set("n", "<leader>fl", pick("loclist"), { desc = "Location" })
-- vim.keymap.set("n", "<leader>fk", pick("keymaps"), { desc = "Keymaps" })
-- vim.keymap.set("n", "<leader>fh", pick("highlights"), { desc = "Highlights" })
-- vim.keymap.set("n", "<leader>fr", pick("registers"), { desc = "Registers" })
-- vim.keymap.set("n", "<leader>fu", pick("undo"), { desc = "Undos" })
-- vim.keymap.set("n", "<leader>fq", pick("qflist"), { desc = "Quickfix" })
-- -- git
-- vim.keymap.set("n", "<leader>gb", pick("git_branches"), { desc = "Git Branches" })
-- vim.keymap.set("n", "<leader>gl", pick("git_log"), { desc = "Git Log" })
-- vim.keymap.set("n", "<leader>gL", pick("git_log_line"), { desc = "Git Log Line" })
-- vim.keymap.set("n", "<leader>gs", pick("git_status"), { desc = "Git Status" })
-- vim.keymap.set("n", "<leader>gS", pick("git_stash"), { desc = "Git Stash" })
-- vim.keymap.set("n", "<leader>gd", pick("git_diff"), { desc = "Git Diff (Hunks)" })
-- vim.keymap.set("n", "<leader>gf", pick("git_log_file"), { desc = "Git Log File" })

-- search
-- vim.keymap.set(
--   { "n", "x" },
--   "<leader>sw",
--   pick("grep_word", {
--     filter = { cwd = true },
--   }),
--   { desc = "Grep Word" }
-- )
-- vim.keymap.set("n", "<leader>sW", grep_buffer_word, { desc = "Grep Buffer Word" })
--
-- vim.keymap.set(
--   "n",
--   "<leader>sg",
--   pick("grep", {
--     filter = { cwd = true },
--   }),
--   { desc = "Live Grep" }
-- )
-- vim.keymap.set("n", "<leader>sG", pick("grep", {}), { desc = "Global Grep" })

vim.keymap.set("n", "<leader>xt", function()
  ---@diagnostic disable-next-line: undefined-field
  Snacks.picker.todo_comments()
end, { desc = "TODO/FIXME/NOTE etc" })
