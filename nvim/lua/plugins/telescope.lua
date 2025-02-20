local build_cmd ---@type string?
for _, cmd in ipairs({ "make", "cmake", "gmake" }) do
  if vim.fn.executable(cmd) == 1 then
    build_cmd = cmd
    break
  end
end

return {
  -- {
  --   "stevearc/dressing.nvim",
  --   event = "BufRead",
  --   opts = {},
  -- },

  -- {
  --   "nvim-telescope/telescope.nvim",
  --   cmd = "Telescope",
  --   version = false,
  --   dependencies = {
  --     "kkharji/sqlite.lua",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --     {
  --       "nvim-telescope/telescope-fzf-native.nvim",
  --       build = (build_cmd ~= "cmake") and "make"
  --         or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  --       enabled = build_cmd ~= nil,
  --     },
  --     {
  --       "danielfalk/smart-open.nvim",
  --       branch = "0.2.x",
  --     },
  --     "andrew-george/telescope-themes",
  --     "folke/flash.nvim",
  --   },
  --   keys = {
  --     {
  --       "<leader><space>",
  --       function()
  --         require("telescope").extensions.smart_open.smart_open({
  --           cwd_only = true,
  --           filename_first = true,
  --         })
  --       end,
  --       desc = "Find files Smart",
  --     },
  --     { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
  --     {
  --       "<leader>,",
  --       "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
  --       desc = "Switch Buffer",
  --     },
  --     { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
  --
  --     {
  --       "<leader>fb",
  --       function()
  --         require("telescope.builtin").buffers()
  --       end,
  --       desc = "Find buffers",
  --     },
  --     {
  --       "<leader>fg",
  --       function()
  --         require("telescope.builtin").git_files()
  --       end,
  --       desc = "Find Files (git-files)",
  --     },
  --
  --     -- git
  --     {
  --       "<leader>gr",
  --       function()
  --         require("telescope.builtin").git_branches()
  --       end,
  --       desc = "Git branches",
  --     },
  --     {
  --       "<leader>gc",
  --       function()
  --         require("telescope.builtin").git_commits()
  --       end,
  --       desc = "Commits",
  --     },
  --     {
  --       "<leader>gs",
  --       function()
  --         require("telescope.builtin").git_status()
  --       end,
  --       desc = "Status",
  --     },
  --     { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
  --     { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
  --     { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
  --     { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
  --     {
  --       "<leader>sw",
  --       function()
  --         require("telescope.builtin").grep_string()
  --       end,
  --       desc = "Search word under cursor",
  --     },
  --     {
  --       "<leader>sg",
  --       function()
  --         require("telescope.builtin").live_grep()
  --       end,
  --       desc = "Grep (Root Dir)",
  --     },
  --     {
  --       "<leader>ss",
  --       function()
  --         require("telescope.builtin").lsp_document_symbols()
  --       end,
  --       desc = "Goto Symbol",
  --     },
  --     {
  --       "<leader>sS",
  --       function()
  --         require("telescope.builtin").lsp_dynamic_workspace_symbols()
  --       end,
  --       desc = "Goto Symbol (Workspace)",
  --     },
  --     { "<leader>ft", "<cmd>Telescope themes<cr>", desc = "Toggle themes" },
  --   },
  --   config = function()
  --     local telescope = require("telescope")
  --     local actions = require("telescope.actions")
  --     local function open_selected(prompt_bufnr)
  --       local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
  --       local selected = picker:get_multi_selection()
  --       if vim.tbl_isempty(selected) then
  --         actions.select_default(prompt_bufnr)
  --       else
  --         actions.close(prompt_bufnr)
  --         for _, file in pairs(selected) do
  --           if file.path then
  --             vim.cmd("edit" .. (file.lnum and " +" .. file.lnum or "") .. " " .. file.path)
  --           end
  --         end
  --       end
  --     end
  --
  --     local function flash(prompt_bufnr)
  --       require("flash").jump({
  --         pattern = "^",
  --         label = { after = { 0, 0 } },
  --         search = {
  --           mode = "search",
  --           exclude = {
  --             function(win)
  --               return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
  --             end,
  --           },
  --         },
  --         action = function(match)
  --           local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
  --           picker:set_selection(match.pos[1] - 1)
  --         end,
  --       })
  --     end
  --
  --     local defaults = {
  --       prompt_prefix = "  ",
  --       file_ignore_patterns = { "^%.git[/\\]", "[/\\]%.git[/\\]" },
  --       path_display = { "truncate" },
  --       sorting_strategy = "ascending",
  --       layout_config = {
  --         horizontal = { prompt_position = "top", preview_width = 0.45 },
  --         vertical = { mirror = false },
  --         height = 0.45,
  --         preview_cutoff = 120,
  --       },
  --       mappings = {
  --         i = {
  --           ["<C-k>"] = actions.move_selection_previous, -- move to prev result
  --           ["<C-j>"] = actions.move_selection_next, -- move to next result
  --           ["<CR>"] = open_selected,
  --           ["<c-s>"] = flash,
  --         },
  --         n = {
  --           ["q"] = actions.close,
  --           ["<CR>"] = open_selected,
  --           ["s"] = flash,
  --         },
  --       },
  --     }
  --     local ivy_defaults = require("telescope.themes").get_ivy(defaults)
  --     telescope.setup({
  --       extensions = {
  --         smart_open = {
  --           match_algorithm = "fzf",
  --           disable_devicons = false,
  --         },
  --       },
  --       pickers = {
  --         find_files = {
  --           find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
  --         },
  --       },
  --       defaults = ivy_defaults,
  --     })
  --
  --     telescope.load_extension("fzf")
  --     telescope.load_extension("smart_open")
  --     telescope.load_extension("themes")
  --   end,
  -- },
}
