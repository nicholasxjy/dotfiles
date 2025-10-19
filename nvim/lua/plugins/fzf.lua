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
          locate = true,
          symbol_icons = ui.icons.lspkind_kind_icons,
          symbol_hl = function(s)
            return "@" .. s:lower()
          end,
          symbol_fmt = function(s)
            return "[" .. s .. "]"
          end,
        },
      },
      diagnostics = {
        cwd_only = true,
        file_icons = true,
        git_icons = true,
      },
    },
    keys = {
      -- stylua: ignore start
      { "<leader>:", function() require("fzf-lua").commands() end, desc = "Commands", },
      { "<leader>/", function() require("fzf-lua").lgrep_curbuf() end, desc = "Find words in current buffer", },
      { "<leader>m", function() require("fzf-lua").marks() end, desc = "Fzf marks", },
      { "<leader>bb", function() require("fzf-lua").blines() end, desc = "Fzf blines", },
      { "<leader>fg", function() require("fzf-lua").global() end, desc = "Global", },
      { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers", },
      { "<leader>gB", function() require("fzf-lua").git_blame() end, desc = "Git blame", },
      { "<leader>gt", function() require("fzf-lua").git_tags() end, desc = "Git tags", },
      { "<leader>gh", function() require("fzf-lua").git_hunks() end, desc = "Git hunks", },
      -- stylua: ignore end
    },
    config = function(_, opts)
      require("fzf-lua").setup(opts)
    end,
  },
}
