local miniUtil = require("utils.mini")

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

  vim.keymap.set("n", key_map, rhs, { buffer = buf_id, desc = "Split " .. string.sub(direction, 12) })
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
        desc = "File explorer",
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

      vim.api.nvim_create_autocmd(
        "User",
        { pattern = "MiniFilesWindowUpdate", callback = miniUtil.ensure_center_layout }
      )

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
          end, { buffer = buf_id, desc = "Toggle `.`-files" })
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
      require("mini.hues").setup({

        -- **Required** base colors as '#rrggbb' hex strings
        background = "#171614",
        foreground = "#AEA09F",

        -- Number of hues used for non-base colors
        n_hues = 8,

        -- Saturation. One of 'low', 'lowmedium', 'medium', 'mediumhigh', 'high'.
        saturation = "high",

        -- Accent color. One of: 'bg', 'fg', 'red', 'orange', 'yellow', 'green',
        -- 'cyan', 'azure', 'blue', 'purple'
        accent = "blue",

        -- Plugin integrations. Use `default = false` to disable all integrations.
        -- Also can be set per plugin (see |MiniHues.config|).
        plugins = { default = true },

        -- Whether to auto adjust highlight groups based on certain events
        autoadjust = true,
      })
    end,
  },
}
