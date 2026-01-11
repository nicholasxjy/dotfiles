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
      icons = { kinds = ui.icons.mini_kind_icons },
      debug = {
        scores = false,
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
      "<leader>/",
      function()
        Snacks.picker.lines()
      end,
      desc = "Snacks blines",
      silent = true,
    },
    {
      "<leader>m",
      function()
        Snacks.picker.marks({ layout = ui.layout.dropdown })
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
          layout = ui.layout.ivy_pick,
        })
      end,
      desc = "Snacks smart",
      silent = true,
    },
    {
      "nn",
      function()
        Snacks.picker.buffers({
          focus = "list",
          sort_lastused = true,
          current = false,
          layout = ui.layout.ivy_pick,
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
      desc = "Snacks buffers",
      silent = true,
    },
    {
      "<leader>r",
      function()
        Snacks.picker.resume({ layout = ui.layout.dropdown })
      end,
      desc = "Snacks resume",
    },
    --search
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word({
          layout = ui.layout.dropdown,
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
          layout = ui.layout.dropdown,
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
          layout = ui.layout.dropdown,
          filter = { cwd = true },
        })
      end,
      desc = "Snacks live grep",
    },
    {
      "<leader>sG",
      function()
        Snacks.picker.grep({ layout = ui.layout.dropdown })
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
  },
}
