return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      "default-title",
      winopts = {
        width = 1,
        height = 0.45,
        row = 1,
        border = "single",
        treesitter = {
          enabled = true,
        },
        preview = {
          horizontal = "right:45%",
        },
      },
    },
    keys = {
      {
        "<leader>:",
        function()
          require("fzf-lua").command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader><space>",
        function()
          require("fzf-lua").files({ cwd_only = true })
        end,
        desc = "Find Files (cwd)",
      },
      {
        "<leader>fb",
        function()
          require("fzf-lua").buffers()
        end,
        desc = "Find buffers",
      },
      {
        "<leader>fg",
        function()
          require("fzf-lua").git_files()
        end,
        desc = "Find Files (git-files)",
      },
      {
        "<leader>fr",
        function()
          require("fzf-lua").oldfiles()
        end,
        desc = "Find Recent Files",
      },
      {
        "<leader>ff",
        function()
          require("fzf-lua").files()
        end,
        desc = "Find Files",
      },

      {
        "<leader>ft",
        function()
          require("fzf-lua").colorschemes()
        end,
        desc = "Find Colorschemes",
      },

      {
        "<leader>gc",
        function()
          require("fzf-lua").git_commits()
        end,
        desc = "Commits",
      },
      {
        "<leader>gs",
        function()
          require("fzf-lua").git_status()
        end,
        desc = "Git status",
      },

      {
        "<leader>sa",
        function()
          require("fzf-lua").autocmds()
        end,
        desc = "Auto Commands",
      },

      {
        "<leader>ss",
        function()
          require("fzf-lua").lsp_document_symbols()
        end,
        desc = "Find document symbols",
      },
      {
        "<leader>sk",
        function()
          require("fzf-lua").keymaps()
        end,
        desc = "Find keymaps",
      },
      {
        "<leader>sd",
        function()
          require("fzf-lua").diagnostics_document()
        end,
        desc = "Find diagnostics",
      },
      {
        "<leader>sD",
        function()
          require("fzf-lua").diagnostics_workspace()
        end,
        desc = "Find diagnostics in workspace",
      },
      {
        "<leader>sm",
        function()
          require("fzf-lua").marks()
        end,
        desc = "Find marks",
      },
      {
        "<leader>sq",
        function()
          require("fzf-lua").quickfix()
        end,
        desc = "Find quickfix",
      },
      {
        "<leader>sw",
        function()
          require("fzf-lua").grep_cword({ cwd_only = true })
        end,
        desc = "Find word under cursor (cwd)",
      },
      {
        "<leader>sW",
        function()
          require("fzf-lua").grep_cword()
        end,
        desc = "Find word under cursor",
      },
      {
        "<leader>sg",
        function()
          require("fzf-lua").live_grep_native()
        end,
        desc = "Live grep",
      },
      {
        "<leader>sb",
        function()
          require("fzf-lua").grep_curbuf()
        end,
        desc = "Grep on current buffer",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("utils.lsp-keymaps").get()
      -- stylua: ignore
      vim.list_extend(Keys, {
        { "gd", "<cmd>FzfLua lsp_definitions     jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto Definition", has = "definition" },
        { "gr", "<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>", desc = "References", nowait = true },
        { "gI", "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto Implementation" },
        { "gy", "<cmd>FzfLua lsp_typedefs        jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto T[y]pe Definition" },
      })
    end,
  },
}
