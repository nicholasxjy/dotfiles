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
        "<leader>h",
        function()
          Snacks.picker.buffers()
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
        "/",
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = "Grep open buffers",
        noremap = true,
        silent = true,
      },
      {
        "<leader><space>",
        function()
          Snacks.picker.files()
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
          Snacks.picker.recent({ filter = { cwd = true } })
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
    },
    opts = {
      picker = {
        ui_select = true,
        layout = {
          cycle = true,
          layout = {
            box = "horizontal",
            row = 0.4,
            width = 0.8,
            height = 0.5,
            {
              box = "vertical",
              border = "single",
              title = "{source} {live}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
            { win = "preview", border = "single", width = 0.5 },
          },
        },
        formatters = {
          file = {
            filename_first = true, -- display filename before the file path
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
          hl = "SnacksIndent",
        },
        scope = {
          enabled = true,
          char = "⁚",
          underline = true,
        },
        chunk = {
          enabled = true,
          hl = {
            "SnacksIndentChunk1",
            "SnacksIndentChunk2",
            "SnacksIndentChunk3",
            "SnacksIndentChunk4",
            "SnacksIndentChunk5",
            "SnacksIndentChunk6",
            "SnacksIndentChunk7",
            "SnacksIndentChunk8",
          },
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
          "<leader>ss",
          function()
            Snacks.picker.lsp_symbols()
          end,
          desc = "Find lsp symbols",
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
