local loader = require("loader")
local theme = require("theme")

-- Eager: Theme, icons, and notifications feed the initial screen and popups
theme.load("catppuccin-mocha")

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

-- Inline diagnostics: decorates diagnostics on LSP attach
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
    },
  })

  for _, client in ipairs(vim.lsp.get_clients()) do
    for bufnr in pairs(client.attached_buffers) do
      vim.api.nvim_exec_autocmds("LspAttach", {
        group = "TinyInlineDiagnosticAutocmds",
        buffer = bufnr,
        data = { client_id = client.id },
        modeline = false,
      })
    end
  end
end, "LspAttach")

-- Statusline, bufferline, statuscolumn, and visual indicators
loader.on_very_lazy("ui-chrome", function()
  loader.packadd(
    "lualine.nvim",
    "bufferline.nvim",
    "modicator.nvim",
    "nvim-highlight-colors",
    "screenkey.nvim",
    "mini.statuscolumn"
  )

  -- Lualine
  local function lsp_component()
    local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
    local buf_client_names = {}

    for _, client in pairs(buf_clients) do
      table.insert(buf_client_names, client.name)
    end

    return table.concat(buf_client_names, ",")
  end

  require("lualine").setup({
    options = {
      theme = "auto",
      section_separators = { left = "", right = "" },
      globalstatus = true,
    },
    extensions = { "neo-tree", "fzf" },
    sections = {
      lualine_a = { { "mode" } },
      lualine_b = {
        { "branch" },
        {
          "diff",
          source = function()
            local status = vim.b.gitsigns_status_dict
            if status then
              return { added = status.added, modified = status.changed, removed = status.removed }
            end
          end,
        },
      },
      lualine_c = {
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { "filename", path = 4 },
        { "diagnostics", sources = { "nvim_workspace_diagnostic" } },
      },
      lualine_x = {
        {
          function()
            return "[" .. lsp_component() .. "]"
          end,
          color = "Keyword",
        },
      },
      lualine_y = { { "searchcount" }, { "location" } },
      lualine_z = { { "encoding" } },
    },
  })

  -- Bufferline
  require("bufferline").setup({
    options = {
      diagnostics = "nvim_lsp",
      sort_by = "id",
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  })

  -- Modicator
  require("modicator").setup()

  -- Color highlighter
  require("nvim-highlight-colors").setup({})

  -- Screenkey
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

    local marks = marks_by_buffer[buf_id]
    if marks == nil then
      marks = {}
      local mark_list = vim.fn.getmarklist(buf_id)
      vim.list_extend(mark_list, vim.fn.getmarklist())
      for _, mark in ipairs(mark_list) do
        if mark.pos[1] == buf_id and mark.mark:match("[a-zA-Z]") then
          marks[mark.pos[2]] = mark.mark:sub(2)
        end
      end
      marks_by_buffer[buf_id] = marks
    end

    return marks[lnum] or " "
  end

  vim.api.nvim_create_autocmd("MarkSet", {
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
