vim.g.minibuffer = {
  dynamic_window_resize = true, -- Shrink other windows when the minibuffer is expanded
  ui = {
    min_height = math.floor(vim.o.lines * 0.3),
    max_height = math.floor(vim.o.lines * 0.3),
  },
  cmd = {
    -- NOTE: minibuffer cmd is not compatible with command line plugins that force `wildtrigger()` each `wildchar` such as mini.cmdline
    enabled = false, -- Enable command line wildmenu replacement through the minibuffer
    autotrigger = false, -- Display completion suggestions as you type
    dynamic_height = false, -- Whether the completion window should shrink as items disappear.
    max_height = 15, -- Maximum height when using the command line
  },
  builtin = {
    prompt = "",
    pointer = "|",
    filename_first = true,
    filter = { cwd = true },
    keymaps = {
      next = { "<C-n>", "<C-j>", "<Down>" },
      previous = { "<C-p>", "<C-k>", "<Up>" },
    },
    highlights = {
      normal = "Normal",
      query = "Normal",
      prompt = "Keyword",
      directory_path = "SnacksPickerDir",
      matched = "SnacksPickerMatch",
    },
  },
}

local loader = require("loader")

local function get_search_query()
  local mode = vim.fn.mode()

  -- Visual / Visual Line / Visual Block
  if mode == "v" or mode == "V" or mode == "\22" then
    local start_pos = vim.fn.getpos("v")
    local end_pos = vim.fn.getpos(".")

    local start_row, start_col = start_pos[2] - 1, start_pos[3] - 1
    local end_row, end_col = end_pos[2] - 1, end_pos[3]

    if start_row > end_row or (start_row == end_row and start_col > end_col) then
      start_row, end_row = end_row, start_row
      start_col, end_col = end_col - 1, start_col + 1
    end

    local lines = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})

    return table.concat(lines, "\n")
  end

  return vim.fn.expand("<cword>")
end

loader.on_very_lazy("minibuffer", function()
  loader.packadd("minibuffer.nvim")

  local minibuffer = require("minibuffer")

  vim.keymap.set("n", "<leader><CR>", function()
    minibuffer.resume(true)
  end, { desc = "Resume" })

  vim.keymap.set("n", "<leader><space>", function()
    require("minibuffer.builtin.files")({
      prompt = "Files ",
      matcher = {
        filename_bonus = true,
        cwd_bonus = true,
        frecency = true,
        history_bonus = false,
      },
      show_git_status = true,
      git_changed_first = true, -- Put changed Git files before other matches
      git = { status_text_color = true }, -- fff default: color signs only
      fuzzy_query_highlighting = true, -- fff default: highlight literal query
      current_file_label = "(current)",
    })
  end, {
    desc = "Files",
  })

  vim.keymap.set("n", "<leader>h", function()
    require("minibuffer.builtin.buffers")({
      prompt = "Buffers> ",
    })
  end, { desc = "Buffers" })

  vim.keymap.set("n", "<leader>sg", function()
    require("minibuffer.builtin.live-grep")({
      prompt = "Grep> ",
      current_file_first = true,
    })
  end, { desc = "Grep" })

  vim.keymap.set({ "n", "v" }, "<leader>sw", function()
    require("minibuffer.builtin.live-grep")({
      prompt = "Grep | ",
      query = get_search_query(),
      current_file_first = true,
    })
  end, { desc = "Grep word under cursor" })

  vim.keymap.set("n", "<leader>xx", function()
    require("minibuffer.builtin.diagnostics")({
      prompt = "Diagnostics> ",
      scope = "workspace",
      sort = true, -- ERROR, WARN, INFO, HINT; "reverse" / 2 reverses; false keeps provider order
      -- severity_limit = "WARN", -- ERROR and WARN
      -- severity_only = "ERROR", -- exact level; cannot combine with limit/bound
      severity_bound = "ERROR", -- WARN, INFO and HINT
    })
  end, { desc = "Diagnostics" })

  vim.keymap.set("n", "<leader>xe", function()
    require("minibuffer.builtin.diagnostics")({
      prompt = "Diagnostics> ",
      scope = "workspace",
      sort = true, -- ERROR, WARN, INFO, HINT; "reverse" / 2 reverses; false keeps provider order
      severity_limit = "WARN", -- ERROR and WARN
      -- severity_only = "ERROR", -- exact level; cannot combine with limit/bound
      -- severity_bound = "WARN", -- WARN, INFO and HINT
    })
  end, { desc = "Diagnostics(error&warn)" })
end)
