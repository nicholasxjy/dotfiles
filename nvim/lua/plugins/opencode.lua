return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim" },
  },
  event = "VeryLazy",
  keys = {
    {
      "<leader>at",
      function()
        require("opencode").ask()
      end,
      mode = { "n", "x" },
      desc = "Ask opencode",
    },
    {
      "<leader>ap",
      function()
        require("opencode").select()
      end,
      mode = { "n", "x" },
      desc = "Execute opencode action…",
    },
    {
      "<leader>aA",
      function()
        require("opencode").toggle()
      end,
      mode = { "n", "t" },
      desc = "Toggle opencode",
    },
    {
      "<leader>av",
      function()
        return require("opencode").operator("@this ")
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Add range to opencode",
    },
    {
      "<leader>al",
      function()
        return require("opencode").operator("@this ") .. "_"
      end,
      mode = "n",
      expr = true,
      desc = "Add line to opencode",
    },
    {
      "<S-C-u>",
      function()
        require("opencode").command("session.half.page.up")
      end,
      mode = "n",
      desc = "opencode half page up",
    },
    {
      "<S-C-d>",
      function()
        require("opencode").command("session.half.page.down")
      end,
      mode = "n",
      desc = "opencode half page down",
    },
  },
  config = function()
    vim.g.opencode_opts = {
      provider = {
        enabled = "tmux",
        tmux = {
          options = "-v",
        },
      },
    }
    vim.o.autoread = true
  end,
}
