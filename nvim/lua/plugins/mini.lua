return {
  -- {
  --   "echasnovski/mini.files",
  --   dependencies = { "echasnovski/mini.icons" },
  --   keys = {
  --     {
  --       "<leader>e",
  --       function()
  --         local path = vim.bo.buftype ~= "nofile" and vim.api.nvim_buf_get_name(0) or nil
  --         require("mini.files").open(path)
  --       end,
  --       desc = "Open mini.files (cwd)",
  --     },
  --   },
  --   config = function()
  --     require("mini.files").setup({
  --       windows = {
  --         width_focus = 40,
  --         width_nofocus = 40,
  --       },
  --       mappings = {
  --         close = "<esc>",
  --         go_in = "l",
  --         go_in_plus = "L",
  --         go_out = "h",
  --         go_out_plus = "H",
  --         mark_goto = "'",
  --         mark_set = "m",
  --         reset = "<BS>",
  --         reveal_cwd = "@",
  --         show_help = "g?",
  --         synchronize = "=",
  --         trim_left = "<",
  --         trim_right = ">",
  --       },
  --
  --       -- General options
  --       options = {
  --         -- Whether to delete permanently or move into module-specific trash
  --         permanent_delete = true,
  --         -- Whether to use for editing directories
  --         use_as_default_explorer = true,
  --       },
  --     })
  --   end,
  -- },
  { "echasnovski/mini.ai", version = false },
  { "echasnovski/mini.surround", version = false },
  -- icons
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
