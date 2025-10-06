local ui = require("core.ui")

return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    keys = {
      {
        "<leader>ue",
        function()
          Snacks.explorer({ layout = { preset = "right" } })
        end,
        desc = "Snacks explorer",
      },
      {
        "ff",
        function()
          Snacks.picker.smart({
            prompt = " ",
            filter = { cwd = true },
            layout = ui.layout.select,
          })
        end,
        desc = "Snacks smart",
        silent = true,
      },
      {
        "nn",
        function()
          Snacks.picker.buffers({
            prompt = " ",
            layout = ui.layout.select,
            current = false,
            sort_lastused = true,
          })
        end,
        desc = "Snacks buffers",
        silent = true,
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
          Snacks.picker.notifications({ layout = ui.layout.dropdown })
        end,
        desc = "Notifications",
      },
      --search
      {
        "<leader>r",
        function()
          Snacks.picker.resume({ layout = ui.layout.dropdown })
        end,
        desc = "Resume",
      },
      {
        "<leader>sg",
        function()
          Snacks.picker.grep({ layout = ui.layout.dropdown })
        end,
        desc = "Grep",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word({ layout = ui.layout.dropdown })
        end,
        desc = "Visual selection or word",
        mode = { "n", "x", "v" },
      },
      {
        "<leader>gf",
        function()
          Snacks.picker.git_files()
        end,
        desc = "Git files",
      },
      {
        "<leader>gb",
        function()
          Snacks.picker.git_branches()
        end,
        desc = "Git branches",
      },
      {
        "<leader>gc",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git log",
      },
      {
        "<leader>gC",
        function()
          Snacks.picker.git_log_file()
        end,
        desc = "Git log file",
      },
      {
        "<leader>gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git status",
      },
      {
        "<leader>gd",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "Git diff",
      },
      {
        "<leader>gL",
        function()
          Snacks.picker.git_log_line()
        end,
        desc = "Git log line",
      },
      {
        "<leader>fc",
        function()
          Snacks.picker.colorschemes({ layout = { preset = "top" } })
        end,
        desc = "Colorschemes",
      },
      {
        "<leader>xt",
        function()
          ---@diagnostic disable-next-line: undefined-field
          Snacks.picker.todo_comments({
            keywords = {
              "TODO",
              "FIX",
              "FIXME",
              "NOTE",
              "PERF",
              "HACK",
            },
          })
        end,
        desc = "Todo/Fix/Fixme etc",
      },
    },
    opts = {
      explorer = { enabled = true, replace_netrw = false },
      picker = {
        enabled = true,
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
            truncate = 80,
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
        },
        icons = { kinds = ui.icons.lspkind_kind_icons },
      },
      image = { enabled = true },
      dashboard = {
        -- Used by the `header` section
        preset = {
          header = [[
 __     __             __  __         ____    U  ___ u  ____
 \ \   /"/u  ___     U|' \/ '|u    U /"___|u   \/"_ \/ |  _"\
  \ \ / //  |_"_|    \| |\/| |/    \| |  _ /   | | | |/| | | |
  /\ V /_,-. | |      | |  | |      | |_| |.-,_| |_| |U| |_| |\
 U  \_/-(_/U/| |\u    |_|  |_|       \____| \_)-\___/  |____/ u
   //   .-,_|___|_,-.<<,-,,-.        _)(|_       \\     |||_
  (__)   \_)-' '-(_/  (./  \.)      (__)__)     (__)   (__)_)
      ]],
        },
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          {
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            indent = 2,
            padding = 1,
          },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
      indent = {
        indent = {
          enabled = true,
          -- only_current = true,
          -- only_scope = true,
          -- char = "⋮",
          char = "",
          -- char = "⁘",
          hl = {
            "RainbowDelimiterRed",
            "RainbowDelimiterOrange",
            "RainbowDelimiterYellow",
            "RainbowDelimiterGreen",
            "RainbowDelimiterCyan",
            "RainbowDelimiterBlue",
            "RainbowDelimiterViolet",
          },
        },
        scope = {
          enabled = false,
          --char = "⁚",
          char = "║",
          underline = true,
          only_current = true,
        },
        chunk = {
          enabled = true,
          char = {
            -- corner_top = "┌",
            -- corner_bottom = "└",
            corner_top = "╭",
            corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = "",
          },
          only_current = true,
        },
      },
      bigfile = { enabled = true },
      dim = { enabled = false },
      zen = { enabled = true },
      scroll = { enabled = false },
      input = { enabled = true },
      words = { enabled = false },
      statuscolumn = {
        left = { "mark", "sign" }, -- priority of signs on the left (high to low)
        right = { "fold", "git" }, -- priority of signs on the right (high to low)
        folds = {
          open = true, -- show open fold icons
          git_hl = true, -- use Git Signs hl for fold icons
        },
      },
      notifier = { enabled = true },
      toggle = { enabled = true },
      lazygit = { enabled = false },
      terminal = { enabled = true },
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
            .option("conceallevel", {
              off = 0,
              on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
            })
            :map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle
            .option("background", {
              off = "light",
              on = "dark",
              name = "Dark Background",
            })
            :map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },
}
