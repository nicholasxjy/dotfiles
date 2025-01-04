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
          width = math.floor(vim.o.columns * 0.5),
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
  -- {
  --   "ThePrimeagen/harpoon",
  --   branch = "harpoon2",
  --   opts = {
  --     settings = {
  --       save_on_toggle = true,
  --     },
  --   },
  --   keys = function()
  --     local keys = {
  --       {
  --         "<leader>a",
  --         function()
  --           require("harpoon"):list():add()
  --         end,
  --         desc = "Harpoon File",
  --       },
  --       {
  --         "<leader>h",
  --         function()
  --           local harpoon = require("harpoon")
  --           harpoon.ui:toggle_quick_menu(harpoon:list())
  --         end,
  --         desc = "Harpoon Quick Menu",
  --       },
  --     }
  --
  --     for i = 1, 5 do
  --       table.insert(keys, {
  --         "<leader>" .. i,
  --         function()
  --           require("harpoon"):list():select(i)
  --         end,
  --         desc = "Harpoon to File " .. i,
  --       })
  --     end
  --     return keys
  --   end,
  --   config = function(_, opts)
  --     local harpoon = require("harpoon")
  --     harpoon:setup(opts)
  --     -- basic telescope configuration
  --     local conf = require("telescope.config").values
  --     local function toggle_telescope(harpoon_files)
  --       local file_paths = {}
  --       for _, item in ipairs(harpoon_files.items) do
  --         table.insert(file_paths, item.value)
  --       end
  --
  --       require("telescope.pickers")
  --         .new({}, {
  --           prompt_title = "Harpoon",
  --           finder = require("telescope.finders").new_table({
  --             results = file_paths,
  --           }),
  --           previewer = conf.file_previewer({}),
  --           sorter = conf.generic_sorter({}),
  --         })
  --         :find()
  --     end
  --
  --     vim.keymap.set("n", "<C-e>", function()
  --       toggle_telescope(harpoon:list())
  --     end, {
  --       desc = "Harpoon quick menu",
  --     })
  --   end,
  -- },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   dependencies = {
  --     {
  --       "kiennt63/harpoon-files.nvim",
  --       dependencies = {
  --         { "ThePrimeagen/harpoon", branch = "harpoon2" },
  --       },
  --     },
  --     "echasnovski/mini.icons",
  --   },
  --   opts = function(_, opts)
  --     local harpoon_files = require("harpoon_files")
  --     opts.sections = opts.sections or {}
  --     opts.sections.lualine_c = opts.sections.lualine_c or {}
  --     table.insert(opts.sections.lualine_c, { harpoon_files.lualine_component })
  --   end,
  -- },
}
