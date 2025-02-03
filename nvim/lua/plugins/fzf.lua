return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      "default-title",
      -- "ivy",
      "borderless-full",
      "hide",
      fzf_colors = true,
      winopts = {
        title_pos = "center",
        width = 0.8,
        height = 0.5,
        row = 0.8,
        -- border = "single",
        treesitter = {
          enabled = true,
        },
        preview = {
          title_pos = "center",
          horizontal = "right:46%",
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
        "/",
        function()
          require("fzf-lua").grep_curbuf()
        end,
        desc = "Grep on current buffer",
        noremap = true,
        silent = true,
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
        -- {
        --   "gd",
        --   function()
        --     require("fzf-lua").lsp_definitions()
        --   end,
        --   desc = "Goto Definition",
        -- },
        -- {
        --   "gD",
        --   function()
        --     require("fzf-lua").lsp_declarations()
        --   end,
        --   desc = "Goto Declarations",
        -- },
        -- {
        --   "gr",
        --   function()
        --     require("fzf-lua").lsp_references()
        --   end,
        --   desc = "References",
        -- },
        -- {
        --   "gI",
        --   function()
        --     require("fzf-lua").lsp_implementations()
        --   end,
        --   desc = "Goto Implementation",
        -- },
        -- {
        --   "gy",
        --   function()
        --     require("fzf-lua").lsp_typedefs()
        --   end,
        --   desc = "Goto T[y]pe Definition",
        -- },
      })
    end,
  },
}
