return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      "default-title",
      fzf_colors = true,
      winopts = {
        width = 0.8,
        height = 0.5,
        row = 0.7,
        border = "single",
        treesitter = {
          enabled = true,
        },
        preview = {
          horizontal = "right:40%",
        },
      },
      files = {
        formatter = "path.filename_first",
        git_icons = true,
      },
      buffers = {
        formatter = "path.filename_first",
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
        "<leader>/",
        function()
          require("fzf-lua").grep_curbuf()
        end,
        desc = "Grep on current buffer",
      },
      {
        "<leader><space>",
        function()
          require("fzf-lua").files({ cwd_only = true })
        end,
        desc = "Find Files (cwd)",
      },
      {
        "<leader>ba",
        function()
          require("fzf-lua").args()
        end,
        desc = "Args",
      },
      {
        "<leader>bl",
        function()
          require("fzf-lua").blines()
        end,
        desc = "Blines",
      },
      {
        "<leader>fb",
        function()
          require("fzf-lua").buffers()
        end,
        desc = "Find buffers",
      },
      {
        "<leader>h",
        function()
          require("fzf-lua").buffers({ sort_lastused = true })
        end,
        desc = "Open lastused buffers",
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
        desc = "Find Themes",
      },
      {
        "<leader>fs",
        function()
          require("fzf-lua").treesitter()
        end,
        desc = "Treesitter Symbols",
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
        "<leader>sS",
        function()
          require("fzf-lua").lsp_workspace_symbols()
        end,
        desc = "Find workspace symbols",
      },
      {
        "<leader>sk",
        function()
          require("fzf-lua").keymaps()
        end,
        desc = "Find keymaps",
      },
      {
        "<leader>m",
        function()
          require("fzf-lua").marks()
        end,
        desc = "Goto marks",
      },
      {
        "<leader>sw",
        function()
          require("fzf-lua").grep_cword()
        end,
        desc = "Find word under cursor (cwd)",
      },
      {
        "<leader>sW",
        function()
          require("fzf-lua").grep_cword({ cwd_only = false })
        end,
        desc = "Find word under cursor (root)",
      },
      {
        "<leader>sg",
        function()
          require("fzf-lua").live_grep_native()
        end,
        desc = "Live grep",
      },
    },
    config = function(_, opts)
      local fzfLua = require("fzf-lua")
      fzfLua.setup(opts)
      fzfLua.register_ui_select()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("utils.lsp-keymaps").get()
      vim.list_extend(Keys, {
        {
          "<leader>ca",
          function()
            require("fzf-lua").lsp_code_actions()
          end,
          desc = "Code Actions",
        },
        {
          "<leader>xx",
          function()
            require("fzf-lua").diagnostics_document()
          end,
          desc = "Document Diagnostics",
        },
        {
          "<leader>xw",
          function()
            require("fzf-lua").diagnostics_workspace()
          end,
          desc = "Workspace Diagnostics",
        },
        {
          "<leader>xt",
          function()
            require("fzf-lua").grep({ search = "TODO:|HACK:|PERF:|NOTE:|FIX:|FIXME:", no_esc = true })
          end,
          desc = "Find todo comments",
        },
        {
          "<leader>xl",
          function()
            require("fzf-lua").loclist()
          end,
          desc = "Location list",
        },
        {
          "<leader>xq",
          function()
            require("fzf-lua").quickfix()
          end,
          desc = "Quickfix list",
        },
      })
      -- stylua: ignore
      vim.list_extend(Keys, {
        { "gd", "<cmd>FzfLua lsp_definitions     jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto Definition", has = "definition" },
        { "gD", "<cmd>FzfLua lsp_declarations    jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto Declarations" },
        { "gr", "<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>", desc = "References", nowait = true },
        { "gI", "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto Implementation" },
        { "gy", "<cmd>FzfLua lsp_typedefs        jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto T[y]pe Definition" },
      })
    end,
  },
}
