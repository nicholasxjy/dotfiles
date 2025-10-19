local icons = require("core.ui").icons

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-mini/mini.icons", "folke/snacks.nvim" },
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = true,
      section_separators = { left = "", right = "" },
      -- component_separators = { left = "│", right = "│" },
      globalstatus = true,
      refresh = {
        statusline = 100,
      },
    },
    extensions = { "neo-tree", "lazy", "fzf" },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = {
        {
          "diagnostics",
          sources = { "nvim_workspace_diagnostic" },
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { "filename", path = 4 },
      },
      lualine_x = {
        {
          function()
            return "  " .. require("dap").status()
          end,
          cond = function()
            return package.loaded["dap"] and require("dap").status() ~= ""
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
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
      },
      lualine_y = {
        {
          function()
            local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
            local conform_installed, conform = pcall(require, "conform")
            local buf_client_names = {}

            for _, client in pairs(buf_clients) do
              if client.name ~= "null-ls" then
                table.insert(buf_client_names, client.name)
              end
            end

            -- if null_ls_installed then
            --   for _, source in ipairs(null_ls.get_source({ filetype = vim.bo.filetype })) do
            --     table.insert(buf_client_names, source.name)
            --   end
            -- end
            --
            if conform_installed then
              local formatters = conform.list_formatters(0)
              for _, source in ipairs(formatters) do
                table.insert(buf_client_names, source.name)
              end
            end

            return " " .. table.concat(buf_client_names, ",")
          end,
          color = function()
            return { fg = Snacks.util.color("Keyword") }
          end,
        },
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
        { "searchcount" },
      },
      lualine_z = {
        { "encoding" },
        -- function()
        --   return " " .. os.date("%R")
        -- end,
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = { "filetype" },
      lualine_z = {},
    },
  },
  config = function(_, opts)
    opts.sections = opts.sections or {}
    opts.sections.lualine_c = opts.sections.lualine_c or {}
    table.insert(opts.sections.lualine_c, {
      function()
        return " "
      end,
      color = function()
        local status = require("sidekick.status").get()
        if status then
          return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or "Special"
        end
      end,
      cond = function()
        local status = require("sidekick.status")
        return status.get() ~= nil
      end,
    })
    require("lualine").setup(opts)
  end,
}
