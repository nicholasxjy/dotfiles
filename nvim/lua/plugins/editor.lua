return {
  {
    "folke/persistence.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>S",
        function()
          require("persistence").select()
        end,
        desc = "Sessions",
      },
    },
    opts = {
      dir = vim.fn.stdpath("state") .. "/sessions/",
      need = 1,
      branch = true,
    },
    config = function(_, opts)
      local ps = require("persistence")
      ps.setup(opts)
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },
  {
    "mcauley-penney/visual-whitespace.nvim",
    event = "VeryLazy",
    config = true,
    opts = {
      highlight = { link = "LineNr" },
    },
  },
  {
    "NStefan002/screenkey.nvim",
    cmd = "Screenkey",
    opts = {
      win_opts = {
        row = vim.o.lines - vim.o.cmdheight - 1,
        col = vim.o.columns - 1,
        relative = "editor",
        anchor = "SE",
        width = 20,
        height = 2,
        border = "single",
        title = "Screenkey",
        title_pos = "center",
        style = "minimal",
        focusable = false,
        noautocmd = true,
      },
      hl_groups = {
        ["screenkey.hl.key"] = { link = "Type" },
        ["screenkey.hl.map"] = { link = "Keyword" },
        ["screenkey.hl.sep"] = { link = "Normal" },
      },
    },
  },
  {
    "Wansmer/treesj",
    keys = {
      {
        "gS",
        function()
          require("treesj").toggle()
        end,
        desc = "Toggle Split",
        silent = true,
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
