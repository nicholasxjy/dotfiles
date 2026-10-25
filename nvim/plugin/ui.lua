local loader = require("loader")
local theme = require("theme")
local ui = require("ui")

-- Eager: minibuffer owns the bottom UI container; UI2 is enabled in options.lua.
vim.g.minibuffer = {
  dynamic_window_resize = true,
  -- Keep blink.cmp in charge of command-line completion.
  cmd = { enabled = false, autotrigger = false },
}
loader.packadd("minibuffer.nvim")
local minibuffer = require("minibuffer")

-- The builtin adapters lose selection indices and input cancellation callbacks.
---@generic T
---@param items T[]
---@param opts vim.ui.select.Opts?
---@param on_choice fun(item: T?, idx: integer?)
local function ui_select(items, opts, on_choice)
  opts = opts or {}
  local format_item = opts.format_item or tostring
  local entries = {}
  for index, item in ipairs(items) do
    entries[index] = { item = item, index = index, text = tostring(format_item(item)) }
  end

  minibuffer.select({
    prompt = opts.prompt or "Select: ",
    max_height = 15,
    on_start = function(session, keyset)
      keyset("i", "<C-j>", function()
        session:move(1)
      end, { desc = "Next item" })
      keyset("i", "<C-k>", function()
        session:move(-1)
      end, { desc = "Previous item" })
    end,
    fetch_fn = function(_, cb)
      cb(entries)
    end,
    format_fn = function(entry)
      return { { text = entry.text, hl = "Normal" } }
    end,
    filter_fn = function(ctx)
      local input = ctx.input:lower()
      return vim.tbl_filter(function(entry)
        return entry.text:lower():find(input, 1, true) ~= nil
      end, ctx.items)
    end,
    on_accept = function(selection)
      local selected = selection[1]
      if selected then
        local entry = selected.item
        on_choice(entry.item, entry.index)
      else
        on_choice(nil, nil)
      end
    end,
    on_cancel = function()
      on_choice(nil, nil)
    end,
  })
end

---@param opts vim.ui.input.Opts?
---@param on_confirm fun(input: string?)
local function ui_input(opts, on_confirm)
  opts = opts or {}
  minibuffer.input({
    prompt = opts.prompt or "Enter: ",
    initial_text = opts.default or "",
    max_height = 15,
    fetch_fn = function(input, cb)
      if not opts.completion then
        cb({})
        return
      end
      local ok, completions = pcall(vim.fn.getcompletion, input, opts.completion)
      cb(ok and vim.list_slice(completions, 1, 15) or {})
    end,
    format_fn = function(item)
      return { { text = item, hl = "Normal" } }
    end,
    on_accept = function(ctx)
      return ctx.items[ctx.current_index] or ctx.input
    end,
    on_submit = function(ctx)
      on_confirm(ctx.input)
    end,
    on_cancel = function()
      on_confirm(nil)
    end,
  })
end

vim.ui.select = ui_select
vim.ui.input = ui_input

-- Eager: Theme, icons, and notifications feed the initial screen and popups
theme.load("mini-hues")

loader.packadd("mini.icons", "mini.notify")

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

-- Mock nvim-web-devicons immediately so any dependent plugin seamlessly uses mini.icons
require("mini.icons").mock_nvim_web_devicons()

require("mini.notify").setup({
  lsp_progress = {
    enable = true,
    level = "INFO",
    duration_last = 1000,
  },
  window = {
    max_width_share = 0.382,
    winblend = 0,
  },
})

-- Winbar / breadcrumbs: decorates first buffer render
loader.defer_buffer("zed-bar", function()
  loader.packadd("zed-bar.nvim")
  require("zed-bar").setup({
    disabled_filetypes = {},
  })
end)

-- Inline diagnostics (virtual_text is off). Attach on DiagnosticChanged too, so
-- non-LSP sources such as nvim-lint are shown.
loader.defer("tiny-inline-diagnostic", function()
  loader.packadd("tiny-inline-diagnostic.nvim")

  require("tiny-inline-diagnostic").setup({
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
      overwrite_events = { "LspAttach", "DiagnosticChanged" },
    },
  })

  -- Replay the attach for buffers whose triggering event already fired.
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if
      vim.api.nvim_buf_is_loaded(bufnr)
      and (#vim.lsp.get_clients({ bufnr = bufnr }) > 0 or #vim.diagnostic.get(bufnr) > 0)
    then
      vim.api.nvim_exec_autocmds("LspAttach", {
        group = "TinyInlineDiagnosticAutocmds",
        buffer = bufnr,
        modeline = false,
      })
    end
  end
end, { "LspAttach", "DiagnosticChanged" })

local function setup_screenkey()
  loader.packadd("screenkey.nvim")
  require("screenkey").setup({
    win_opts = {
      row = vim.o.lines - vim.o.cmdheight - 1,
      col = vim.o.columns - 1,
      relative = "editor",
      anchor = "SE",
      width = 20,
      height = 2,
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
  })
end

vim.api.nvim_create_user_command("Screenkey", function(ctx)
  if loader.load("screenkey", setup_screenkey) then
    vim.api.nvim_cmd({ cmd = "Screenkey", args = ctx.fargs, mods = ctx.smods }, {})
  end
end, {
  nargs = "*",
  desc = "Toggle Screenkey or invoke Screenkey commands",
  complete = function(lead)
    return vim.tbl_filter(function(command)
      return vim.startswith(command, lead)
    end, { "toggle", "toggle_statusline_component", "redraw", "log" })
  end,
})

-- Tabline, statusline, statuscolumn, and visual indicators
loader.on_very_lazy("ui-chrome", function()
  loader.packadd("mini.tabline", "mini.statusline", "mini.statuscolumn")

  require("mini.tabline").setup({
    show_icons = true,
    format = function(buf_id, label)
      local suffix = vim.bo[buf_id].modified and " +" or ""
      return require("mini.tabline").default_format(buf_id, label .. suffix)
    end,
  })

  vim.o.laststatus = 3
  local statusline = require("mini.statusline")

  local diagnostic_counts = {}
  local diagnostic_totals = { 0, 0, 0, 0 }
  local diagnostic_signs =
    { ui.icons.diagnostics.Error, ui.icons.diagnostics.Warn, ui.icons.diagnostics.Info, ui.icons.diagnostics.Hint }
  local diagnostic_summary = ""

  local function update_diagnostics(bufnr, counts)
    local previous = diagnostic_counts[bufnr] or {}
    diagnostic_counts[bufnr] = next(counts) and counts or nil

    local parts = {}
    for severity, sign in ipairs(diagnostic_signs) do
      diagnostic_totals[severity] = diagnostic_totals[severity] - (previous[severity] or 0) + (counts[severity] or 0)
      if diagnostic_totals[severity] > 0 then
        parts[#parts + 1] = sign .. diagnostic_totals[severity]
      end
    end
    diagnostic_summary = #parts > 0 and " " .. table.concat(parts, " ") or ""
  end

  -- Seed diagnostics that arrived before VeryLazy; subsequent updates only scan the changed buffer.
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    update_diagnostics(bufnr, vim.diagnostic.count(bufnr))
  end
  vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufWipeout" }, {
    group = vim.api.nvim_create_augroup("sjvim_statusline_diagnostics", { clear = true }),
    -- Redrawing during BufWipeout can error; update on the next tick.
    callback = vim.schedule_wrap(function(args)
      local counts = args.event == "DiagnosticChanged"
          and vim.api.nvim_buf_is_valid(args.buf)
          and vim.diagnostic.count(args.buf)
        or {}
      update_diagnostics(args.buf, counts)
      vim.cmd.redrawstatus()
    end),
  })

  local function lsp_servers()
    if statusline.is_truncated(75) then
      return ""
    end

    local servers = {}
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
      servers[client.name] = true
    end
    local names = vim.tbl_keys(servers)
    if #names == 0 then
      return ""
    end

    table.sort(names)
    -- Escape literal percent signs in names for the statusline format.
    return ("󰒋 " .. table.concat(names, ", ")):gsub("%%", "%%%%")
  end

  statusline.setup({
    use_icons = true,
    content = {
      active = function()
        local win = minibuffer.get_active_window()
        if
          vim.o.laststatus == 3
          and win
          and vim.api.nvim_win_is_valid(win)
          and win ~= vim.api.nvim_get_current_win()
        then
          return vim.api.nvim_win_call(win, statusline.active)
        end

        local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
        local git = statusline.section_git({ trunc_width = 40 })
        local diff = statusline.section_diff({ trunc_width = 75 })
        local diagnostics = ""
        if not statusline.is_truncated(75) and vim.diagnostic.is_enabled({ bufnr = 0 }) then
          diagnostics = diagnostic_summary
        end
        local lsp = lsp_servers()
        local filename = statusline.section_filename({ trunc_width = 140 })
        local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
        local location = statusline.section_location({ trunc_width = 75 })
        local search = statusline.section_searchcount({ trunc_width = 75 })

        if vim.o.laststatus == 3 and win == vim.api.nvim_get_current_win() then
          -- Resolve window-local items before returning to the minibuffer window.
          local opts = { winid = win, maxwidth = vim.o.columns }
          filename = vim.api.nvim_eval_statusline(filename, opts).str:gsub("%%", "%%%%")
          location = vim.api.nvim_eval_statusline(location, opts).str:gsub("%%", "%%%%")
        end

        return statusline.combine_groups({
          { hl = mode_hl, strings = { mode } },
          { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
          "%<",
          { hl = "MiniStatuslineFilename", strings = { filename } },
          "%=",
          { hl = "MiniStatuslineDevinfo", strings = { lsp } },
          { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
          { hl = mode_hl, strings = { search, location } },
        })
      end,
      inactive = function()
        if vim.api.nvim_get_current_win() == minibuffer.get_active_window() then
          return statusline.active()
        end
        return "%#MiniStatuslineInactive#%F%="
      end,
    },
  })

  -- A default link survives colorscheme resets and allows custom overrides.
  vim.api.nvim_set_hl(0, "CursorLineIndent", { link = "Visual", default = true })

  local cursorline_indent_ns = vim.api.nvim_create_namespace("sjvim_cursorline_indent")
  local indent_by_window = {}
  vim.api.nvim_create_autocmd("WinClosed", {
    group = vim.api.nvim_create_augroup("sjvim_cursorline_indent", { clear = true }),
    callback = function(args)
      indent_by_window[tonumber(args.match)] = nil
    end,
  })
  vim.api.nvim_set_decoration_provider(cursorline_indent_ns, {
    on_win = function(_, win, buf)
      if not vim.wo[win].cursorline or vim.bo[buf].buftype ~= "" then
        return false
      end

      local row = vim.api.nvim_win_get_cursor(win)[1] - 1
      local tick = vim.api.nvim_buf_get_changedtick(buf)
      local cached = indent_by_window[win]
      if not cached or cached.buf ~= buf or cached.row ~= row or cached.tick ~= tick then
        local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1] or ""
        cached = { buf = buf, row = row, tick = tick, indent = #(line:match("^[ \t]+") or "") }
        indent_by_window[win] = cached
      end
      if cached.indent > 0 then
        -- Per-redraw marks follow the cursor without leaving highlights on old lines.
        vim.api.nvim_buf_set_extmark(buf, cursorline_indent_ns, row, 0, {
          end_col = cached.indent,
          hl_group = "CursorLineIndent",
          priority = 200,
          ephemeral = true,
        })
      end
      return false
    end,
  })

  -- Statuscolumn
  local statuscolumn = require("mini.statuscolumn")
  local default_content = statuscolumn.gen_content.main({
    { fold = "%C", lnum = "%l ", sign = "%s" },
    { format = "=lfs", sep = "┊ " },
    { ltype = "virt", lnum = "•" },
    { ltype = "wrap", lnum = "↳" },
    { win = "inactive", sep = " " },
  })

  local marks_by_buffer = {}
  local function mark_at_line(buf_id, lnum)
    if vim.v.virtnum ~= 0 then
      return " "
    end

    local tick = vim.api.nvim_buf_get_changedtick(buf_id)
    local cached = marks_by_buffer[buf_id]
    if not cached or cached.tick ~= tick then
      local marks = {}
      local mark_list = vim.fn.getmarklist(buf_id)
      vim.list_extend(mark_list, vim.fn.getmarklist())
      for _, mark in ipairs(mark_list) do
        if mark.pos[1] == buf_id and mark.mark:match("[a-zA-Z]") then
          marks[mark.pos[2]] = mark.mark:sub(2)
        end
      end
      cached = { tick = tick, marks = marks }
      marks_by_buffer[buf_id] = cached
    end

    return cached.marks[lnum] or " "
  end

  vim.api.nvim_create_autocmd("MarkSet", {
    group = vim.api.nvim_create_augroup("sjvim_statuscolumn_marks", { clear = true }),
    callback = function()
      marks_by_buffer = {}
    end,
    desc = "Refresh statuscolumn marks",
  })

  local with_marks = function(content)
    return function(data)
      return mark_at_line(data.buf_id, vim.v.lnum) .. content(data)
    end
  end

  statuscolumn.setup({
    content = {
      active = with_marks(default_content.active),
      inactive = with_marks(default_content.inactive),
    },
    dim_inactive = true,
  })
end)
