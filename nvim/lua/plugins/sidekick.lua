return {
  "folke/sidekick.nvim",
  cmd = "Sidekick",
  keys = {
    {
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Next Suggestion",
    },
    {
      "<c-.>",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Toggle Sidekick",
      mode = { "n", "t", "i", "x" },
      noremap = true,
      silent = true,
    },
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Toggle CLI",
    },
    {
      "<leader>as",
      function()
        require("sidekick.cli").select({ filter = { installed = true } })
      end,
      desc = "Select CLI",
    },
    {
      "<leader>ad",
      function()
        require("sidekick.cli").close()
      end,
      desc = "Close CLI",
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      mode = { "x", "n" },
      desc = "Send Current",
    },
    {
      "<leader>af",
      function()
        require("sidekick.cli").send({ msg = "{file}" })
      end,
      desc = "Send File",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      mode = { "x" },
      desc = "Send Selection",
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "x" },
      desc = "Select Prompt",
    },
  },
  opts = {
    nes = {
      enabled = true,
    },
    cli = {
      watch = true,
      -- win = {
      --   layout = "float",
      --   float = {
      --     width = 0.8,
      --     height = 0.7,
      --   },
      -- },
      mux = {
        backend = vim.env.ZELLIJ and "zellij" or "tmux",
        enabled = true,
        -- terminal: new sessions will be created for each CLI tool and shown in a Neovim terminal
        -- window: when run inside a terminal multiplexer, new sessions will be created in a new tab
        -- split: when run inside a terminal multiplexer, new sessions will be created in a new split
        -- NOTE: zellij only supports `terminal`
        create = "window",
      },
    },
  },
}
