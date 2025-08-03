local icons = require("core.icons")

-- Dashboard
local header = [[
█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ ▀ ▀▀▀█  █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ ▀ ▀▀▀▀█
█ │░███▀█▀▀▀▀▀▓████▓▄ ▀▀▀▀ │░████▓▄   │▓████▓▄  █
█ │▒███████  │▓███████     │▒███████  │▓███████ █
█ │▓███████  │▓███████     │▓███████  │▓███████ █
▀ │▓███████  │▓███████     │▓███████  │▓███████ █
▀ │▓███████  │▓███████▄ ▄  │▓███████  │▓███████ █
█ │▓███████                │▓███████   ▓███████ █▄▄▄
█ │▓███████▀▀ ▀    ▀       │▓███████▀▀▀▓█▄█████▄ ▄ █
█▄▄▄▄▄▄▄▄ ▀ █▀▀▀▀▀▀▀▀▀▀▀▀█▄▄▄▄ ▄ ▄▄▄▄▄▄▄▄▄▄▄ ▄ ▄▄▄▄█
        █ ▀ █
  <fh>  ▀▀▀▀▀                                       ]]
local footer = [[
▀ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ ▀ ▀▀▀▀▀▀▀▀▀▀▀▀▀ ▀
                                      n e o v i m   ]]
return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    keys = {
      -- stylua: ignore start
      { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode", },
      {
        "<leader>e",
        function()
          Snacks.explorer({ diagnostics = true, git_status = true, ignored = true, hidden = true, })
        end,
        desc = "File explorer",
      },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications", },
      { "<leader>N", function() Snacks.picker.notifications({ layout = { preset = "dropdown" } }) end, desc = "Notifications", },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git log", },
      { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git log line", },
      { "<leader>gF", function() Snacks.picker.git_log_file() end, desc = "Git log file", },

      -- stylua: ignore end
    },
    opts = {
      explorer = { enabled = true, replace_netrw = false },
      picker = {
        enabled = true,
        ui_select = false,
        layout = { cycle = false },
        matcher = {
          cwd_bonus = true,
          frecency = true,
          history_bonus = true,
        },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
        icons = { kinds = icons.symbol_map },
      },
      image = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header = header,
        },
        sections = {
          { section = "header", gap = 0, padding = 0 },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            text = {
              {
                footer,
                hl = "SnacksDashboardHeader",
              },
            },
            gap = 0,
            padding = 1,
          },
          { section = "startup" },
        },
      },
      indent = {
        indent = {
          enabled = false,
          -- only_current = true,
          -- only_scope = true,
          char = "⋮",
          -- char = "",
          -- char = "⁘",
        },
        scope = {
          enabled = true,
          --char = "⁚",
          -- char = "║",
          underline = false,
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
      dim = { enabled = true },
      zen = { enabled = true },
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
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          ---@diagnostic disable-next-line: duplicate-set-field
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          ---@diagnostic disable-next-line: duplicate-set-field
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

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
