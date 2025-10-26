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
            filter = { cwd = true },
            layout = ui.layout.ivy_border,
          })
        end,
        desc = "Snacks smart",
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
      {
        "<leader>xt",
        function()
          ---@diagnostic disable-next-line: undefined-field
          Snacks.picker.todo_comments({
            layout = ui.layout.dropdown,
            keywords = { "TODO", "FIX", "FIXME", "NOTE", "PERF", "HACK" },
          })
        end,
        desc = "Todo/Fix/Fixme etc",
      },
    },
    opts = {
      explorer = { enabled = true, replace_netrw = false },
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
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["<leader>h"] = {
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
        actions = {
          sidekick_send = function(...)
            return require("sidekick.cli.snacks").send(...)
          end,
        },
      },
      image = { enabled = true },
      dashboard = {
        preset = {
          header = [[
███████╗ ██████╗██╗  ██╗ ██████╗
██╔════╝██╔════╝██║  ██║██╔═══██╗
█████╗  ██║     ███████║██║   ██║
██╔══╝  ██║     ██╔══██║██║   ██║
███████╗╚██████╗██║  ██║╚██████╔╝
╚══════╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝
      ]],
        },
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
      indent = {
        indent = {
          enabled = false,
          only_current = true,
          only_scope = true,
          -- char = "⋮",
          char = "",
          -- char = "┊",
          hl = {
            "SnacksIndentRed",
            "SnacksIndentOrange",
            "SnacksIndentYellow",
            "SnacksIndentGreen",
            "SnacksIndentCyan",
            "SnacksIndentBlue",
            "SnacksIndentViolet",
          },
        },
        scope = {
          enabled = true,
          char = "║",
          underline = true,
          only_current = true,
          hl = {
            "SnacksIndentScopeRed",
            "SnacksIndentScopeOrange",
            "SnacksIndentScopeYellow",
            "SnacksIndentScopeGreen",
            "SnacksIndentScopeCyan",
            "SnacksIndentScopeBlue",
            "SnacksIndentScopeViolet",
          },
        },
        chunk = {
          enabled = false,
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
          hl = {
            "SnacksIndentChunkRed",
            "SnacksIndentChunkOrange",
            "SnacksIndentChunkYellow",
            "SnacksIndentChunkGreen",
            "SnacksIndentChunkCyan",
            "SnacksIndentChunkBlue",
            "SnacksIndentChunkViolet",
          },
        },
      },
      bigfile = { enabled = true },
      dim = { enabled = false },
      zen = { enabled = true },
      scroll = { enabled = false },
      input = { enabled = true },
      words = { enabled = true },
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
      scope = { enabled = true },
      gitbrowse = { enabled = true },
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
  },
}
