local ui = require("core.ui")
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
    "mvllow/modes.nvim",
    event = "VeryLazy",
    config = function()
      require("modes").setup({
        colors = ui.mode_colors,

        -- Set opacity for cursorline and number background
        line_opacity = 0.1,

        -- Enable cursor highlights
        set_cursor = true,

        -- Enable cursorline initially, and disable cursorline for inactive windows
        -- or ignored filetypes
        set_cursorline = false,

        -- Enable line number highlights to match cursorline
        set_number = true,

        -- Enable sign column highlights to match cursorline
        set_signcolumn = true,

        -- Disable modes highlights for specified filetypes
        -- or enable with prefix "!" if otherwise disabled (please PR common patterns)
        -- Can also be a function fun():boolean that disables modes highlights when true
        ignore = { "NvimTree", "TelescopePrompt", "!minifiles" },
      })
    end,
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
