local icons = require("core.icons")

return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      "default-title",
      "hide",
      fzf_colors = true,
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      winopts = {
        width = 0.9,
        height = 0.86,
        border = vim.g.bordered and "rounded" or "none",
        preview = {
          border = vim.g.bordered and "rounded" or "none",
          layout = "vertical",
          vertical = "up:45%",
        },
      },
      files = {
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
        -- formatter = "path.filename_first",
      },
      buffers = {
        -- formatter = "path.filename_first",
        winopts = {
          width = 0.55,
          height = 0.4,
          row = 0.8,
        },
      },
      lsp = {
        symbols = {
          locate = true,
          symbol_style = 2,
          symbol_icons = icons.lspkind,
          symbol_hl = function(s)
            return "@" .. s:lower()
          end,
          symbol_fmt = function(s)
            return "[" .. s .. "]"
          end,
        },
      },
      grep = {
        hidden = false, -- disable hidden files by default
        follow = false, -- do not follow symlinks by default
        no_ignore = false, -- respect ".gitignore"  by defaul
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
          require("fzf-lua").buffers({ sort_lastused = true, cwd_only = true, previewer = false })
        end,
        desc = "Fzf buffers",
      },
      -- stylua: ignore start
      { "<leader>r", function() require("fzf-lua").resume() end, desc = "Resume", },
      { "<leader>:", function() require("fzf-lua").commands() end, desc = "Commands", },
      { "<leader>/", function() require("fzf-lua").lgrep_curbuf() end, desc = "Find words in current buffer", },
      { "<leader>m", function() require("fzf-lua").marks() end, desc = "Fzf marks", },
      { "<leader>fg", function() require("fzf-lua").global() end, desc = "Global", },
      { "<leader>fa", function() require("fzf-lua").autocmds() end, desc = "Autocmds", },
      { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers", },
      { "<leader>fl", function() require("fzf-lua").loclist() end, desc = "Location list", },
      { "<leader>fk", function() require("fzf-lua").keymaps() end, desc = "Keymaps", },
      { "<leader>fj", function() require("fzf-lua").jumps() end, desc = "Jumps", },
      { "<leader>fr", function() require("fzf-lua").registers() end, desc = "Registers", },
      { "<leader>xq", function() require("fzf-lua").quickfix() end, desc = "Quickfix", },
      { "<leader>sg", function() require("fzf-lua").live_grep_native() end, desc = "Grep", },
      { "<leader>sl", function() require("fzf-lua").live_grep_native({ resume = true }) end, desc = "Grep resume", },
      { "<leader>sG", function() require("fzf-lua").live_grep_glob() end, desc = "Grep glob", },
      { "<leader>sw", function() require("fzf-lua").grep_cword() end, desc = "Find word under the cursor", mode = { "n", "x" }, },
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
