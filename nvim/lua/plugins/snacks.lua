return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    keys = {
      {
        "]]",
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
        mode = { "n", "t" },
      },
      {
        "[[",
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
        mode = { "n", "t" },
      },
      {
        "<leader>z",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>e",
        function()
          ---@diagnostic disable-next-line: missing-fields
          Snacks.explorer({
            diagnostics = true,
            git_status = true,
            ignored = true,
          })
        end,
        desc = "File explorer",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
      {
        "<leader>n",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notifications",
      },
      {
        "<leader>h",
        function()
          Snacks.picker.buffers({
            current = false,
            sort_lastused = true,
            focus = "list",
            layout = { preset = "select" },
            win = {
              list = { keys = { ["dd"] = "bufdelete" } },
            },
          })
        end,
        desc = "Snacks buffer jump",
      },
      {
        "<leader>m",
        function()
          Snacks.picker.marks({
            focus = "list",
            layout = { preset = "dropdown" },
          })
        end,
        desc = "Snacks marks",
      },
      {
        "<leader><space>",
        function()
          Snacks.picker.smart({
            layout = {
              preset = "dropdown",
            },
          })
        end,
        desc = "Snacks smart files",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep({
            buffers = true,
            layout = { preset = "dropdown" },
          })
        end,
        desc = "Grep buffers",
      },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history({
            focus = "list",
            layout = { preset = "select" },
          })
        end,
        desc = "Command History",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.files({
            layout = { preset = "dropdown" },
          })
        end,
        desc = "Find files",
      },
      {
        "<leader>fc",
        function()
          Snacks.picker.colorschemes({
            layout = { preset = "top" },
          })
        end,
        desc = "colorschemes",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent({
            layout = { preset = "bottom" },
          })
        end,
        desc = "Recent",
      },

      {
        "<leader>fa",
        function()
          Snacks.picker.autocmds({
            layout = { preset = "dropdown" },
          })
        end,
        desc = "Autocmds",
      },
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers({
            layout = { preset = "dropdown" },
          })
        end,
        desc = "Buffers",
      },
      {
        "<leader>fC",
        function()
          Snacks.picker.commands()
        end,
        desc = "Commands",
      },
      {
        "<leader>fj",
        function()
          Snacks.picker.jumps()
        end,
        desc = "Jumps",
      },
      {
        "<leader>fk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>fl",
        function()
          Snacks.picker.loclist()
        end,
        desc = "Location List",
      },
      {

        "<leader>fH",
        function()
          Snacks.picker.highlights()
        end,
        desc = "Highlights",
      },

      -- git
      {
        "<leader>gf",
        function()
          Snacks.picker.git_files({
            layout = { preset = "dropdown" },
          })
        end,
        desc = "Git files",
      },
      {
        "<leader>gc",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git commits",
      },
      {
        "<leader>gb",
        function()
          Snacks.picker.git_branches({
            layout = { preset = "top" },
          })
        end,
        desc = "Git branches",
      },
      {
        "<leader>gC",
        function()
          Snacks.picker.git_log_file()
        end,
        desc = "Git Log file",
      },
      {
        "<leader>gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git Status",
      },
      -- search
      {
        "<leader>s/",
        function()
          Snacks.picker.search_history({
            layout = { preset = "dropdown" },
          })
        end,
        desc = "Search History",
      },
      {
        "<leader>sg",
        function()
          Snacks.picker.grep({
            layout = { preset = "dropdown" },
          })
        end,
        desc = "Grep",
      },
      {
        "<leader>sG",
        function()
          Snacks.picker.grep_buffers({
            layout = { preset = "dropdown" },
          })
        end,
        desc = "Grep buffers",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word({
            focus = "list",
            buffers = true,
            layout = { preset = "dropdown" },
          })
        end,
        desc = "Grep word",
        mode = { "n", "x" },
      },

      {
        "<leader>sW",
        function()
          Snacks.picker.grep_word({
            focus = "list",
            layout = { preset = "dropdown" },
          })
        end,
        desc = "Search word all",
        mode = { "n", "x" },
      },
      -- trouble
      {
        "<leader>xt",
        function()
          ---@diagnostic disable-next-line: undefined-field
          Snacks.picker.todo_comments({
            focus = "list",
            layout = { preset = "dropdown" },
            keywords = { "TODO", "FIX", "FIXME" },
          })
        end,
        desc = "Todo/Fix/Fixme",
      },
      {
        "<leader>xT",
        function()
          ---@diagnostic disable-next-line: undefined-field
          Snacks.picker.todo_comments()
        end,
        desc = "TODO",
      },
      {
        "<leader>xq",
        function()
          Snacks.picker.qflist({
            focus = "list",
            layout = { preset = "dropdown" },
          })
        end,
        desc = "Quickfix list",
      },
    },
    opts = {
      explorer = {
        enabled = true,
        replace_netrw = true,
      },
      picker = {
        enabled = true,
        ui_select = true,
        matcher = {
          cwd_bonus = true, -- give bonus for matching files in the cwd
          frecency = true, -- frecency bonus
          history_bonus = true, -- give more weight to chronological order
        },
        formatters = {
          file = {
            filename_first = true,
          },
        },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
          list = {
            keys = {},
          },
        },
      },
      image = {
        enabled = true,
      },
      dashboard = {
        enabled = true,
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
          enabled = true,
          char = "",
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
            arrow = "",
          },
          only_current = true,
        },
      },
      bigfile = { enabled = true },
      dim = { enabled = true },
      zen = {
        enabled = true,
        win = {
          backdrop = {
            transparent = false,
          },
        },
      },
      scroll = { enabled = false },
      input = { enabled = true },
      words = { enabled = true },
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
      lazygit = {
        enabled = true,
        win = {
          width = 0.9,
          height = 0.9,
        },
      },
      terminal = {
        enabled = true,
        -- win = {
        --   position = "float",
        --   width = 0.85,
        --   height = 0.55,
        -- },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
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
