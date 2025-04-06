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
          Snacks.explorer({
            layout = {
              preset = "default",
            },
            diagnostics = true,
            git_status = true,
            hidden = true,
            ignored = true,
            jump = {
              close = true,
            },
          })
        end,
        desc = "File explorer",
      },
      {
        "<leader>n",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = "Grep",
      },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history({
            layout = {
              preset = "vscode",
            },
          })
        end,
        desc = "Command History",
      },
      {
        "<leader>m",
        function()
          Snacks.picker.marks({
            layout = {
              preset = "select",
            },
          })
        end,
        desc = "Marks",
      },
      {
        "<leader>h",
        function()
          Snacks.picker.buffers({
            sort_lastused = true,
            current = false,
            layout = {
              preset = "select",
            },
            win = {
              input = {
                keys = {
                  ["dd"] = { "bufdelete", mode = { "n", "i" } },
                },
              },
              list = { keys = { ["dd"] = "bufdelete" } },
            },
          })
        end,
        desc = "Jump buffers",
      },

      -- find
      {
        "<leader><space>",
        function()
          Snacks.picker.smart({
            filter = { cwd = true },
            layout = {
              preset = "bottom",
            },
          })
        end,
        desc = "Find smart",
      },

      {
        "<leader>ff",
        function()
          Snacks.picker.files({
            hidden = true,
            ignored = true,
          })
        end,
        desc = "Find files",
      },
      {
        "<leader>fp",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent",
      },
      {
        "<leader>fa",
        function()
          Snacks.picker.autocmds()
        end,
        desc = "Autocmds",
      },
      {
        "<leader>fb",
        function()
          Snacks.picker.lines()
        end,
        desc = "Buffer Lines",
      },
      {
        "<leader>fc",
        function()
          Snacks.picker.colorschemes()
        end,
        desc = "Colorschemes",
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
      -- git
      {
        "<leader>gf",
        function()
          Snacks.picker.git_files()
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
          Snacks.picker.git_branches()
        end,
        desc = "Git branches",
      },
      {
        "<leader>gf",
        function()
          Snacks.picker.git_log_file()
        end,
        desc = "Git Log file",
      },
      {
        "<leader>gD",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "Git Diff",
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
          Snacks.picker.search_history()
        end,
        desc = "Search History",
      },

      {
        "<leader>sb",
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = "Grep Open Buffers",
      },
      {
        "<leader>sg",
        function()
          Snacks.picker.grep({
            layout = {
              preset = "ivy_split",
            },
          })
        end,
        desc = "Grep",
      },
      {
        "<leader>sG",
        function()
          Snacks.picker.grep({
            hidden = true,
            layout = {
              preset = "ivy_split",
            },
          })
        end,
        desc = "Grep All",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word({
            buffers = true,
            layout = {
              preset = "ivy_split",
            },
          })
        end,
        desc = "Search word",
        mode = { "n", "x" },
      },

      {
        "<leader>sW",
        function()
          Snacks.picker.grep_word({
            layout = {
              preset = "ivy_split",
            },
          })
        end,
        desc = "Search word all",
        mode = { "n", "x" },
      },
      {
        "<leader>xt",
        function()
          Snacks.picker.todo_comments({
            layout = { preset = "bottom" },
            keywords = { "TODO", "FIX", "FIXME", "PERF", "HACK" },
          })
        end,
        desc = "TODO/NOTE/FIX etc",
      },
      {
        "<leader>xq",
        function()
          Snacks.picker.qflist()
        end,
        desc = "Quickfix list",
      },

      {
        "<leader>xw",
        function()
          Snacks.picker.diagnostics({
            layout = {
              preset = "ivy_split",
            },
          })
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>xx",
        function()
          Snacks.picker.diagnostics_buffer({
            layout = {
              preset = "ivy_split",
            },
          })
        end,
        desc = "Buffer Diagnostics",
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
          history_bonus = false, -- give more weight to chronological order
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
          enabled = false,
          char = "¦",
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
        win = {
          position = "float",
          width = 0.85,
          height = 0.55,
        },
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
  {

    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("utils.lsp-keymaps").get()

      vim.list_extend(Keys, {
        {
          "gd",
          function()
            Snacks.picker.lsp_definitions()
          end,
          desc = "Goto Definition",
        },
        {
          "gD",
          function()
            Snacks.picker.lsp_declarations()
          end,
          desc = "Goto Declaration",
        },
        {
          "gr",
          function()
            Snacks.picker.lsp_references()
          end,
          nowait = true,
          desc = "References",
        },
        {
          "gi",
          function()
            Snacks.picker.lsp_implementations()
          end,
          desc = "Goto Implementation",
        },
        {
          "gy",
          function()
            Snacks.picker.lsp_type_definitions()
          end,
          desc = "Goto T[y]pe Definition",
        },
        {
          "<leader>ss",
          function()
            Snacks.picker.lsp_symbols({
              layout = {
                preset = "sidebar",
              },
            })
          end,
          desc = "LSP Symbols",
        },
        {
          "<leader>sS",
          function()
            Snacks.picker.lsp_workspace_symbols({
              layout = {
                preset = "sidebar",
              },
            })
          end,
          desc = "LSP Workspace Symbols",
        },
      })
    end,
  },
}
