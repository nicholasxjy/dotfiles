local ui = require("core.ui")

return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "nvim-mini/mini.icons" },
    opts = {
      "border-fused",
      "hide",
      fzf_colors = {
        true,
        ["hl+"] = { "fg", "SnacksPickerMatch", "bold", "italic", "underline" },
      },
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      winopts = {
        border = vim.g.bordered and "rounded" or "none",
        backdrop = vim.g.transparent and 100 or 80,
        width = 0.85,
        height = 0.95,
        row = 0.7,
        preview = {
          border = vim.g.bordered and "rounded" or "none",
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
      buffers = {
        formatter = "path.filename_first",
      },
      lsp = {
        symbols = {
          symbol_icons = ui.icons.lspkind_kind_icons,
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
        "<leader>:",
        function()
          require("fzf-lua").commands({
            winopts = ui.fzf.ivy.winopts,
          })
        end,
        desc = "Fzf commands",
      },
      {
        "<leader>/",
        function()
          require("fzf-lua").blines({
            winopts = ui.fzf.dropdown.winopts,
          })
        end,
        desc = "Fzf blines",
      },
      {
        "<leader>m",
        function()
          require("fzf-lua").marks({
            winopts = ui.fzf.ivy.winopts,
          })
        end,
        desc = "Fzf marks",
      },
      {
        "<leader>r",
        function()
          require("fzf-lua").live_grep({
            resume = true,
            winopts = ui.fzf.dropdown.winopts,
          })
        end,
        desc = "Fzf resume live grep",
      },

      {
        "<leader>R",
        function()
          require("fzf-lua").resume()
        end,
        desc = "Fzf resume",
      },
      {
        "nn",
        function()
          require("fzf-lua").buffers({
            sort_lastused = true,
            ignore_current_buffer = false,
            winopts = ui.fzf.ivy.winopts,
            cwd_only = true,
          })
        end,
        desc = "Fzf buffers",
        silent = true,
      },
      -- search
      {
        "<leader>sg",
        function()
          require("fzf-lua").live_grep({
            winopts = ui.fzf.dropdown.winopts,
            cwd_only = true,
          })
        end,
        desc = "Fzf live grep",
      },
      {
        "<leader>sG",
        function()
          require("fzf-lua").live_grep({
            winopts = ui.fzf.dropdown.winopts,
          })
        end,
        desc = "Fzf live grep (glob)",
      },
      {
        "<leader>sw",
        function()
          require("fzf-lua").grep_cword({
            winopts = ui.fzf.dropdown.winopts,
          })
        end,
        desc = "Fzf grep word under cursor",
      },
      {
        "<leader>sv",
        function()
          require("fzf-lua").grep_visual({
            winopts = ui.fzf.dropdown.winopts,
          })
        end,
        desc = "Fzf grep visual selection",
        mode = { "n", "x", "v" },
      },
      -- find
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
      {
        "<leader>xq",
        function()
          require("fzf-lua").qflist()
        end,
        desc = "Fzf quickfix",
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
}
