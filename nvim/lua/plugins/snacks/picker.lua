local ui = require("core.ui")

return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      enabled = true,
      prompt = "> ", -- --
      ui_select = true,
      layout = {
        cycle = false,
        layout = ui.layout.dropdown.layout,
      },
      matcher = {
        cwd_bonus = true,
        frecency = true,
        history_bonus = true,
      },
      formatters = {
        file = {
          filename_first = true,
          truncate = 60,
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
      actions = {
        sidekick_send = function(...)
          return require("sidekick.cli.snacks").send(...)
        end,
      },
    },
  },
  keys = {
    {
      "<leader>E",
      function()
        Snacks.explorer({ layout = ui.layout.right })
      end,
      desc = "Snacks explorer",
    },
    {
      "<leader>:",
      function()
        Snacks.picker.commands()
      end,
      desc = "Snacks commands",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.lines({ layout = ui.layout.ivy_border })
      end,
      desc = "Snacks lines",
      silent = true,
    },
    {
      "<leader>m",
      function()
        Snacks.picker.marks()
      end,
      desc = "Snacks marks",
      silent = true,
    },
    {
      "ff",
      function()
        Snacks.picker.smart({
          hidden = true,
          filter = { cwd = true },
          preview = function()
            return false
          end,
          layout = ui.layout.dropdown_pick,
        })
      end,
      desc = "Snacks smart",
      silent = true,
    },
    {
      "nn",
      function()
        Snacks.picker.buffers({
          sort_lastused = true,
          current = false,
          layout = ui.layout.dropdown_pick,
        })
      end,
      desc = "Snacks buffers",
      silent = true,
    },
    {
      "<leader>r",
      function()
        Snacks.picker.resume()
      end,
      desc = "Snacks resume",
    },
    --search
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word({
          filter = { cwd = true },
        })
      end,
      desc = "Snacks search word under cursor",
      mode = { "n", "x", "v" },
    },
    {
      "<leader>sW",
      function()
        Snacks.picker.grep_word({
          filter = { cwd = true },
          buffers = true,
          dirs = { vim.fn.expand("%:p") }, -- current buffer
        })
      end,
      desc = "Snacks search word under cursor",
      mode = { "n", "x", "v" },
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep({
          filter = { cwd = true },
        })
      end,
      desc = "Snacks live grep",
    },
    {
      "<leader>sG",
      function()
        Snacks.picker.grep()
      end,
      desc = "Snacks live grep",
    },
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
    {
      "<leader>N",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notifications",
    },
    {
      "<leader>fq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Snacks quickfix",
    },
    {
      "<leader>fl",
      function()
        Snacks.picker.loclist()
      end,
      desc = "Snacks loclist",
    },
    {
      "<leader>xt",
      function()
        ---@diagnostic disable-next-line: undefined-field
        Snacks.picker.todo_comments({
          keywords = { "TODO", "FIX", "FIXME", "NOTE", "PERF", "HACK" },
        })
      end,
      desc = "Todo/Fix/Fixme etc",
    },
  },
}
