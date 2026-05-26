local mini_pick = {
  height = 0.4,
  width = 0.7,
  row = 0.5,
  border = "none",
  backdrop = 70,
}

local function fzf_call(method, opts)
  return function()
    require("fzf-lua")[method](opts)
  end
end

local fzf_mappings = {
  { "<leader>R", "resume", nil, "Fzf resume" },
  { "<leader>/", "grep_curbuf", nil, "Grep current buffer" },
  { "<leader>:", "commands", nil, "Commands" },
  { "<leader>m", "marks", { winopts = mini_pick, previewer = false }, "Marks" },
  { "<leader>fb", "buffers", { cwd_only = true }, "Buffers" },
  { "<leader>fc", "colorschemes", nil, "Colorschemes" },
  { "<leader>fq", "quickfix", nil, "Quickfix" },
  { "<leader>fl", "loclist", nil, "Location List" },
  { "<leader>fg", "global", nil, "Global Search" },
  { "<leader>fa", "autocmds", nil, "Autocmds" },
  { "<leader>fk", "keymaps", nil, "Keymaps" },
  { "<leader>fj", "jumps", nil, "Jumps" },
  { "<leader>fr", "registers", nil, "Registers" },
  { "<leader>gf", "git_files", nil, "Git Files" },
  { "<leader>gb", "git_branches", nil, "Git Branches" },
  { "<leader>gc", "git_commits", nil, "Git Commits" },
  { "<leader>gC", "git_bcommits", nil, "Buffer Commits" },
  { "<leader>gs", "git_status", nil, "Git Status" },
  { "<leader>gd", "git_diff", nil, "Git Diff" },
  { "<leader>gB", "git_blame", nil, "Git Blame" },
  { "<leader>gt", "git_tags", nil, "Git Tags" },
  { "<leader>gh", "git_hunks", nil, "Git Hunks" },
  { "<leader>gw", "git_worktrees", nil, "Git Worktrees" },
}

local function fzf_keys()
  local keys = {}
  for _, mapping in ipairs(fzf_mappings) do
    keys[#keys + 1] = { mapping[1], fzf_call(mapping[2], mapping[3]), desc = mapping[4] }
  end
  return keys
end

local function ufo_handler(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("  %d lines... "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

local modes_opts = {
  colors = {
    bg = "#3A0519",
  },
  line_opacity = 0.15,
  set_cursor = false,
  set_cursorline = true,
  set_number = true,
  set_signcolumn = true,
  ignore = { "NvimTree", "TelescopePrompt", "!minifiles" },
}

local screenkey_opts = {
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
}

local tiny_opts = {
  preset = "modern",
  transparent_bg = false,
  transparent_cursorline = true,
  signs = {
    vertical = " │",
    vertical_end = " └",
  },
  blend = {
    factor = 0.1,
  },
  options = {
    show_source = {
      enabled = true,
      if_many = true,
    },
    add_messages = {
      display_count = true,
    },
    set_arrow_to_diag_color = true,
    multilines = {
      enabled = true,
      always_show = true,
    },
    show_all_diags_on_cursorline = true,
    enable_on_insert = false,
    enable_on_select = false,
  },
}

local function yanky_put(type, is_visual)
  return function()
    require("yanky").put(type, is_visual)
  end
end

return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    init = function()
      _G.__setup_fzf = function()
        require("lazy").load({ plugins = { "fzf-lua" }, wait = true })
        return require("fzf-lua")
      end
    end,
    keys = fzf_keys(),
    opts = {
      "border-fused",
      fzf_colors = true,
      defaults = {
        formatter = "path.filename_first",
      },
      winopts = {
        height = 1,
        width = 0.9,
        row = 1,
        border = "single",
        backdrop = 50,
        preview = {
          border = "single",
          wrap = true,
          hidden = false,
          layout = "vertical",
          vertical = "up:50%",
        },
      },
      files = {
        multiprocess = true,
      },
      diagnostics = {
        cwd_only = true,
      },
      debug = false,
    },
  },

  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>sr",
        function()
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          require("grug-far").open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Find and replace",
      },
    },
    opts = {
      headerMaxWidth = 80,
    },
  },

  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
      {
        "<leader>o",
        function()
          require("oil").open()
        end,
        desc = "Oil",
        silent = true,
      },
    },
    opts = {
      default_file_explorer = true,
      watch_for_changes = false,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      confirmation = {
        border = "single",
      },
      keymaps = {
        ["q"] = "actions.close",
        ["<Esc>"] = "actions.parent",
      },
    },
  },

  {
    "folke/flash.nvim",
    keys = {
      {
        "s",
        function()
          require("flash").jump()
        end,
        mode = { "n", "x", "o" },
        desc = "Flash",
      },
      {
        "S",
        function()
          require("flash").treesitter()
        end,
        mode = { "n", "x", "o" },
        desc = "Flash treesitter",
      },
    },
    opts = {
      label = {
        rainbow = {
          enabled = true,
          shade = 5,
        },
      },
    },
  },

  {
    "jake-stewart/multicursor.nvim",
    keys = {
      {
        "\\",
        function()
          require("multicursor-nvim").addCursor()
        end,
        mode = { "n", "x" },
        desc = "Add Cursor",
      },
      {
        "<up>",
        function()
          require("multicursor-nvim").lineAddCursor(-1)
        end,
        mode = { "n", "x" },
        desc = "Add Cursor Above",
      },
      {
        "<down>",
        function()
          require("multicursor-nvim").lineAddCursor(1)
        end,
        mode = { "n", "x" },
        desc = "Add Cursor Below",
      },
      {
        "<leader><up>",
        function()
          require("multicursor-nvim").lineSkipCursor(-1)
        end,
        mode = { "n", "x" },
      },
      {
        "<leader><down>",
        function()
          require("multicursor-nvim").lineSkipCursor(1)
        end,
        mode = { "n", "x" },
      },
      {
        "<C-d>",
        function()
          require("multicursor-nvim").matchAddCursor(1)
        end,
        mode = { "n", "x" },
        desc = "Match Next",
      },
      {
        "\\n",
        function()
          require("multicursor-nvim").matchAddCursor(-1)
        end,
        mode = { "n", "x" },
        desc = "Match Prev",
      },
      {
        "<c-leftmouse>",
        function()
          require("multicursor-nvim").handleMouse()
        end,
      },
      {
        "<c-leftdrag>",
        function()
          require("multicursor-nvim").handleMouseDrag()
        end,
      },
      {
        "<c-leftrelease>",
        function()
          require("multicursor-nvim").handleMouseRelease()
        end,
      },
      {
        "<c-q>",
        function()
          require("multicursor-nvim").toggleCursor()
        end,
        mode = { "n", "x" },
      },
    },
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      mc.addKeymapLayer(function(layerSet)
        layerSet({ "n", "x" }, "<left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<right>", mc.nextCursor)
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "IncSearch" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },

  {
    "mrjones2014/smart-splits.nvim",
    keys = {
      {
        "<c-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Focus Left",
      },
      {
        "<c-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "Focus Down",
      },
      {
        "<c-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "Focus Up",
      },
      {
        "<c-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Focus Right",
      },
    },
    opts = {
      ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
      ignored_buftypes = { "nofile" },
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "kevinhwang91/promise-async",
    },
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open All Folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close All Folds",
      },
      {
        "zr",
        function()
          require("ufo").openFoldsExceptKinds()
        end,
        desc = "Open More Folds",
      },
      {
        "zm",
        function()
          require("ufo").closeFoldsWith()
        end,
        desc = "Close More Folds",
      },
      {
        "zp",
        function()
          require("ufo").peekFoldedLinesUnderCursor()
        end,
        desc = "Peek Fold",
      },
    },
    opts = {
      preview = {
        mappings = {
          scrollB = "<C-B>",
          scrollF = "<C-F>",
          scrollU = "<C-U>",
          scrollD = "<C-D>",
        },
      },
      provider_selector = function(_, filetype, buftype)
        if filetype == "" or buftype == "nofile" then
          return "indent"
        end

        return { "treesitter", "indent" }
      end,
      fold_virt_text_handler = ufo_handler,
    },
  },

  {
    "rrethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "]]",
        function()
          require("illuminate").goto_next_reference()
        end,
        desc = "Next reference",
      },
      {
        "[[",
        function()
          require("illuminate").goto_prev_reference()
        end,
        desc = "Prev reference",
      },
    },
    opts = {
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
      delay = 250,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  {
    "gbprod/yanky.nvim",
    keys = {
      { "p", yanky_put("p", false), desc = "Put After" },
      { "P", yanky_put("P", false), desc = "Put Before" },
      { "gp", yanky_put("gp", false), desc = "Put After and Leave Cursor After" },
      { "gP", yanky_put("gP", false), desc = "Put Before and Leave Cursor Before" },
      { "p", yanky_put("p", true), mode = "x", desc = "Put After" },
      { "P", yanky_put("P", true), mode = "x", desc = "Put Before" },
      { "gp", yanky_put("gp", true), mode = "x", desc = "Put After and Leave Cursor After" },
      { "gP", yanky_put("gP", true), mode = "x", desc = "Put Before and Leave Cursor Before" },
      {
        "<leader>up",
        function()
          require("yanky")
          ---@diagnostic disable-next-line: undefined-field
          Snacks.picker.yanky()
        end,
        mode = { "n", "x" },
        desc = "Open Yank History",
      },
    },
    opts = {
      system_clipboard = {
        sync_with_ring = true,
        clipboard_register = nil,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 500,
      },
      preserve_cursor_position = {
        enabled = true,
      },
    },
  },

  {
    "mvllow/modes.nvim",
    event = "VeryLazy",
    opts = modes_opts,
  },

  {
    "NStefan002/screenkey.nvim",
    cmd = "Screenkey",
    opts = screenkey_opts,
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
    opts = {
      use_default_keymaps = false,
    },
  },

  {
    "mcauley-penney/visual-whitespace.nvim",
    event = "ModeChanged *:[vV\22]",
    init = function()
      vim.g.visual_whitespace = {
        enabled = true,
        highlight = { link = "LineNr", default = true },
        match_types = {
          space = true,
          tab = true,
          nbsp = true,
          lead = true,
          trail = false,
        },
        list_chars = {
          space = "·",
          tab = "↦",
          nbsp = "␣",
          lead = "‹",
          trail = "›",
        },
        fileformat_chars = {
          unix = "↲",
          mac = "←",
          dos = "↙",
        },
        ignore = { filetypes = {}, buftypes = {} },
      }
    end,
  },

  {
    "nicholasxjy/jishiben.nvim",
    cmd = { "JishibenOpen", "JishibenClear" },
    event = "VeryLazy",
    opts = function()
      local width = math.max(1, vim.o.columns)
      local height = math.max(1, math.floor(vim.o.lines * 0.4) - 2)
      return {
        win = {
          border = "single",
          width = width,
          height = height,
          row = vim.o.lines - height - 2,
          col = 0,
        },
      }
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    cmd = "TinyInlineDiag",
    opts = tiny_opts,
    config = function(_, opts)
      pcall(vim.api.nvim_del_user_command, "TinyInlineDiag")
      require("tiny-inline-diagnostic").setup(opts)
      vim.g.tiny_inline_diagnostic_setup_done = true
    end,
  },
}
