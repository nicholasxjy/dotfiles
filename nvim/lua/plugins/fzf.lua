return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      "ivy",
      "borderless-full",
      "telescope",
      fzf_colors = true,
      winopts = {
        treesitter = {
          enabled = true,
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
        "<leader>/",
        function()
          require("fzf-lua").grep_curbuf()
        end,
        desc = "Grep on current buffer",
        noremap = true,
        silent = true,
      },
      {
        "<leader>:",
        function()
          require("fzf-lua").command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader>h",
        function()
          require("fzf-lua").buffers({
            sort_lastused = true,
            cwd_only = true,
          })
        end,
        desc = "Open lastused buffers",
      },
      {
        "<leader>m",
        function()
          require("fzf-lua").marks()
        end,
        desc = "Goto marks",
      },
      {
        "<leader>ff",
        function()
          require("fzf-lua").files()
        end,
        desc = "Find files",
      },
      {
        "<leader>fc",
        function()
          require("fzf-lua").colorschemes()
        end,
        desc = "colorschemes",
      },
      {
        "<leader>fr",
        function()
          require("fzf-lua").oldfiles()
        end,
        desc = "Recent",
      },

      {
        "<leader>fa",
        function()
          require("fzf-lua").autocmds()
        end,
        desc = "Autocmds",
      },
      {
        "<leader>fb",
        function()
          require("fzf-lua").buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>fC",
        function()
          require("fzf-lua").commands()
        end,
        desc = "Commands",
      },
      {
        "<leader>fj",
        function()
          require("fzf-lua").jumps()
        end,
        desc = "Jumps",
      },
      {
        "<leader>fk",
        function()
          require("fzf-lua").keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>fl",
        function()
          require("fzf-lua").loclist()
        end,
        desc = "Location List",
      },
      {

        "<leader>fH",
        function()
          require("fzf-lua").highlights()
        end,
        desc = "Highlights",
      },

      -- git
      {
        "<leader>gf",
        function()
          require("fzf-lua").git_files()
        end,
        desc = "Git files",
      },
      {
        "<leader>gc",
        function()
          require("fzf-lua").git_commits()
        end,
        desc = "Git commits",
      },
      {
        "<leader>gb",
        function()
          require("fzf-lua").git_branches()
        end,
        desc = "Git branches",
      },
      {

        "<leader>gB",
        function()
          require("fzf-lua").git_blame()
        end,
        desc = "Buffer blame",
      },
      {
        "<leader>gC",
        function()
          require("fzf-lua").git_bcommits()
        end,
        desc = "Git Log file",
      },
      {
        "<leader>gs",
        function()
          require("fzf-lua").git_status()
        end,
        desc = "Git Status",
      },

      -- search
      {
        "<leader>s/",
        function()
          require("fzf-lua").search_history()
        end,
        desc = "Search History",
      },

      {
        "<leader>sg",
        function()
          require("fzf-lua").live_grep_native()
        end,
        desc = "Grep",
      },
      {
        "<leader>sG",
        function()
          require("fzf-lua").grep()
        end,
        desc = "Search for a pattern",
      },
      {
        "<leader>sw",
        function()
          require("fzf-lua").grep_cword()
        end,
        desc = "Search word",
        mode = { "n", "x" },
      },

      {
        "<leader>sW",
        function()
          require("fzf-lua").grep_cword()
        end,
        desc = "Search word all",
        mode = { "n", "x" },
      },
      -- trouble
      {
        "<leader>xt",
        function()
          require("fzf-lua").grep({ search = "TODO:|HACK:|PERF:|NOTE:|FIX:|FIXME:", no_esc = true })
        end,
        desc = "TODO/NOTE/FIX etc",
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
    end,
  },
}
