local MiniFiles = require("mini.files")

local function open_buf_in_split(buf_id, keymap, direction)
  local function open()
    local target = MiniFiles.get_explorer_state().target_window
    if target == nil or MiniFiles.get_fs_entry().fs_type == "directory" then
      return
    end

    local new_target = vim.api.nvim_win_call(target, function()
      vim.cmd(direction .. " split")
      return vim.api.nvim_get_current_win()
    end)
    MiniFiles.set_target_window(new_target)
    MiniFiles.go_in({ close_on_file = true })
  end

  vim.keymap.set("n", keymap, open, { buffer = buf_id, desc = "Open in " .. direction:sub(12) })
end

MiniFiles.setup({
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

local widths = { 60, 20, 10 }

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesWindowUpdate",
  callback = function(event)
    local state = MiniFiles.get_explorer_state()
    if state == nil then
      return
    end

    local path = vim.api.nvim_buf_get_name(event.data.buf_id):match("^minifiles://%d+/(.*)$")
    local depth
    for index, branch_path in ipairs(state.branch) do
      if branch_path == path then
        depth = index
        break
      end
    end
    if depth == nil then
      return
    end

    local offset = depth - state.depth_focus
    local width_index = math.abs(offset) + 1
    local config = vim.api.nvim_win_get_config(event.data.win_id)
    config.width = widths[width_index] or widths[#widths]
    config.col = math.floor(0.5 * (vim.o.columns - widths[1]))

    for index = 1, math.abs(offset) do
      local sign = offset > 0 and 1 or -1
      local previous_width = (sign == -1 and widths[index + 1]) or widths[index] or widths[#widths]
      config.col = config.col + sign * (previous_width + 2)
    end

    config.height = offset == 0 and 25 or 20
    config.row = math.floor(0.5 * (vim.o.lines - config.height))
    config.border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }
    vim.api.nvim_win_set_config(event.data.win_id, config)
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesWindowOpen",
  callback = function(event)
    local win_id = event.data.win_id
    vim.wo[win_id].winblend = 0
    local config = vim.api.nvim_win_get_config(win_id)
    config.border = "single"
    vim.api.nvim_win_set_config(win_id, config)
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(event)
    local buf_id = event.data.buf_id
    vim.keymap.set("n", "g.", function()
      vim.g.show_dotfiles = not vim.g.show_dotfiles
      MiniFiles.refresh({
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
  callback = function(event)
    local buf_id = event.data.buf_id
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
    require("snacks").rename.on_rename_file(event.data.from, event.data.to)
  end,
})
