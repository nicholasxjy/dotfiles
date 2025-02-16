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
          Snacks.explorer()
        end,
        desc = "File explorer",
      },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = "Grep open buffers",
      },
      {
        "<leader>bl",
        function()
          Snacks.picker.lines()
        end,
        desc = "Buffer Blines",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.git_files()
        end,
        desc = "Find Files (git-files)",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Find Recent Files",
      },
      {
        "<leader>gc",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git log",
      },
      {
        "<leader>gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git status",
      },
      {
        "<leader>sa",
        function()
          Snacks.picker.autocmds()
        end,
        desc = "Auto Commands",
      },
      {
        "<leader>sk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Find keymaps",
      },
      {
        "<leader>su",
        function()
          Snacks.picker.undo()
        end,
        desc = "Undo History",
      },
      {
        "<leader>xl",
        function()
          Snacks.picker.loclist()
        end,
        desc = "Location list",
      },
      {
        "<leader>xq",
        function()
          Snacks.picker.qflist()
        end,
        desc = "Quickfix list",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
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
        -- layouts = {
        --   default = {
        --     layout = {
        --       box = "horizontal",
        --       row = 0.4,
        --       width = 0.86,
        --       height = 0.5,
        --       {
        --         box = "vertical",
        --         border = "single",
        --         title = "{title} {live} {flags}",
        --         { win = "input", height = 1, border = "bottom" },
        --         { win = "list", border = "none" },
        --       },
        --       { win = "preview", title = "{preview}", border = "single", width = 0.5 },
        --     },
        --   },
        -- },
        layout = {
          preset = "ivy",
          cycle = true,
        },
        matcher = {
          cwd_bonus = true, -- give bonus for matching files in the cwd
          frecency = true, -- frecency bonus
          history_bonus = true, -- give more weight to chronological order
        },
        formatters = {
          file = {
            filename_first = true, -- display filename before the file path
          },
        },
        win = {
          input = {
            keys = {
              -- to close the picker on ESC instead of going to normal mode,
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
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
          char = "⁚",
          underline = false,
        },
        chunk = {
          enabled = true,
        },
      },
      bigfile = { enabled = true },
      dim = { enabled = true },
      zen = { enabled = true },
      scroll = { enabled = false },
      input = { enabled = true },
      words = { enabled = true },
      toggle = { enabled = true },
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
      lazygit = {
        enabled = true,
        win = {
          position = "float",
          width = 0.85,
          height = 0.7,
        },
      },
      terminal = {
        enabled = true,
        win = {
          position = "float",
          width = 0.85,
          height = 0.65,
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
        -- {
        --   "<leader>ss",
        --   function()
        --     Snacks.picker.lsp_symbols()
        --   end,
        --   desc = "LSP Symbols",
        -- },
        {
          "<leader>sS",
          function()
            Snacks.picker.lsp_workspace_symbols()
          end,
          desc = "LSP Workspace Symbols",
        },
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
          desc = "Goto Declarations",
        },
        {
          "gr",
          function()
            Snacks.picker.lsp_references()
          end,
          desc = "References",
        },
        {
          "gI",
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
      })
    end,
  },
}
