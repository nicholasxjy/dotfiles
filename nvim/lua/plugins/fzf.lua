local ui = require("core.ui")

return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "nvim-mini/mini.icons" },
    opts = {
      "borderless",
      "hide",
      fzf_colors = true,
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      winopts = {
        height = 0.9, -- window height
        -- width = 0.8, -- window width
        row = 1, -- window row position (0=top, 1=bottom)
        -- col = 0.2,
        border = "none",
        backdrop = 100,
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
        git_icons = true,
        file_icons = true,
        color_icons = true,
        formatter = "path.filename_first",
      },
      oldfiles = {
        formatter = "path.filename_first",
      },
      buffers = {
        formatter = "path.filename_first",
      },
      lsp = {
        symbols = {
          symbol_icons = ui.icons.mini_kind_icons,
        },
      },
      diagnostics = {
        cwd_only = true,
        file_icons = true,
        git_icons = true,
      },
      debug = true,
    },
    keys = {
      -- {
      --   "<leader>h",
      --   function()
      --     require("fzf-lua").buffers({
      --       winopts = ui.fzf.mini_pick.winopts,
      --       sort_lastused = true,
      --       current = false,
      --       previewer = false,
      --     })
      --   end,
      --   desc = "Fzf buffers",
      --   silent = true,
      -- },
      -- {
      --   "<leader>m",
      --   function()
      --     require("fzf-lua").marks()
      --   end,
      --   desc = "Fzf marks",
      -- },
      -- {
      --   "<leader>sw",
      --   function()
      --     require("fzf-lua").grep_cword()
      --   end,
      --   desc = "Fzf grep cword",
      --   silent = true,
      -- },
      -- {
      --   "<leader>sv",
      --   function()
      --     require("fzf-lua").grep_visual()
      --   end,
      --   desc = "Fzf grep visual",
      --   silent = true,
      --   mode = { "n", "v", "x" },
      -- },
      {
        "<leader>sp",
        function()
          require("fzf-lua").grep_project()
        end,
        desc = "Fzf grep project",
      },
      -- {
      --   "<leader>sg",
      --   function()
      --     require("fzf-lua").live_grep_native()
      --   end,
      --   desc = "Fzf grep",
      -- },
      {
        "<leader>:",
        function()
          require("fzf-lua").commands()
        end,
        desc = "Fzf commands",
      },
      -- {
      --   "<leader>r",
      --   function()
      --     require("fzf-lua").resume()
      --   end,
      --   desc = "Fzf resume",
      -- },
      -- {
      --   "<leader>/",
      --   function()
      --     require("fzf-lua").blines()
      --   end,
      --   desc = "Fzf blines",
      -- },
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
          require("fzf-lua").global({
            winopts = ui.fzf.ivy.winopts,
          })
        end,
        desc = "Global",
      },
      {
        "<leader>fa",
        function()
          require("fzf-lua").autocmds({ winopts = ui.fzf.dropdown.winopts })
        end,
        desc = "Fzf Autocmds",
      },
      {
        "<leader>fl",
        function()
          require("fzf-lua").loclist({ winopts = ui.fzf.dropdown.winopts })
        end,
        desc = "Fzf location list",
      },
      {
        "<leader>fk",
        function()
          require("fzf-lua").keymaps({ winopts = ui.fzf.dropdown.winopts })
        end,
        desc = "Fzf keymaps",
      },
      {
        "<leader>fj",
        function()
          require("fzf-lua").jumps({ winopts = ui.fzf.dropdown.winopts })
        end,
        desc = "Fzf jumps",
      },
      {
        "<leader>fr",
        function()
          require("fzf-lua").registers({ winopts = ui.fzf.dropdown.winopts })
        end,
        desc = "Fzf registers",
      },
      -- git
      {
        "<leader>gf",
        function()
          require("fzf-lua").git_files({ winopts = ui.fzf.dropdown.winopts })
        end,
        desc = "Git files",
      },
      {
        "<leader>gb",
        function()
          require("fzf-lua").git_branches({ winopts = ui.fzf.dropdown.winopts })
        end,
        desc = "Git branches",
      },
      {
        "<leader>gc",
        function()
          require("fzf-lua").git_commits({ winopts = ui.fzf.dropdown.winopts })
        end,
        desc = "Git commits",
      },
      {
        "<leader>gC",
        function()
          require("fzf-lua").git_bcommits({ winopts = ui.fzf.dropdown.winopts })
        end,
        desc = "Git bcommits",
      },
      {
        "<leader>gs",
        function()
          require("fzf-lua").git_status({ winopts = ui.fzf.dropdown.winopts })
        end,
        desc = "Git status",
      },
      {
        "<leader>gd",
        function()
          require("fzf-lua").git_diff({ winopts = ui.fzf.dropdown.winopts })
        end,
        desc = "Git diff",
      },
      {
        "<leader>gB",
        function()
          require("fzf-lua").git_blame({ winopts = ui.fzf.dropdown.winopts })
        end,
        desc = "Git blame",
      },
      {
        "<leader>gt",
        function()
          require("fzf-lua").git_tags({ winopts = ui.fzf.dropdown.winopts })
        end,
        desc = "Git tags",
      },
      {
        "<leader>gh",
        function()
          require("fzf-lua").git_hunks({ winopts = ui.fzf.dropdown.winopts })
        end,
        desc = "Git hunks",
      },
      {
        "<leader>gw",
        function()
          require("fzf-lua").git_worktrees({ winopts = ui.fzf.dropdown.winopts })
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
    ---@module 'fzf-nerdfont'
    ---@type FzfNerdFontOpts
    opts = {},
  },
}
