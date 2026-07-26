local function lsp_component()
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
  local conform = package.loaded.conform
  local buf_client_names = {}

  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  if conform then
    local formatters = conform.list_formatters(0)
    for _, source in ipairs(formatters) do
      table.insert(buf_client_names, source.name)
    end
  end

  return table.concat(buf_client_names, ",")
end

local function sidekick_status()
  if not package.loaded.sidekick then
    return {}
  end
  return require("sidekick.status").cli()
end

local opts = {
  options = {
    theme = "auto",
    section_separators = { left = "", right = "" },
    -- component_separators = { left = "│", right = "│" },
    globalstatus = true,
    refresh = {
      statusline = 100,
    },
  },
  extensions = { "neo-tree", "lazy", "fzf" },
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
          return { fg = ("#%06x"):format(vim.api.nvim_get_hl(0, { name = "Debug", link = false }).fg) }
        end,
      },
      {
        function()
          return "[" .. lsp_component() .. "]"
        end,
        color = function()
          return { fg = ("#%06x"):format(vim.api.nvim_get_hl(0, { name = "Keyword", link = false }).fg) }
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
    local status = sidekick_status()
    return " " .. (#status > 1 and #status or "")
  end,
  cond = function()
    return #sidekick_status() > 0
  end,
  color = function()
    return "Special"
  end,
})
require("lualine").setup(opts)
