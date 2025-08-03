local icons = require("core.icons")
return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      "ivy",
      "hide",
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      winopts = {
        -- width = 0.95,
        -- height = 0.85,
        preview = {
          layout = "horizontal",
          horizontal = "right:50%",
        },
      },
      files = {
        multiprocess = true, -- run command in a separate process
        git_icons = true, -- show git icons?
        file_icons = true, -- show file icons (true|"devicons"|"mini")?
        color_icons = true, -- colorize file|git icons
        formatter = "path.filename_first",
      },
      buffers = { formatter = "path.filename_first" },
      lsp = { symbols = { symbol_icons = icons.symbol_map } },
      grep = {
        hidden = false, -- disable hidden files by default
        follow = false, -- do not follow symlinks by default
        no_ignore = true, -- respect ".gitignore"  by defaul
      },
      diagnostics = {
        cwd_only = true,
        file_icons = true,
        git_icons = true,
      },
    },
    keys = {
      -- stylua: ignore start
      { "<leader>r", function() require("fzf-lua").resume() end, desc = "Resume", },
      { "<leader>:", function() require("fzf-lua").commands() end, desc = "Commands", },
      { "<leader>/", function() require("fzf-lua").lgrep_curbuf() end, desc = "Find words in current buffer", },
      { "<leader>m", function() require("fzf-lua").marks() end, desc = "Fzf marks", },
      { "<leader>h", function() require("fzf-lua").buffers({ sort_lastused  = true, cwd_only = true, previewer = false }) end, desc = "Fzf buffers", },
      { "<leader><space>", function() require("fzf-lua").global({ previewer = false }) end, desc = "Fzf global", },
      { "<leader>ff", function() require("fzf-lua").files() end, desc = "Fzf files"},
      { "<leader>fa", function() require("fzf-lua").autocmds() end, desc = "Autocmds", },
      { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers", },
      { "<leader>fc", function() require("fzf-lua").colorschemes() end, desc = "Colorschemes", },
      { "<leader>fo", function() require("fzf-lua").oldfiles() end, desc = "Oldfiles", },
      { "<leader>fl", function() require("fzf-lua").loclist() end, desc = "Location list", },
      { "<leader>fk", function() require("fzf-lua").keymaps() end, desc = "Keymaps", },
      { "<leader>fj", function() require("fzf-lua").jumps() end, desc = "Jumps", },
      { "<leader>fr", function() require("fzf-lua").registers() end, desc = "Registers", },

      { "<leader>xq", function() require("fzf-lua").quickfix() end, desc = "Quickfix", },
      { "<leader>sg", function() require("fzf-lua").live_grep_native() end, desc = "Grep", },
      { "<leader>sr", function() require("fzf-lua").live_grep_resume() end, desc = "Grep resume", },
      { "<leader>sG", function() require("fzf-lua").live_grep_glob() end, desc = "Grep glob", },
      { "<leader>sw", function() require("fzf-lua").grep_cword() end, desc = "Find word under the cursor", mode = { "n", "x" }, },
      { "<leader>sl", function () require("fzf-lua").grep_last() end, desc = "Grep again" },
      { "<leader>sv", function() require("fzf-lua").grep_visual() end, desc = "Find visual selection", mode = { "n", "x" }, },

      { "<leader>gf", function() require("fzf-lua").git_files() end, desc = "Git files", },
      { "<leader>gb", function() require("fzf-lua").git_branches() end, desc = "Git branches", },
      { "<leader>gB", function() require("fzf-lua").git_blame() end, desc = "Git blame", },
      { "<leader>gc", function() require("fzf-lua").git_commits() end, desc = "Git commit log", },
      { "<leader>gC", function() require("fzf-lua").git_bcommits() end, desc = "Git commit file log", },
      { "<leader>gs", function() require("fzf-lua").git_status() end, desc = "Git status", },
      { "<leader>gt", function() require("fzf-lua").git_tags() end, desc = "Git tags", },
      { "<leader>gD", function() require("fzf-lua").git_diff() end, desc = "Git diff", },
      { "<leader>gh", function() require("fzf-lua").git_hunks() end, desc = "Git hunks", },
      -- stylua: ignore end
    },
    config = function(_, opts)
      require("fzf-lua").setup(opts)
      require("fzf-lua").register_ui_select()
    end,
  },
}
