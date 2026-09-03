local loader = require("loader")

local function setup()
  loader.packadd("lualine.nvim")
  loader.packadd("sidekick.nvim")

  -- `conform.list_formatters()` walks the filesystem looking for config files,
  -- which is far too expensive to redo on every statusline redraw. Cache per
  -- buffer and drop the entry whenever something could have changed it.
  local lsp_cache = {}

  local function lsp_component()
    local bufnr = vim.api.nvim_get_current_buf()
    local cached = lsp_cache[bufnr]
    if cached then
      return cached
    end

    local names = {}

    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
      if client.name ~= "null-ls" then
        names[#names + 1] = client.name
      end
    end

    local conform_installed, conform = pcall(require, "conform")
    if conform_installed then
      for _, source in ipairs(conform.list_formatters(bufnr)) do
        names[#names + 1] = source.name
      end
    end

    local text = table.concat(names, ",")
    lsp_cache[bufnr] = text
    return text
  end

  vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach", "FileType", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("sjvim_lualine_lsp_cache", { clear = true }),
    callback = function(args)
      lsp_cache[args.buf] = nil
    end,
  })
  vim.api.nvim_create_autocmd("BufDelete", {
    group = "sjvim_lualine_lsp_cache",
    callback = function(args)
      lsp_cache[args.buf] = nil
    end,
  })

  -- Highlight lookups are only invalidated by a colorscheme change.
  local hl_cache = {}
  local function hl_fg(name)
    if hl_cache[name] == nil then
      local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
      hl_cache[name] = hl.fg and ("#%06x"):format(hl.fg) or false
    end
    return hl_cache[name] or nil
  end

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("sjvim_lualine_hl_cache", { clear = true }),
    callback = function()
      hl_cache = {}
    end,
  })

  local opts = {
    options = {
      theme = "auto",
      section_separators = { left = "", right = "" },
      -- component_separators = { left = "│", right = "│" },
      globalstatus = true,
      -- lualine already redraws on the relevant autocommands; the timer is only
      -- a backstop, so it does not need to run ten times a second.
      refresh = {
        statusline = 1000,
      },
    },
    extensions = { "fzf" },
    sections = {
      lualine_a = {
        { "mode" },
      },
      lualine_b = {
        { "branch" },
        { "diff" },
      },
      lualine_c = {
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { "filename", path = 4 },
        { "diagnostics", sources = { "nvim_workspace_diagnostic" } },
      },
      lualine_x = {
        { "macro" },
        {
          function()
            return "  " .. require("dap").status()
          end,
          cond = function()
            return package.loaded["dap"] and require("dap").status() ~= ""
          end,
          color = function()
            return { fg = hl_fg("Debug") }
          end,
        },
        {
          function()
            return "[" .. lsp_component() .. "]"
          end,
          color = function()
            return { fg = hl_fg("Keyword") }
          end,
        },
      },
      lualine_y = {
        { "searchcount" },
        { "location" },
      },
      lualine_z = {
        { "encoding" },
      },
    },
  }

  -- CLI session status
  table.insert(opts.sections.lualine_x, 2, {
    function()
      local status = require("sidekick.status").cli()
      return " " .. (#status > 1 and #status or "")
    end,
    cond = function()
      return #require("sidekick.status").cli() > 0
    end,
    color = function()
      return "Special"
    end,
  })

  local ok, mb_lualine = pcall(require, "minibuffer.integrations.lualine")
  if ok then
    mb_lualine(opts)
  else
    require("lualine").setup(opts)
  end
end

loader.defer_buffer("lualine", setup, { schedule = true })
