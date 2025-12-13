local ui = require("core.ui")

return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "nvim-mini/mini.icons" },
    opts = {
      "border-fused",
      "hide",
      fzf_colors = true,
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      winopts = {
        height = 0.9, -- window height
        width = 1, -- window width
        row = 1, -- window row position (0=top, 1=bottom)
        col = 0,
        border = "rounded",
        backdrop = 100,
        preview = {
          border = "rounded",
          wrap = true,
          hidden = false,
          layout = "vertical",
          vertical = "up:55%",
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
    },
    keys = {
      {
        "nn",
        function()
          require("fzf-lua").buffers({
            sort_lastused = true,
            winopts = ui.fzf.ivy_pick.winopts,
          })
        end,
        desc = "Fzf buffers",
        silent = true,
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
}
