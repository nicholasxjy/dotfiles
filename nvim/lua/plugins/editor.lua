local function config(name)
  return function()
    require("config." .. name)
  end
end

return {
  {
    "folke/snacks.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>j",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>bo",
        function()
          Snacks.bufdelete.other()
        end,
        desc = "Delete Other Buffers",
      },
      {
        "<C-/>",
        function()
          Snacks.terminal()
        end,
        desc = "Terminal",
      },
      {
        "<C-_>",
        function()
          Snacks.terminal()
        end,
        desc = "which_key_ignore",
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      { "<leader>us", desc = "Toggle Spelling" },
      { "<leader>uw", desc = "Toggle Wrap" },
      { "<leader>uL", desc = "Toggle Relative Number" },
      { "<leader>ud", desc = "Toggle Diagnostics" },
      { "<leader>ul", desc = "Toggle Line Number" },
      { "<leader>uc", desc = "Toggle Conceal Level" },
      { "<leader>ub", desc = "Toggle Dark Background" },
      { "<leader>uh", desc = "Toggle Inlay Hints" },
      { "<leader>ug", desc = "Toggle Indent" },
      { "<leader>uD", desc = "Toggle Dim" },
      { "<leader>e", desc = "Explorer" },
      { "<leader>r", desc = "Resume Search" },
      { "<leader>ff", desc = "Find Files" },
      { "<leader><space>", desc = "Find Files" },
      { "<leader>h", desc = "Find Buffers" },
      { "<leader>sw", mode = { "n", "x", "v" }, desc = "Grep Word" },
      { "<leader>sW", desc = "Grep Buffer Word" },
      { "<leader>sg", desc = "Live Grep" },
      { "<leader>sG", desc = "Global Grep" },
      { "<leader>xt", desc = "TODO/FIXME/NOTE etc" },
    },
    config = config("snacks"),
  },
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "nvim-mini/mini.icons" },
    keys = {
      { "gd", desc = "Goto Definition" },
      { "gD", desc = "Goto Declaration" },
      { "gr", desc = "Goto References" },
      { "gi", desc = "Goto Implementation" },
      { "gy", desc = "Goto TypeDefs" },
      { "gI", desc = "Incoming Calls" },
      { "gO", desc = "Outgoing Calls" },
      { "<leader>ss", desc = "Lsp Symbols" },
      { "<leader>sS", desc = "Workspace Lsp Symbols" },
      { "<leader>xx", desc = "Diagnostics" },
      { "<leader>xX", desc = "Workspace Diagnostics" },
      { "<leader>xw", desc = "Workspace Diagnostics (Warns)" },
      { "<leader>xe", desc = "Workspace Diagnostics (Errors)" },
      { "<leader>:", desc = "Commands" },
      { "<leader>/", desc = "Grep Current Buffer" },
      { "<leader>m", desc = "Marks" },
      { "<leader>fa", desc = "Autocmds" },
      { "<leader>fc", desc = "Colorschemes" },
      { "<leader>fi", desc = "Filetypes" },
      { "<leader>fl", desc = "Location List" },
      { "<leader>fk", desc = "Keymaps" },
      { "<leader>fh", desc = "Highlights" },
      { "<leader>fr", desc = "Registers" },
      { "<leader>fu", desc = "Undo Tree" },
      { "<leader>fq", desc = "Quickfix" },
      { "<leader>gb", desc = "Git Branches" },
      { "<leader>gl", desc = "Git Log" },
      { "<leader>gL", desc = "Git Log Line" },
      { "<leader>gs", desc = "Git Status" },
      { "<leader>gS", desc = "Git Stash" },
      { "<leader>gd", desc = "Git Diff Hunks" },
      { "<leader>gf", desc = "Git Log File" },
    },
    config = config("fzf"),
  },
  {
    "folke/flash.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
    },
    config = config("flash"),
  },
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      { "<leader>sr", mode = { "n", "v" }, desc = "Find and Replace" },
    },
    config = config("grug-far"),
  },
  {
    "mrjones2014/smart-splits.nvim",
    keys = {
      { "<C-h>", desc = "Focus Left" },
      { "<C-j>", desc = "Focus Down" },
      { "<C-k>", desc = "Focus Up" },
      { "<C-l>", desc = "Focus Right" },
    },
    config = config("smart-splits"),
  },
  {
    "jake-stewart/multicursor.nvim",
    keys = {
      { "\\", mode = { "n", "x" }, desc = "Add Cursor" },
      { "<Up>", mode = { "n", "x" }, desc = "Add Cursor Above" },
      { "<Down>", mode = { "n", "x" }, desc = "Add Cursor Below" },
      { "<leader><Up>", mode = { "n", "x" }, desc = "Skip Cursor Above" },
      { "<leader><Down>", mode = { "n", "x" }, desc = "Skip Cursor Below" },
      { "<C-d>", mode = { "n", "x" }, desc = "Match Next" },
      { "\\n", mode = { "n", "x" }, desc = "Match Previous" },
      { "<C-LeftMouse>", desc = "Add Cursor with Mouse" },
      { "<C-LeftDrag>", desc = "Drag Cursor with Mouse" },
      { "<C-LeftRelease>", desc = "Release Cursor with Mouse" },
      { "<C-q>", mode = { "n", "x" }, desc = "Toggle Cursor" },
    },
    config = config("multicursor"),
  },
  {
    "stevearc/oil.nvim",
    keys = {
      { "<leader>o", desc = "Oil" },
    },
    dependencies = { "nvim-mini/mini.icons", "folke/snacks.nvim" },
    config = config("oil"),
  },
  {
    "nicholasxjy/yazi.nvim",
    keys = {
      { "<leader>-", desc = "Yazi" },
    },
    init = function()
      vim.g.loaded_netrwPlugin = 1
    end,
    config = config("yazi"),
  },
  {
    "nvim-mini/mini.files",
    keys = {
      {
        "<leader>E",
        function()
          local bufname = vim.api.nvim_buf_get_name(0)
          local path = vim.fn.fnamemodify(bufname, ":p")
          if path ~= "" and vim.uv.fs_stat(path) then
            require("mini.files").open(bufname, false)
          else
            require("mini.files").open()
          end
        end,
        desc = "Mini Files",
      },
    },
    dependencies = { "nvim-mini/mini.icons" },
    config = config("mini-files"),
  },
  {
    "nvim-mini/mini.clue",
    event = "VeryLazy",
    dependencies = { "nicholasxjy/minibuffer.nvim" },
    config = config("mini-clue"),
  },
  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-mini/mini.surround",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        replace = "gsr",
        find = "gsf",
      },
    },
  },
  {
    "nvim-mini/mini.trailspace",
    keys = {
      {
        "<leader>ut",
        function()
          require("mini.trailspace").trim()
        end,
        desc = "Trim Trailing Space",
      },
    },
    opts = { only_in_normal_buffers = true },
  },
  {
    "kevinhwang91/nvim-ufo",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "kevinhwang91/promise-async" },
    keys = {
      { "zR", desc = "Open All Folds" },
      { "zM", desc = "Close All Folds" },
      { "zr", desc = "Open More Folds" },
      { "zm", desc = "Close More Folds" },
      { "zp", desc = "Peek Fold" },
    },
    config = config("ufo"),
  },
  {
    "rrethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Previous Reference" },
    },
    config = config("illuminate"),
  },
  {
    "arnamak/stay-centered.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      skip_filetypes = {},
      enabled = true,
      allow_scroll_move = true,
      disable_on_mouse = true,
    },
  },
  {
    "nemanjamalesija/smart-paste.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "Wansmer/treesj",
    keys = {
      {
        "<leader>uJ",
        function()
          require("treesj").toggle()
        end,
        desc = "Toggle Split",
      },
    },
    opts = { use_default_keymaps = false },
  },
  {
    "nicholasxjy/jishiben.nvim",
    cmd = { "JishibenOpen", "JishibenNote", "JishibenTodo", "JishibenClear" },
    opts = { win = {} },
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-highlight-colors",
    opts = {},
  },
  {
    "nicholasxjy/translator.nvim",
    cmd = { "Trans", "TransWord" },
    keys = {
      {
        "<leader>bv",
        function()
          require("translator").transVisualSel()
        end,
        mode = "v",
        desc = "Translate Selection",
      },
      {
        "<leader>bc",
        function()
          require("translator").transCurWord()
        end,
        desc = "Translate Word",
      },
    },
    opts = {
      default_target_lang = "zh",
      default_source_lang = nil,
      window = { width = 60 },
    },
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
}
