local icons = require("core.icons")

return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    keys = {
      -- stylua: ignore start
      -- {"ff", function() require("utils.snf").fff() end, desc = "Snacks fff files" },
      { "<leader>ue", function() Snacks.explorer({layout = {preset="right"}}) end, desc = "Snacks explorer", },
      { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode", },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications", },
      { "<leader>N", function() Snacks.picker.notifications({ layout = { preset = "dropdown" } }) end, desc = "Notifications", },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git log", },
      { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git log line", },
      { "<leader>gF", function() Snacks.picker.git_log_file() end, desc = "Git log file", },
      { "<leader>fc", function() Snacks.picker.colorschemes({ layout = { preset = "top" } }) end, desc = "Colorschemes", },
      -- stylua: ignore end
    },
    opts = {
      explorer = { enabled = true, replace_netrw = false },
      picker = {
        enabled = true,
        ui_select = false,
        layout = {
          cycle = false,
        },
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
        icons = { kinds = icons.lspkind },
      },
      image = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
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
          enabled = false,
          --char = "⁚",
          -- char = "║",
          underline = false,
          only_current = true,
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
        },
      },
      bigfile = { enabled = true },
      dim = { enabled = false },
      zen = { enabled = true },
      scroll = { enabled = false },
      input = { enabled = true },
      words = { enabled = false },
      statuscolumn = {
        enabled = false,
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
