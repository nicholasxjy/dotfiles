return {
  -- {
  --   "ibhagwan/fzf-lua",
  --   keys = {
  --     {
  --       "<leader><space>",
  --       function()
  --         require("fzf-lua").files({
  --           cwd_prompt = true,
  --           cwd_prompt_shorten_len = 32,
  --           cwd_prompt_shorten_val = 2,
  --         })
  --       end,
  --       desc = "Find Files",
  --     },
  --   },
  --   opts = {
  --     winopts = {
  --       title = true,
  --       title_pos = "center",
  --       border = "single",
  --       row = 1,
  --       width = 1.0,
  --       height = 0.45,
  --     },
  --   },
  -- },
  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    keys = {
      {
        "<leader><space>",
        function()
          require("telescope").extensions.smart_open.smart_open({
            cwd_only = true,
            filename_first = true,
          })
        end,
        desc = "Find Files Smart",
      },
    },
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("smart_open")
      end)
    end,
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require("telescope.actions")
      local defaults = {
        prompt_prefix = "  ",
        file_ignore_patterns = { "^%.git[/\\]", "[/\\]%.git[/\\]" },
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
          height = 0.45,
          preview_cutoff = 120,
        },
      }
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, defaults)
      opts.defaults.mappings.i["<C-j>"] = actions.move_selection_next
      opts.defaults.mappings.i["<C-k>"] = actions.move_selection_previous

      local ivy_defaults = require("telescope.themes").get_ivy(opts.defaults)

      opts.defaults = ivy_defaults

      opts.extensitions = opts.extensitions or {}
      opts.extensitions.smart_open = {
        match_algorithm = "fzf",
        disable_devicons = false,
        show_scores = true,
        open_buffer_indicators = { previous = "•", others = "∘" },
      }
    end,
  },
}
