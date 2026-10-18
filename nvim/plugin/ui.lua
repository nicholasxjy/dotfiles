local loader = require("loader")
local theme = require("theme")

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
  require("mini.statusline").setup({ use_icons = true })

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
