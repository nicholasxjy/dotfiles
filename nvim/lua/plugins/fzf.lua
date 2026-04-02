local ui = require("core.ui")

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
        symbols = {
          symbol_icons = ui.icons.lspkind_kind_icons,
        },
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
        desc = "Fzf blines",
      },
      {
        "<leader>:",
        function()
          require("fzf-lua").commands()
        end,
        desc = "Fzf commands",
      },
      {
        "<leader>m",
        function()
          require("fzf-lua").marks({
            winopts = ui.fzf.mini_pick.winopts,
            previewer = false,
          })
        end,
        desc = "Fzf marks",
      },
      {
        "<leader>fb",
        function()
          require("fzf-lua").buffers({
            cwd_only = true,
          })
        end,
        desc = "Fzf buffers",
      },
      {
        "<leader>fc",
        function()
          require("fzf-lua").colorschemes()
        end,
        desc = "Fzf colorschemes",
      },
      {
        "<leader>fq",
        function()
          require("fzf-lua").quickfix()
        end,
        desc = "Fzf quickfix",
      },
      {
        "<leader>fl",
        function()
          require("fzf-lua").loclist()
        end,
        desc = "Fzf loclist",
      },
      {
        "<leader>fg",
        function()
          require("fzf-lua").global()
        end,
        desc = "Global",
      },
      {
        "<leader>fa",
        function()
          require("fzf-lua").autocmds()
        end,
        desc = "Fzf Autocmds",
      },
      {
        "<leader>fl",
        function()
          require("fzf-lua").loclist()
        end,
        desc = "Fzf location list",
      },
      {
        "<leader>fk",
        function()
          require("fzf-lua").keymaps()
        end,
        desc = "Fzf keymaps",
      },
      {
        "<leader>fj",
        function()
          require("fzf-lua").jumps()
        end,
        desc = "Fzf jumps",
      },
      {
        "<leader>fr",
        function()
          require("fzf-lua").registers()
        end,
        desc = "Fzf registers",
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
        "<leader>gb",
        function()
          require("fzf-lua").git_branches()
        end,
        desc = "Git branches",
      },
      {
        "<leader>gc",
        function()
          require("fzf-lua").git_commits()
        end,
        desc = "Git commits",
      },
      {
        "<leader>gC",
        function()
          require("fzf-lua").git_bcommits()
        end,
        desc = "Git bcommits",
      },
      {
        "<leader>gs",
        function()
          require("fzf-lua").git_status()
        end,
        desc = "Git status",
      },
      {
        "<leader>gd",
        function()
          require("fzf-lua").git_diff()
        end,
        desc = "Git diff",
      },
      {
        "<leader>gB",
        function()
          require("fzf-lua").git_blame()
        end,
        desc = "Git blame",
      },
      {
        "<leader>gt",
        function()
          require("fzf-lua").git_tags()
        end,
        desc = "Git tags",
      },
      {
        "<leader>gh",
        function()
          require("fzf-lua").git_hunks()
        end,
        desc = "Git hunks",
      },
      {
        "<leader>gw",
        function()
          require("fzf-lua").git_worktrees()
        end,
        desc = "Git worktrees",
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
      { "<leader>fi", "<CMD>FzfNerdfont<CR>", desc = "Open fzf nerd font picker" },
    },
  },
}
