return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  enabled = false,
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  lazy = false,
  keys = {
    {
      "<leader>o",
      function()
        require("oil").toggle_float()
      end,
      desc = "Oil",
    },
  },
  config = function()
    local oil = require("oil")
    oil.setup({
      default_file_explorer = true,
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
      },
      float = {
        padding = 2,
        border = "rounded", --vim.g.bordered and "rounded" or "none",
        max_height = 0.9,
        max_width = 0.8,
        win_options = {
          winhighlight = "Normal:NormalFloat,FloatTitle:FloatTitle,FloatBorder:FloatBorder",
        },
      },
      confirmation = {
        win_options = {
          winhighlight = "Normal:Normal,FloatTitle:FloatTitle,FloatBorder:FloatBorder",
        },
      },
      keymaps = {
        ["<Tab>"] = {
          "actions.select",
          opts = { tab = true },
          desc = "Open the entry in new tab",
        },
        ["q"] = "actions.close",
        ["<Esc>"] = "actions.parent",
      },
    })
    -- Automatically open preview window
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilEnter",
      callback = vim.schedule_wrap(function(args)
        if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
          oil.open_preview()
        end
      end),
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function()
        vim.opt_local.cursorline = true
      end,
    })
  end,
}
