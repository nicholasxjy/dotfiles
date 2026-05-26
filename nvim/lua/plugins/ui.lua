local vscode = {
  hidden = { "preview" },
  layout = {
    backdrop = true,
    width = 0.6,
    min_width = 80,
    height = 0.4,
    border = "none",
    box = "vertical",
    { win = "input", height = 1, border = true, title = "{title} {live} {flags}", title_pos = "center" },
    { win = "list", border = "hpad" },
    { win = "preview", title = "{preview}", border = true },
  },
}

local function pick(method, opts)
  return function()
    Snacks.picker[method](opts)
  end
end

local function toggle(callback)
  return function()
    callback(require("snacks").toggle):toggle()
  end
end

local cwd = { filter = { cwd = true } }

local notify_opts = {
  render = "wrapped-compact",
  stages = "fade_in_slide_out",
  on_open = function(win)
    local buf = vim.api.nvim_win_get_buf(win)
    vim.bo[buf].filetype = "markdown"
  end,
}

local progress_opts = {
  notification = notify_opts,
}

return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
      explorer = { enabled = true, replace_netrw = false },
      image = { enabled = true },
      dim = { enabled = false },
      bigfile = { enabled = true },
      zen = { enabled = false },
      scroll = { enabled = false },
      input = { enabled = true },
      words = { enabled = false },
      indent = { enabled = false },
      statuscolumn = {
        enabled = false,
        left = { "mark", "sign" },
        right = { "fold", "git" },
        folds = {
          open = true,
          git_hl = true,
        },
      },
      notifier = { enabled = false },
      toggle = { enabled = true },
      lazygit = { enabled = true },
      terminal = { enabled = true },
      scope = { enabled = true },
      gitbrowse = { enabled = true },
      picker = {
        enabled = true,
        prompt = "> ",
        ui_select = true,
        layout = {
          circle = false,
          layout = {
            ---@diagnostic disable-next-line: assign-type-mismatch
            backdrop = true,
            row = -1,
            width = 0.9,
            min_width = 80,
            border = "single",
            box = "vertical",
            { win = "preview", title = "{preview}", height = 0.45, border = "rounded" },
            {
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "none" },
              { win = "list", border = "rounded" },
            },
          },
        },
        matcher = {
          cwd_bonus = true,
          frecency = true,
          history_bonus = true,
        },
        formatters = {
          file = {
            filename_first = true,
            truncate = "center",
            git_status_hl = true,
          },
          severity = {
            icons = true,
            level = true,
            pos = "left",
          },
        },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["<a-a>"] = {
                "sidekick_send",
                mode = { "n", "i" },
              },
            },
          },
          list = {
            keys = {
              ["<c-j>"] = "list_down",
              ["<c-k>"] = "list_up",
              ["<c-n>"] = "list_down",
              ["<c-p>"] = "list_up",
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>j",
        function()
          Snacks.bufdelete({ wipe = true })
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
        "<c-/>",
        function()
          Snacks.terminal()
        end,
        desc = "Terminal",
      },
      {
        "<c-_>",
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
      {
        "<leader>E",
        function()
          Snacks.explorer()
        end,
        desc = "Explorer",
      },
      { "<leader>r", pick("resume"), desc = "Resume Search" },
      { "<leader>ff", pick("files", { hidden = true }), desc = "Find Files", silent = true },
      {
        "ff",
        pick("smart", { hidden = true, filter = cwd.filter, layout = vscode }),
        desc = "Find Files",
        silent = true,
      },
      {
        "nn",
        pick("buffers", {
          sort_lastused = true,
          current = true,
          layout = vscode,
          win = {
            input = { keys = { ["<c-x>"] = { "bufdelete", mode = { "n", "i" } } } },
            list = { keys = { ["dd"] = "bufdelete" } },
          },
        }),
        desc = "Find Buffers",
        silent = true,
      },
      {
        "<leader>sw",
        pick("grep_word", {
          formatters = { file = { filename_first = false } },
          filter = { cwd = true },
        }),
        mode = { "n", "x", "v" },
        desc = "Grep Word",
      },
      {
        "<leader>sg",
        pick("grep", {
          formatters = { file = { filename_first = false } },
          filter = { cwd = true },
        }),
        desc = "Live Grep",
      },
      {
        "<leader>sG",
        pick("grep", {
          formatters = { file = { filename_first = false } },
        }),
        desc = "Global Grep",
      },
      {
        "<leader>xt",
        function()
          require("lazy").load({ plugins = { "todo-comments.nvim" }, wait = true })
          ---@diagnostic disable-next-line: undefined-field
          Snacks.picker.todo_comments()
        end,
        desc = "TODO/FIXME/NOTE etc",
      },
      {
        "<leader>us",
        toggle(function(t)
          return t.option("spell", { name = "Spelling" })
        end),
        desc = "Toggle Spelling",
      },
      {
        "<leader>uw",
        toggle(function(t)
          return t.option("wrap", { name = "Wrap" })
        end),
        desc = "Toggle Wrap",
      },
      {
        "<leader>uL",
        toggle(function(t)
          return t.option("relativenumber", { name = "Relative Number" })
        end),
        desc = "Toggle Relative Number",
      },
      { "<leader>ud", toggle(function(t)
        return t.diagnostics()
      end), desc = "Toggle Diagnostics" },
      { "<leader>ul", toggle(function(t)
        return t.line_number()
      end), desc = "Toggle Line Number" },
      {
        "<leader>uc",
        toggle(function(t)
          return t.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
        end),
        desc = "Toggle Conceallevel",
      },
      {
        "<leader>uT",
        toggle(function(t)
          return t.treesitter()
        end),
        desc = "Toggle Treesitter Highlight",
      },
      {
        "<leader>ub",
        toggle(function(t)
          return t.option("background", { off = "light", on = "dark", name = "Dark Background" })
        end),
        desc = "Toggle Dark Background",
      },
      { "<leader>uh", toggle(function(t)
        return t.inlay_hints()
      end), desc = "Toggle Inlay Hints" },
      { "<leader>ug", toggle(function(t)
        return t.indent()
      end), desc = "Toggle Indent" },
      { "<leader>uD", toggle(function(t)
        return t.dim()
      end), desc = "Toggle Dim" },
    },
  },

  {
    "nicholasxjy/mini.hues",
    lazy = false,
    priority = 1000,
    opts = {
      foreground = "#b0b0b0",
      background = "#1C0A00",
      n_hues = 12,
      saturation = "high",
      accent = "bg",
      plugins = {
        default = true,
      },
      autoadjust = true,
    },
  },

  {
    "nicholasxjy/mini.statusline",
    event = "VeryLazy",
    opts = function()
      local ui = require("ui")
      return {
        use_icons = true,
        show_workspace_diagnostics = false,
        diff = {
          icon = nil,
          signs = {
            added = ui.icons.git.added,
            modified = ui.icons.git.modified,
            removed = ui.icons.git.removed,
          },
        },
        diagnostics = {
          icon = nil,
          signs = {
            ERROR = ui.icons.diagnostics.Error,
            WARN = ui.icons.diagnostics.Warn,
            INFO = ui.icons.diagnostics.Info,
            HINT = ui.icons.diagnostics.Hint,
          },
        },
        highlight_groups = {
          devinfo = "MiniStatuslineDevinfo",
          filename = "MiniStatuslineFilename",
          fileinfo = "MiniStatuslineFileinfo",
          inactive = "MiniStatuslineInactive",
          lsp_progress = "MiniStatuslineLspProgress",
          lsp_progress_done = "MiniStatuslineLspProgressDone",
          diff = {
            added = "DiffAdded",
            modified = "DiffModified",
            removed = "DiffRemoved",
          },
          diagnostics = {
            ERROR = "DiagnosticError",
            WARN = "DiagnosticWarn",
            INFO = "DiagnosticInfo",
            HINT = "DiagnosticHint",
          },
        },
      }
    end,
  },

  {
    "nvim-mini/mini.tabline",
    event = "VeryLazy",
    opts = {
      show_icons = true,
    },
  },

  {
    "nvim-mini/mini.icons",
    init = function()
      vim.schedule(function()
        package.preload["nvim-web-devicons"] = function()
          require("mini.icons").mock_nvim_web_devicons()
          return package.loaded["nvim-web-devicons"]
        end
      end)
    end,
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
  },

  {
    "nvim-mini/mini.surround",
    event = "VeryLazy",
    keys = {
      { "gsa", mode = { "n", "x" }, desc = "Surround Add" },
      { "gsd", desc = "Surround Delete" },
      { "gsr", desc = "Surround Replace" },
      { "gsf", desc = "Surround Find" },
    },
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
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "<leader>ut",
        function()
          require("mini.trailspace").trim()
        end,
        desc = "Trim Trailing Space",
      },
    },
    opts = {
      only_in_normal_buffers = true,
    },
  },

  {
    "nvim-mini/mini.files",
    event = "VeryLazy",
    keys = {
      {
        "<leader>e",
        function()
          local bufname = vim.api.nvim_buf_get_name(0)
          local path = vim.fn.fnamemodify(bufname, ":p")

          if path and vim.uv.fs_stat(path) then
            require("mini.files").open(bufname, false)
          else
            require("mini.files").open()
          end
        end,
        desc = "Mini files",
        silent = true,
      },
    },
    opts = {
      mappings = {
        show_help = "?",
        go_in_plus = "<cr>",
        go_out_plus = "-",
      },
      content = {
        filter = function(entry)
          return entry.name ~= ".DS_Store"
        end,
      },
      options = { permanent_delete = false },
    },
    config = function(_, opts)
      local MiniFiles = require("mini.files")
      MiniFiles.setup(opts)

      local function open_buf_in_split(buf_id, key_map, direction)
        local function rhs()
          local cur_target = MiniFiles.get_explorer_state().target_window

          if cur_target == nil or MiniFiles.get_fs_entry().fs_type == "directory" then
            return
          end

          local new_target = vim.api.nvim_win_call(cur_target, function()
            vim.cmd(direction .. " split")
            return vim.api.nvim_get_current_win()
          end)
          MiniFiles.set_target_window(new_target)
          MiniFiles.go_in({ close_on_file = true })
        end

        vim.keymap.set("n", key_map, rhs, { buffer = buf_id, desc = "Open in " .. string.sub(direction, 12) })
      end

      local widths = { 60, 20, 10 }
      local ensure_center_layout = function(ev)
        local state = MiniFiles.get_explorer_state()
        if state == nil then
          return
        end

        local path_this = vim.api.nvim_buf_get_name(ev.data.buf_id):match("^minifiles://%d+/(.*)$")
        local depth_this
        for i, path in ipairs(state.branch) do
          if path == path_this then
            depth_this = i
          end
        end
        if depth_this == nil then
          return
        end

        local depth_offset = depth_this - state.depth_focus
        local i = math.abs(depth_offset) + 1
        local win_config = vim.api.nvim_win_get_config(ev.data.win_id)
        win_config.width = i <= #widths and widths[i] or widths[#widths]
        win_config.col = math.floor(0.5 * (vim.o.columns - widths[1]))
        for j = 1, math.abs(depth_offset) do
          local sign = depth_offset == 0 and 0 or (depth_offset > 0 and 1 or -1)
          local prev_win_width = (sign == -1 and widths[j + 1]) or widths[j] or widths[#widths]
          win_config.col = win_config.col + sign * (prev_win_width + 2)
        end

        win_config.height = depth_offset == 0 and 25 or 20
        win_config.row = math.floor(0.5 * (vim.o.lines - win_config.height))
        win_config.border = "rounded"
        vim.api.nvim_win_set_config(ev.data.win_id, win_config)
      end

      vim.api.nvim_create_autocmd("User", { pattern = "MiniFilesWindowUpdate", callback = ensure_center_layout })
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowOpen",
        callback = function(args)
          local win_id = args.data.win_id
          vim.wo[win_id].winblend = 0
          local config = vim.api.nvim_win_get_config(win_id)
          config.border = "single"
          vim.api.nvim_win_set_config(win_id, config)
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          vim.keymap.set("n", "g.", function()
            vim.g.show_dotfiles = not vim.g.show_dotfiles
            require("mini.files").refresh({
              content = {
                filter = function(entry)
                  return vim.g.show_dotfiles or entry.name:sub(1, 1) ~= "."
                end,
              },
            })
          end, { buffer = buf_id, desc = "Toggle Dotfiles" })
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        desc = "Add minifiles split keymaps",
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          open_buf_in_split(buf_id, "<C-h>", "topleft vertical")
          open_buf_in_split(buf_id, "<C-j>", "belowright horizontal")
          open_buf_in_split(buf_id, "<C-k>", "topleft horizontal")
          open_buf_in_split(buf_id, "<C-l>", "belowright vertical")
          open_buf_in_split(buf_id, "<C-t>", "tab")
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        desc = "Notify LSPs that a file was renamed",
        pattern = "MiniFilesActionRename",
        callback = function(args)
          local changes = {
            files = {
              {
                oldUri = vim.uri_from_fname(args.data.from),
                newUri = vim.uri_from_fname(args.data.to),
              },
            },
          }
          local will_rename_method, did_rename_method =
            vim.lsp.protocol.Methods.workspace_willRenameFiles, vim.lsp.protocol.Methods.workspace_didRenameFiles
          local clients = vim.lsp.get_clients()
          for _, client in ipairs(clients) do
            if client:supports_method(will_rename_method) then
              local res = client:request_sync(will_rename_method, changes, 1000, 0)
              if res and res.result then
                vim.lsp.util.apply_workspace_edit(res.result, client.offset_encoding)
              end
            end
          end

          for _, client in ipairs(clients) do
            if client:supports_method(did_rename_method) then
              client:notify(did_rename_method, changes)
            end
          end
        end,
      })
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        {
          mode = { "n", "x" },
          { "<leader>a", group = "ai" },
          { "<leader>c", group = "code" },
          { "<leader>d", group = "debug" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui" },
          { "<leader>x", group = "diagnostics/quickfix" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          { "gx", desc = "Open Externally" },
        },
      },
      preset = "helix",
      icons = {
        separator = " ",
      },
      win = {
        width = { min = 0.2, max = 0.2 },
        height = { min = 0.5, max = 0.8 },
        col = 0,
        title = true,
        title_pos = "center",
      },
      plugins = {
        registers = false,
        marks = false,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
    },
  },

  {
    "rcarriga/nvim-notify",
    init = function()
      local fallback_notify = vim.notify
      local loading_notify = false

      local function setup_notify()
        if vim.g.notify_setup_done then
          return require("notify")
        end

        if loading_notify then
          return nil
        end

        loading_notify = true
        vim.notify = fallback_notify

        local ok, notify = pcall(function()
          require("lazy").load({ plugins = { "nvim-notify" }, wait = true })
          return require("notify")
        end)

        loading_notify = false

        if ok then
          vim.notify = notify
          return notify
        end

        vim.notify = fallback_notify
        fallback_notify(notify, vim.log.levels.ERROR)
        return nil
      end

      _G.__setup_notify = setup_notify

      vim.notify = function(...)
        local notify = setup_notify()
        if notify then
          return notify(...)
        end

        return fallback_notify(...)
      end
    end,
    keys = {
      {
        "<leader>un",
        function()
          require("notify").clear_history()
        end,
        desc = "Clear Notifications",
      },
      {
        "<leader>N",
        function()
          require("lazy").load({ plugins = { "fzf-lua" }, wait = true })
          require("notify.integrations.fzf").open()
        end,
        desc = "Notifications",
        silent = true,
      },
    },
    opts = notify_opts,
    config = function(_, opts)
      require("notify").setup(opts)
      vim.g.notify_setup_done = true
      vim.notify = require("notify")
    end,
  },

  {
    "nicholasxjy/lsp-progress-notify.nvim",
    event = "LspAttach",
    dependencies = {
      "rcarriga/nvim-notify",
    },
    opts = progress_opts,
    config = function(_, opts)
      require("lsp-progress-notify").setup(opts)
      vim.g.lsp_progress_notify_setup_done = true
    end,
  },

  {
    "nicholasxjy/rainbow-tags.nvim",
    ft = { "typescriptreact", "javascriptreact", "tsx" },
    opts = {
      enabled = true,
      filetypes = { "typescriptreact", "javascriptreact", "tsx" },
      lang = "tsx",
      include_intrinsic = true,
      strategy = "name",
      create_default_highlights = true,
      highlight_groups = {
        "RainbowDelimiterRed",
        "RainbowDelimiterCyan",
        "RainbowDelimiterYellow",
        "RainbowDelimiterGreen",
        "RainbowDelimiterOrange",
        "RainbowDelimiterViolet",
        "RainbowDelimiterBlue",
      },
    },
  },
}
