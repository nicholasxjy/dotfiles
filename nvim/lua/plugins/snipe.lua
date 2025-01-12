return {
  {
    "nicholasxjy/snipe.nvim",
    keys = {
      {
        "<leader>h",
        function()
          require("snipe").open_buffer_menu()
        end,
        desc = "Open Snipe buffer menu",
      },
    },
    opts = {
      ui = {
        max_height = -1, -- -1 means dynamic width
        -- Where to place the ui window
        -- Can be any of "topleft", "bottomleft", "topright", "bottomright", "center", "cursor" (sets under the current cursor pos)
        position = "center",
        open_win_override = {
          title = "Snipe",
          border = "single",
          width = math.floor(vim.o.columns * 0.62),
          height = math.floor(vim.o.lines * 0.3),
        },
        preselect_current = false,
        preselect = nil,
        text_align = "file-first",
      },
      hints = {
        dictionary = "1234567890",
      },
      navigate = {
        -- When the list is too long it is split into pages
        -- `[next|prev]_page` options allow you to navigate
        -- this list
        next_page = "J",
        prev_page = "K",

        -- You can also just use normal navigation to go to the item you want
        -- this option just sets the keybind for selecting the item under the
        -- cursor
        under_cursor = "<cr>",

        -- In case you changed your mind, provide a keybind that lets you
        -- cancel the snipe and close the window.
        cancel_snipe = "<esc>",

        -- Close the buffer under the cursor
        -- Remove "j" and "k" from your dictionary to navigate easier to delete
        -- NOTE: Make sure you don't use the character below in your dictionary
        close_buffer = "D",
      },
      sort = "last",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      {
        "nicholasxjy/snipe-lualine-files.nvim",
        dependencies = {
          "nicholasxjy/snipe.nvim",
          "echasnovski/mini.icons",
        },
      },
    },
    opts = function(_, opts)
      local snipe_files = require("snipe-lualine-files")
      opts.sections = opts.sections or {}
      opts.sections.lualine_c = opts.sections.lualine_c or {}
      table.insert(opts.sections.lualine_c, { snipe_files.lualine_component })
    end,
  },
}