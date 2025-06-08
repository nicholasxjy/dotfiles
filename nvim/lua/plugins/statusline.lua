local icons = require("core.icons")
return {
  "nvim-lualine/lualine.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
    -- PERF: we don't need this lualine require madness
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    vim.o.laststatus = vim.g.lualine_laststatus
    local opts = {
      options = {
        component_separators = "",
        globalstatus = vim.o.laststatus == 3,
        section_separators = "",
        disabled_filetypes = {
          statusline = { "snacks_dashboard" },
        },
        ignore_focus = {
          "dap-repl",
          "dapui_breakpoints",
          "dapui_console",
          "dapui_scopes",
          "dapui_stacks",
          "dapui_watches",
        },
        theme = {
          normal = {
            a = "Identifier",
            b = "LineNr",
            c = "LineNr",
            x = "LineNr",
            y = "LineNr",
            z = "LineNr",
          },
          insert = {
            a = "GitSignsChange",
            b = "LineNr",
            c = "LineNr",
            x = "LineNr",
            y = "LineNr",
            z = "LineNr",
          },
          visual = {
            a = "GitSignsAdd",
            b = "LineNr",
            c = "LineNr",
            x = "LineNr",
            y = "LineNr",
            z = "LineNr",
          },
          replace = {
            a = "GitSignsDelete",
            b = "LineNr",
            c = "LineNr",
            x = "LineNr",
            y = "LineNr",
            z = "LineNr",
          },
          inactive = {
            a = "LineNr",
            b = "LineNr",
            c = "LineNr",
            x = "LineNr",
            y = "LineNr",
            z = "LineNr",
          },
        },
      },
      extensions = { "lazy", "mason", "nvim-dap-ui", "oil", "trouble", "quickfix" },
      sections = {
        lualine_a = {
          {
            require("lazy.status").updates,
            fmt = function()
              return require("lazy.status").updates() or " "
            end,
            padding = 0,
          },
        },
        lualine_b = {
          { "filetype", icon_only = false, padding = { left = 2 } },
          {
            "filename",
            symbols = {
              modified = "󰯹 ",
              readonly = "󰰠 ",
              unnamed = "󰰩 ",
              newfile = "󰰔 ",
            },
            padding = { left = 1 },
          },
        },
        lualine_c = {
          { "branch", icon = " ", padding = { left = 2 } },
          {
            "diff",
            diff_color = {
              added = "GitSignsAdd",
              modified = "GitSignsChange",
              removed = "GitSignsDelete",
            },
            symbols = { added = "󰯭 ", modified = "󰯳 ", removed = "󰯶 " },
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
            padding = { left = 1 },
          },
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
        },
        lualine_x = { { "lsp_status", icon = "", symbols = { done = "●" } } },
        lualine_y = {
          {
            "macro",
            fmt = function()
              local reg = vim.fn.reg_recording()
              if reg == "" then
                return ""
              end
              return "󰑋 " .. reg
            end,
            padding = { right = 2 },
          },
        },
        lualine_z = {
          { "location", padding = { right = 1 } },
          { "progress", padding = 0 },
        },
      },
      inactive_sections = {
        lualine_a = {
          { "filetype", icon_only = true, padding = 0 },
          { "filename", padding = 0 },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    }
    return opts
  end,
}
