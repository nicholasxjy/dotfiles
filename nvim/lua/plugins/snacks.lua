local ui = require("core.ui")

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
    {
      "<leader>r",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume Search",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files({
          hidden = true,
          filter = { cwd = true },
        })
      end,
      desc = "Find Files",
      silent = true,
    },
    {
      "ff",
      function()
        Snacks.picker.smart({
          hidden = true,
          filter = { cwd = true },
          layout = ui.layout.vscode,
        })
      end,
      desc = "Find Files",
      silent = true,
    },
    {
      "nn",
      function()
        Snacks.picker.buffers({
          sort_lastused = true,
          current = false,
          layout = ui.layout.vscode,
          win = {
            input = {
              keys = {
                ["<c-x>"] = { "bufdelete", mode = { "n", "i" } },
              },
            },
            list = { keys = { ["dd"] = "bufdelete" } },
          },
        })
      end,
      desc = "Find Buffers",
      silent = true,
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word({
          filter = { cwd = true },
        })
      end,
      desc = "Grep Word",
      mode = { "n", "x", "v" },
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep({
          filter = { cwd = true },
        })
      end,
      desc = "Live Grep",
    },
    {
      "<leader>sG",
      function()
        Snacks.picker.grep()
      end,
      desc = "Global Grep",
    },
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen",
    },
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Clear Notifications",
    },
    {
      "<leader>N",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notifications",
    },
  },
}
