return {
  {
    "cbochs/grapple.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    opts = {
      scope = "git",
      status = true,
      icons = true,
      tag_title = function()
        return "Grapple"
      end,
      win_opts = {
        width = math.floor(vim.o.columns * 0.7),
        title = "Grapple",
        title_pos = "left",
        footer = "",
      },
    },
    keys = {
      { "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Toggle Grapple tag" },
      { "<leader>h", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle Grapple window" },
      { "<c-e>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections = opts.sections or {}
      opts.sections.lualine_c = opts.sections.lualine_c or {}
      table.insert(opts.sections.lualine_c, { "grapple" })
    end,
  },
}
