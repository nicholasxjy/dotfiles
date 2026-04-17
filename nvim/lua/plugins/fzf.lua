return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "nvim-mini/mini.icons" },
    opts = {
      "borderless-full",
      "hide",
      fzf_colors = true,
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      defaults = {
        formatter = "path.filename_first",
        git_icons = true,
        file_icons = true,
        color_icons = true,
      },
      winopts = {
        height = 1, -- window height
        width = 0.9, -- window width
        row = 1, -- window row position (0=top, 1=bottom)
        -- col = 0.2,
        border = "none",
        backdrop = 50,
        preview = {
          border = "none",
          wrap = true,
          hidden = false,
          layout = "vertical",
          vertical = "up:50%",
        },
      },
      files = {
        multiprocess = true,
      },
      lsp = {
        -- symbols = {
        --   symbol_icons = ui.icons.mini_kind_icons,
        -- },
      },
      diagnostics = {
        cwd_only = true,
      },
      debug = false,
    },
    keys = {
      {
        "<leader>/",
        function()
          require("fzf-lua").blines()
        end,
        desc = "Search Buffer",
      },
      {
        "<leader>:",
        function()
          require("fzf-lua").commands()
        end,
        desc = "Commands",
      },
      {
        "<leader>m",
        function()
          require("fzf-lua").marks({
            previewer = false,
          })
        end,
        desc = "Marks",
      },
      {
        "<leader>fb",
        function()
          require("fzf-lua").buffers({
            cwd_only = true,
          })
        end,
        desc = "Buffers",
      },
      {
        "<leader>fc",
        function()
          require("fzf-lua").colorschemes()
        end,
        desc = "Colorschemes",
      },
      {
        "<leader>fq",
        function()
          require("fzf-lua").quickfix()
        end,
        desc = "Quickfix",
      },
      {
        "<leader>fl",
        function()
          require("fzf-lua").loclist()
        end,
        desc = "Location List",
      },
      {
        "<leader>fg",
        function()
          require("fzf-lua").global()
        end,
        desc = "Global Search",
      },
      {
        "<leader>fa",
        function()
          require("fzf-lua").autocmds()
        end,
        desc = "Autocmds",
      },
      {
        "<leader>fl",
        function()
          require("fzf-lua").loclist()
        end,
        desc = "Location List",
      },
      {
        "<leader>fk",
        function()
          require("fzf-lua").keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>fj",
        function()
          require("fzf-lua").jumps()
        end,
        desc = "Jumps",
      },
      {
        "<leader>fr",
        function()
          require("fzf-lua").registers()
        end,
        desc = "Registers",
      },
      -- git
      {
        "<leader>gf",
        function()
          require("fzf-lua").git_files()
        end,
        desc = "Git Files",
      },
      {
        "<leader>gb",
        function()
          require("fzf-lua").git_branches()
        end,
        desc = "Git Branches",
      },
      {
        "<leader>gc",
        function()
          require("fzf-lua").git_commits()
        end,
        desc = "Git Commits",
      },
      {
        "<leader>gC",
        function()
          require("fzf-lua").git_bcommits()
        end,
        desc = "Buffer Commits",
      },
      {
        "<leader>gs",
        function()
          require("fzf-lua").git_status()
        end,
        desc = "Git Status",
      },
      {
        "<leader>gd",
        function()
          require("fzf-lua").git_diff()
        end,
        desc = "Git Diff",
      },
      {
        "<leader>gB",
        function()
          require("fzf-lua").git_blame()
        end,
        desc = "Git Blame",
      },
      {
        "<leader>gt",
        function()
          require("fzf-lua").git_tags()
        end,
        desc = "Git Tags",
      },
      {
        "<leader>gh",
        function()
          require("fzf-lua").git_hunks()
        end,
        desc = "Git Hunks",
      },
      {
        "<leader>gw",
        function()
          require("fzf-lua").git_worktrees()
        end,
        desc = "Git Worktrees",
      },
    },
    config = function(_, opts)
      require("fzf-lua").setup(opts)
    end,
  },
  {
    "stephansama/fzf-nerdfont.nvim",
    lazy = true,
    build = ":FzfNerdfont generate",
    dependencies = { "ibhagwan/fzf-lua" },
    cmd = "FzfNerdfont",
    keys = {
      { "<leader>fi", "<CMD>FzfNerdfont<CR>", desc = "Nerd Font Picker" },
    },
  },
}
