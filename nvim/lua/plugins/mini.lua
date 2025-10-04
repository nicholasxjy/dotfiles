return {
  {
    "nvim-mini/mini.icons",
    lazy = true,
    version = false,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
        [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
        gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
        postcss = { glyph = "󰌜", hl = "MiniIconsOrange" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "nvim-mini/mini.ai",
    version = false,
    event = "VeryLazy",
    opts = {
      mappings = {
        around = "a",
        inside = "i",

        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",

        goto_left = "g[",
        goto_right = "g]",
      },
    },
  },
  {
    "nvim-mini/mini.surround",
    version = false,
    event = "VeryLazy",
    keys = {
      { "gsa", desc = "Add Surrounding", mode = { "n", "x" } },
      { "gsd", desc = "Delete Surrounding" },
      { "gsf", desc = "Find Right Surrounding" },
      { "gsF", desc = "Find Left Surrounding" },
      { "gsh", desc = "Highlight Surrounding" },
      { "gsr", desc = "Replace Surrounding" },
    },
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
  -- Split & join
  {
    "nvim-mini/mini.splitjoin",
    version = false,
    event = "VeryLazy",
    config = function()
      local miniSplitJoin = require("mini.splitjoin")
      miniSplitJoin.setup({
        mappings = { toggle = "gS" },
      })
    end,
  },
  {
    "nvim-mini/mini.trailspace",
    version = false,
    event = "VeryLazy",
    keys = {
      {
        "<leader>ut",
        function()
          require("mini.trailspace").trim()
        end,
        desc = "Trailspace",
      },
    },
    config = function()
      require("mini.trailspace").setup({
        only_in_normal_buffers = true,
      })
    end,
  },
  {
    "nvim-mini/mini.clue",
    version = false,
    event = "VeryLazy",
    keys = {
      { "<leader>a", "", desc = "+ai" },
      { "<leader>c", "", desc = "+codes" },
      { "<leader>f", "", desc = "+find" },
      { "<leader>s", "", desc = "+search" },
      { "<leader>x", "", desc = "+diagnostics" },
      { "<leader>g", "", desc = "+git" },
      { "<leader>u", "", desc = "+ui" },
      { "<leader>b", "", desc = "+buffers" },
      { "<leader>d", "", desc = "+debug" },
    },
    config = function()
      local miniclue = require("mini.clue")
      miniclue.setup({
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },
        clues = {
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
        window = {
          delay = 200,
        },
      })
    end,
  },
}
