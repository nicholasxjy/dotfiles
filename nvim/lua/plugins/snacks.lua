local myselect = {
  preview = false,
  layout = {
    backdrop = false,
    row = 0.4,
    width = 0.75,
    min_width = 80,
    height = 0.4,
    min_height = 3,
    box = "vertical",
    border = "rounded",
    title = "{title}",
    title_pos = "center",
    { win = "input", height = 1, border = "bottom" },
    { win = "list", border = "none" },
    { win = "preview", title = "{preview}", height = 0.4, border = "top" },
  },
}
return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    keys = {
      -- stylua: ignore start
      { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode", },
      {
        "<leader>e",
        function()
          ---@diagnostic disable-next-line: missing-fields
          Snacks.explorer({
            diagnostics = true,
            git_status = true,
            ignored = true,
            hidden = true,
          })
        end,
        desc = "File explorer",
      },
      { "<leader><space>", function() Snacks.picker.smart({ layout = myselect, }) end, desc = "Snacks Smart", },
      { "<leader>h", function() Snacks.picker.buffers({ layout = myselect, }) end, desc = "Snacks Buffers", },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications", },
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notifications", },
      -- trouble
      {
        "<leader>xt",
        function()
          ---@diagnostic disable-next-line: undefined-field
          Snacks.picker.todo_comments({
            focus = "list",
            layout = { preset = "dropdown" },
            keywords = { "TODO", "FIX", "FIXME" },
          })
        end,
        desc = "Todo/Fix/Fixme",
      },
      {
        "<leader>xT",
        function()
          ---@diagnostic disable-next-line: undefined-field
          Snacks.picker.todo_comments()
        end,
        desc = "TODO",
      },
      -- stylua: ignore end
    },
    opts = {
      explorer = {
        enabled = true,
        replace_netrw = false,
      },
      picker = {
        enabled = true,
        ui_select = false,
        matcher = {
          cwd_bonus = true, -- give bonus for matching files in the cwd
          frecency = true, -- frecency bonus
          history_bonus = true, -- give more weight to chronological order
        },
        formatters = {
          -- file = {
          -- filename_first = true,
          -- },
        },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
          list = {
            keys = {},
          },
        },
      },
      image = {
        enabled = true,
      },
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
      indent = {
        indent = {
          enabled = false,
          char = "",
          only_current = true,
          only_scope = true,
        },
        scope = {
          enabled = true,
          --char = "⁚",
          -- char = "║",
          underline = false,
          only_current = true,
        },
        chunk = {
          enabled = true,
          char = {
            -- corner_top = "┌",
            -- corner_bottom = "└",
            corner_top = "╭",
            corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = "", --"󰶻  ", -- 
          },
          only_current = true,
        },
      },
      bigfile = { enabled = true },
      dim = { enabled = true },
      zen = {
        enabled = true,
        win = {
          backdrop = {
            transparent = false,
          },
        },
      },
      scroll = { enabled = false },
      input = { enabled = true },
      words = { enabled = false },
      statuscolumn = {
        enabled = true,
        left = { "mark", "sign" }, -- priority of signs on the left (high to low)
        right = { "fold", "git" }, -- priority of signs on the right (high to low)
        folds = {
          open = true, -- show open fold icons
          git_hl = true, -- use Git Signs hl for fold icons
        },
      },
      notifier = { enabled = true },
      toggle = { enabled = true },
      lazygit = {
        enabled = true,
        win = {
          width = 0.9,
          height = 0.9,
        },
      },
      terminal = {
        enabled = true,
        -- win = {
        --   position = "float",
        --   width = 0.85,
        --   height = 0.55,
        -- },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          ---@diagnostic disable-next-line: duplicate-set-field
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          ---@diagnostic disable-next-line: duplicate-set-field
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },
}
