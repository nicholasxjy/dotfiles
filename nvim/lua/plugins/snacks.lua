return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    keys = {
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
        "<leader>h",
        function()
          Snacks.picker.buffers({
            current = false,
            sort_lastused = true,
            win = {
              input = {
                keys = {
                  ["d"] = "bufdelete",
                },
              },
              list = { keys = { ["d"] = "bufdelete" } },
            },
          })
        end,
        desc = "Find Buffers",
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
        "<leader><space>",
        function()
          Snacks.picker.files({
            finder = "files",
            format = "file",
            show_empty = true,
          })
        end,
        desc = "Find Files",
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
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
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
        "<leader>ft",
        function()
          Snacks.picker.colorschemes()
        end,
        desc = "Find Themes",
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
        "<leader>m",
        function()
          Snacks.picker.marks()
        end,
        desc = "Goto marks",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Find word under cursor (cwd)",
      },
      {
        "<leader>sg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
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
        "<leader>xx",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>xX",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Diagnostics Buffer",
      },
    },
    opts = {
      explorer = {
        enabled = true,
        replace_netrw = true,
      },
      picker = {
        enabled = true,
        ui_select = false,
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
          -- hl = {
          --   "SnacksIndent1",
          --   "SnacksIndent2",
          --   "SnacksIndent3",
          --   "SnacksIndent4",
          --   "SnacksIndent5",
          -- },
        },
        scope = {
          enabled = true,
          char = "⁚",
          underline = true,
        },
        chunk = {
          enabled = true,
          -- hl = {
          --   "SnacksIndentChunk1",
          --   "SnacksIndentChunk2",
          --   "SnacksIndentChunk3",
          --   "SnacksIndentChunk4",
          --   "SnacksIndentChunk5",
          --   "SnacksIndentChunk6",
          --   "SnacksIndentChunk7",
          --   "SnacksIndentChunk8",
          -- },
        },
      },
      bigfile = { enabled = true },
      dim = { enabled = true },
      zen = { enabled = true },
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

      lazygit = {
        configure = false,
        win = {
          position = "float",
          width = 0.8,
          height = 0.8,
        },
      },
      terminal = {
        win = {
          position = "float",
          width = 0.7,
          height = 0.6,
          wo = {
            winbar = "", -- hide terminal title
          },
        },
      },
    },
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
        {
          "<leader>ss",
          function()
            Snacks.picker.lsp_symbols()
          end,
          desc = "LSP Symbols",
        },
        {
          "<leader>sS",
          function()
            Snacks.picker.lsp_workspace_symbols()
          end,
          desc = "LSP Workspace Symbols",
        },
      })
    end,
  },
}
