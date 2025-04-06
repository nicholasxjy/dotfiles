local icons = require("core.icons")
local llUtil = require("utils.lualine")

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "AndreM222/copilot-lualine",
    },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = "auto",
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
        },
        sections = {
          lualine_a = {
            "mode",
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { fg = Snacks.util.color("Statement") } end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            }
,
          },
          lualine_b = { "branch" },

          lualine_c = {
            -- llUtil.root_dir({ cwd = true }),
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { llUtil.pretty_path() },
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
            "copilot",
          },
          lualine_x = {
            Snacks.profiler.status(),
            -- lsp servers
            -- lsp = " ", --   
            {
              function()
                local buf_clients = nil
                if vim.lsp.get_clients ~= nil then
                  -- buf_get_client is deprecated in nvim >=0.10.0
                  buf_clients = vim.lsp.get_clients({ bufnr = 0 })
                else
                  buf_clients = vim.lsp.buf_get_clients()
                end
                local null_ls_installed, null_ls = pcall(require, "null-ls")
                local conform_installed, conform = pcall(require, "conform")
                local buf_client_names = {}

                for _, client in pairs(buf_clients) do
                  if client.name ~= "null-ls" then
                    table.insert(buf_client_names, client.name)
                  end
                end

                if null_ls_installed then
                  for _, source in ipairs(null_ls.get_source({ filetype = vim.bo.filetype })) do
                    table.insert(buf_client_names, source.name)
                  end
                end

                if conform_installed then
                  local formatters = conform.list_formatters(0)
                  for _, source in ipairs(formatters) do
                    table.insert(buf_client_names, source.name)
                  end
                end

                return " [" .. table.concat(buf_client_names, ",") .. "]"
              end,
              color = function()
                return { fg = Snacks.util.color("Type") }
              end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { fg = Snacks.util.color("Debug") } end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { fg = Snacks.util.color("Special") } end,
            },
          },
          lualine_y = {

            { "filetype", separator = "", padding = { left = 1, right = 0 } },
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        extensions = { "lazy", "fzf" },
      }

      return opts
    end,
  },
}
