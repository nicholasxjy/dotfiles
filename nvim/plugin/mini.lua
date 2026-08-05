local loader = require("loader")

-- Eager: icons feed the completion menu and pickers, tabline and notify are
-- visible chrome. Everything else moves to VeryLazy further down.
loader.packadd("mini.icons", "mini.tabline", "mini.notify")

require("mini.icons").setup({
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
})

vim.schedule(function()
  package.preload["nvim-web-devicons"] = function()
    require("mini.icons").mock_nvim_web_devicons()
    return package.loaded["nvim-web-devicons"]
  end
end)

require("mini.tabline").setup({
  show_icons = true,
})

require("mini.notify").setup({
  lsp_progress = {
    enable = true,
    level = "INFO",
    duration_last = 1000,
  },
  window = {
    -- Floating window config
    -- Maximum window width as share (between 0 and 1) of available columns
    max_width_share = 0.382,
    -- Value of 'winblend' option
    winblend = 0,
  },
})

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

-- Assigned at the bottom of this file, next to the rest of the clue config.
-- The VeryLazy callback below only reads it once the whole file has been run.
local setup_clue

-- Text objects, surround, trailspace, the file explorer and the clue window are
-- all driven by user input, so none of them need to exist before the first
-- frame is on screen.
loader.on_very_lazy("mini-extras", function()
  loader.packadd("mini.ai", "mini.surround", "mini.trailspace", "mini.files", "minibuffer.nvim", "mini.clue")

  require("mini.ai").setup()

  require("mini.surround").setup({
    mappings = {
      add = "gsa",
      delete = "gsd",
      replace = "gsr",
      find = "gsf",
    },
  })

  require("mini.trailspace").setup({
    only_in_normal_buffers = true,
  })

  require("mini.files").setup({
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
  })

  setup_clue()
end)

-- Window width based on the offset from the center, i.e. center window
-- is 60, then next over is 20, then the rest are 10.
-- Can use more resolution if you want like { 60, 20, 20, 10, 5 }
local widths = { 60, 20, 10 }

local ensure_center_layout = function(ev)
  local state = require("mini.files").get_explorer_state()
  if state == nil then
    return
  end

  -- Compute "depth offset" - how many windows are between this and focused
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

  -- Adjust config of this event's window
  local i = math.abs(depth_offset) + 1
  local win_config = vim.api.nvim_win_get_config(ev.data.win_id)
  win_config.width = i <= #widths and widths[i] or widths[#widths]

  win_config.col = math.floor(0.5 * (vim.o.columns - widths[1]))
  for j = 1, math.abs(depth_offset) do
    local sign = depth_offset == 0 and 0 or (depth_offset > 0 and 1 or -1)
    -- widths[j+1] for the negative case because we don't want to add the center window's width
    local prev_win_width = (sign == -1 and widths[j + 1]) or widths[j] or widths[#widths]
    -- Add an extra +2 each step to account for the border width
    win_config.col = win_config.col + sign * (prev_win_width + 2)
  end

  win_config.height = depth_offset == 0 and 25 or 20
  win_config.row = math.floor(0.5 * (vim.o.lines - win_config.height))
  win_config.border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }
  -- win_config.border = "rounded"
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
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.from, event.data.to)
  end,
})

-- mini clue
setup_clue = function()
  local miniclue = require("mini.clue")
  require("minibuffer.integrations.mini-clue").setup()
  miniclue.setup({
    window = {
      delay = 100,
      config = {
        width = "auto",
        col = "auto",
        anchor = "NW",
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
end

vim.keymap.set("n", "<leader>ut", function()
  require("mini.trailspace").trim()
end, { desc = "Trim Trailing Space" })

vim.keymap.set("n", "<leader>E", function()
  local bufname = vim.api.nvim_buf_get_name(0)
  local path = vim.fn.fnamemodify(bufname, ":p")

  if path and vim.uv.fs_stat(path) then
    require("mini.files").open(bufname, false)
  else
    require("mini.files").open()
  end
end, { desc = "Mini files", silent = true })
