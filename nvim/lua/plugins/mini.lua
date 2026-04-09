local function open_buf_in_split(buf_id, key_map, direction)
  local MiniFiles = require("mini.files")

  local function rhs()
    local cur_target = MiniFiles.get_explorer_state().target_window

    -- Noop if explorer isn't open or the cursor is on a directory
    if cur_target == nil or MiniFiles.get_fs_entry().fs_type == "directory" then
      return
    end

    -- Make a new window and set it as target.
    local new_target = vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. " split")
      return vim.api.nvim_get_current_win()
    end)
    MiniFiles.set_target_window(new_target)

    -- Go in and close the explorer.
    MiniFiles.go_in({ close_on_file = true })
  end

  vim.keymap.set("n", key_map, rhs, { buffer = buf_id, desc = "Open in " .. string.sub(direction, 12) })
end

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
    config = function()
      require("mini.ai").setup()
    end,
  },
  {
    "nvim-mini/mini.surround",
    version = false,
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        replace = "gsr",
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
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
        desc = "Trim Trailing Space",
      },
    },
    config = function()
      require("mini.trailspace").setup({
        only_in_normal_buffers = true,
      })
    end,
  },
  {
    "nvim-mini/mini.files",
    version = false,
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
        desc = "File Explorer",
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
      require("mini.files").setup(opts)

      -- vim.api.nvim_create_autocmd(
      --   "User",
      --   { pattern = "MiniFilesWindowUpdate", callback = miniUtil.ensure_center_layout }
      -- )

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
    "nvim-mini/mini.tabline",
    version = false,
    event = "VeryLazy",
    opts = {
      show_icons = true,
    },
  },
  {
    "nicholasxjy/mini.hues",
    version = false,
    config = function()
      local hues = require("mini.hues")
      hues.setup({
        -- **Required** base colors as '#rrggbb' hex strings
        -- background = "#101010",
        -- foreground = "#b0b0b0",

        background = "#0e1415",
        foreground = "#cecece",
        -- Number of hues used for non-base colors
        n_hues = 8,

        -- Saturation. One of 'low', 'lowmedium', 'medium', 'mediumhigh', 'high'.
        saturation = "high",

        -- Accent color. One of: 'bg', 'fg', 'red', 'orange', 'yellow', 'green',
        -- 'cyan', 'azure', 'blue', 'purple'
        accent = "cyan",

        -- Plugin integrations. Use `default = false` to disable all integrations.
        -- Also can be set per plugin (see |MiniHues.config|).
        plugins = { default = true },

        -- Whether to auto adjust highlight groups based on certain events
        autoadjust = true,
      })

      -- local p = hues.get_palette()
      -- vim.api.nvim_set_hl(0, "SnacksPickerPreview", { bg = p.bg_edge2 })
      -- vim.api.nvim_set_hl(0, "Type", { fg = p.blue_bg })
      -- vim.api.nvim_set_hl(0, "@type", { fg = p.blue_bg })
      -- vim.api.nvim_set_hl(0, "FzfLuaNormal", { bg = p.bg_edge })
      -- vim.api.nvim_set_hl(0, "FzfLuaBorder", { fg = p.accent })
      -- vim.api.nvim_set_hl(0, "FzfLuaFzfMatch", { fg = p.accent, bg = p.bg, bold = true })
      -- vim.api.nvim_set_hl(0, "FzfLuaDirPart", { fg = p.bg_mid2, bg = p.bg_edge2 })
    end,
  },
  {
    "nvim-mini/mini.statusline",
    version = false,
    enabled = false,
    event = "VeryLazy",
    config = function()
      require("mini.statusline").setup()
    end,
  },
  {
    "nvim-mini/mini.clue",
    version = false,
    event = "VeryLazy",
    config = function()
      local miniclue = require("mini.clue")
      miniclue.setup({
        window = {
          delay = 100,
          config = {
            width = "auto",
            col = "auto",
            anchor = "NW",
            border = "single",
          },
        },
        triggers = {
          -- Leader triggers
          { mode = { "n", "x" }, keys = "<Leader>" },

          -- `[` and `]` keys
          { mode = "n", keys = "[" },
          { mode = "n", keys = "]" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = { "n", "x" }, keys = "g" },

          -- Marks
          { mode = { "n", "x" }, keys = "'" },
          { mode = { "n", "x" }, keys = "`" },

          -- Registers
          { mode = { "n", "x" }, keys = '"' },
          { mode = { "i", "c" }, keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = { "n", "x" }, keys = "z" },
        },

        clues = {
          { mode = "n", keys = "<leader>a", desc = "+AI" },
          { mode = "n", keys = "<leader>b", desc = "+Buffer" },
          { mode = "n", keys = "<leader>c", desc = "+Code" },
          { mode = "n", keys = "<leader>d", desc = "+Debug" },
          { mode = "n", keys = "<leader>f", desc = "+Files" },
          { mode = "n", keys = "<leader>s", desc = "+Search" },
          { mode = "n", keys = "<leader>g", desc = "+Git" },
          { mode = "n", keys = "<leader>x", desc = "+Diagnostic" },
          { mode = "n", keys = "<leader>u", desc = "+UI" },
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.square_brackets(),
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
      })
    end,
  },
}
