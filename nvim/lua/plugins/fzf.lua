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
        width = 0.9,
        height = 0.5,
        row = 0.9,
        border = "single",
        treesitter = {
          enabled = true,
        },
        preview = {
          title_pos = "center",
          horizontal = "right:45%",
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
        "/",
        function()
          require("fzf-lua").grep_curbuf()
        end,
        desc = "Grep on current buffer",
        noremap = true,
        silent = true,
      },
      {
        "<leader>h",
        function()
          require("fzf-lua").buffers({ sort_lastused = true })
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
        "<leader><space>",
        function()
          require("fzf-lua").files({ cwd_only = true })
        end,
        desc = "Find files better",
      },
      {
        "<leader>ff",
        function()
          require("fzf-lua").files()
        end,
        desc = "Find files",
      },
      {
        "<leader>ft",
        function()
          require("fzf-lua").colorschemes()
        end,
        desc = "Find themes",
      },
      {
        "<leader>sw",
        function()
          require("fzf-lua").grep_cword()
        end,
        desc = "Find word under cursor (cwd)",
      },
      {
        "<leader>sg",
        function()
          require("fzf-lua").live_grep_native()
        end,
        desc = "Live grep",
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
    },
    config = function(_, opts)
      local fzfLua = require("fzf-lua")
      fzfLua.setup(opts)
    end,
  },
}
