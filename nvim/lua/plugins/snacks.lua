local ui = require("core.ui")

--- Create a picker keymap callback, optionally with default opts
local function pick(method, opts)
  return function()
    Snacks.picker[method](opts)
  end
end

--- Picker opts scoped to cwd
local cwd = { filter = { cwd = true } }

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = {
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
    notifier = { enabled = true },
    toggle = { enabled = true },
    lazygit = { enabled = true },
    terminal = { enabled = true },
    scope = { enabled = true },
    gitbrowse = { enabled = true },
    dashboard = {
      preset = {
        header = [[
███████╗███████╗████████╗███████╗██╗   ██╗
██╔════╝██╔════╝╚══██╔══╝██╔════╝██║   ██║
███████╗█████╗     ██║   ███████╗██║   ██║
╚════██║██╔══╝     ██║   ╚════██║██║   ██║
███████║███████╗   ██║   ███████║╚██████╔╝
╚══════╝╚══════╝   ╚═╝   ╚══════╝ ╚═════╝
              ┌───────────────┐
              │   S  E  T  S  U│
              └───────────────┘
      ]],
      },
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
    picker = {
      enabled = true,
      prompt = "> ", -- --
      ui_select = true,
      layout = {
        cycle = false,
        layout = ui.layout.dropdown_pick.layout,
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
      actions = {
        sidekick_send = function(...)
          return require("sidekick.cli.picker.snacks").send(...)
        end,
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
      icons = { kinds = ui.icons.lspkind_kind_icons },
      debug = {
        scores = false,
      },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
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
  end,
  keys = {
    {
      "<leader>E",
      function()
        Snacks.explorer()
      end,
      desc = "Explorer",
    },
    { "<leader>r", pick("resume"), desc = "Resume Search" },
    { "<leader>/", pick("lines"), desc = "Blines" },
    { "<leader>m", pick("marks"), desc = "Marks" },
    { "<leader>ff", pick("files", { hidden = true, filter = cwd.filter }), desc = "Find Files", silent = true },
    {
      "ff",
      pick("smart", { hidden = true, filter = cwd.filter, layout = ui.layout.vscode }),
      desc = "Find Files",
      silent = true,
    },
    {
      "nn",
      pick("buffers", {
        sort_lastused = true,
        current = false,
        layout = ui.layout.vscode,
        win = {
          input = { keys = { ["<c-x>"] = { "bufdelete", mode = { "n", "i" } } } },
          list = { keys = { ["dd"] = "bufdelete" } },
        },
      }),
      desc = "Find Buffers",
      silent = true,
    },
    { "<leader>fa", pick("autocmds"), desc = "Autocmds" },
    { "<leader>fc", pick("colorschemes"), desc = "Colorschemes" },
    { "<leader>fC", pick("commands"), desc = "Commands" },
    { "<leader>fi", pick("icons"), desc = "Icons" },
    { "<leader>fl", pick("loclist"), desc = "Location" },
    { "<leader>fk", pick("keymaps"), desc = "Keymaps" },
    { "<leader>fr", pick("registers"), desc = "Registers" },
    { "<leader>fu", pick("undo"), desc = "Undos" },
    { "<leader>fq", pick("qflist"), desc = "Quickfix" },
    -- git
    { "<leader>gb", pick("git_branches"), desc = "Git Branches" },
    { "<leader>gl", pick("git_log"), desc = "Git Log" },
    { "<leader>gL", pick("git_log_line"), desc = "Git Log Line" },
    { "<leader>gs", pick("git_status"), desc = "Git Status" },
    { "<leader>gS", pick("git_stash"), desc = "Git Stash" },
    { "<leader>gd", pick("git_diff"), desc = "Git Diff (Hunks)" },
    { "<leader>gf", pick("git_log_file"), desc = "Git Log File" },
    -- search
    { "<leader>sw", pick("grep_word", cwd), desc = "Grep Word", mode = { "n", "x", "v" } },
    { "<leader>sg", pick("grep", cwd), desc = "Live Grep" },
    { "<leader>sG", pick("grep"), desc = "Global Grep" },
    -- misc
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Clear Notifications",
    },
    { "<leader>N", pick("notifications"), desc = "Notifications" },
  },
}
