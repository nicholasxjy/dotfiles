local function lsp_component()
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
  local buf_client_names = {}

  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  if package.loaded["conform"] then
    local conform = require("conform")
    local formatters = conform.list_formatters(0)
    for _, source in ipairs(formatters) do
      table.insert(buf_client_names, source.name)
    end
  end

  return table.concat(buf_client_names, ",")
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-mini/mini.icons" },
  opts = {
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
        -- { "diagnostics" },
      },
      lualine_x = {
        { "macro" },
        {
          function()
            return "  " .. require("dap").status()
          end,
          cond = function()
            local dap = package.loaded["dap"]
            return dap and dap.status() ~= ""
          end,
          color = function()
            return { fg = Snacks.util.color("Debug") }
          end,
        },
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = function()
            return { fg = Snacks.util.color("Special") }
          end,
        },
        {
          function()
            return "[" .. lsp_component() .. "]"
          end,
          color = function()
            return { fg = Snacks.util.color("Keyword") }
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
  },
  config = function(_, opts)
    local function sidekick_status()
      return package.loaded["sidekick.status"] and require("sidekick.status") or nil
    end

    local icons = {
      Error = { " ", "DiagnosticError" },
      Inactive = { " ", "MsgArea" },
      Warning = { " ", "DiagnosticWarn" },
      Normal = { " ", "Special" },
    }
    table.insert(opts.sections.lualine_x, {
      function()
        local sidekick = sidekick_status()
        local status = sidekick and sidekick.get()
        return status and vim.tbl_get(icons, status.kind, 1)
      end,
      cond = function()
        local sidekick = sidekick_status()
        return sidekick and sidekick.get() ~= nil
      end,
      color = function()
        local sidekick = sidekick_status()
        local status = sidekick and sidekick.get()
        local hl = status and (status.busy and "DiagnosticWarn" or vim.tbl_get(icons, status.kind, 2))
        return { fg = Snacks.util.color(hl) }
      end,
    })

    -- CLI session status
    table.insert(opts.sections.lualine_x, 2, {
      function()
        local sidekick = sidekick_status()
        local status = sidekick and sidekick.cli() or {}
        return " " .. (#status > 1 and #status or "")
      end,
      cond = function()
        local sidekick = sidekick_status()
        return sidekick and #sidekick.cli() > 0 or false
      end,
      color = function()
        return "Special"
      end,
    })
    require("lualine").setup(opts)
  end,
}
