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
      desc = "Goto/Apply Next Edit Suggestion",
    },
  },
  opts = {
    nes = {
      enabled = true,
    },
    cli = {
      watch = true,
      win = {
        layout = "float",
        float = {
          width = 0.8,
          height = 0.6,
        },
        split = {
          width = 80,
        },
        keys = {
          hide_n = { "q", "hide", mode = "n" }, -- hide the terminal window in normal mode
          hide_t = { "<c-q>", "hide" }, -- hide the terminal window in terminal mode
          win_p = { "<c-w>p", "blur" }, -- leave the cli window
          prompt = { "<c-p>", "prompt" }, -- insert prompt or context
        },
      },
      mux = {
        backend = vim.env.ZELLIJ and "zellij" or "tmux",
        enabled = true,
        -- terminal: new sessions will be created for each CLI tool and shown in a Neovim terminal
        -- window: when run inside a terminal multiplexer, new sessions will be created in a new tab
        -- split: when run inside a terminal multiplexer, new sessions will be created in a new split
        -- NOTE: zellij only supports `terminal`
        create = "terminal",
        split = {
          -- vertical = true, -- vertical or horizontal split
          horizontal = true,
          size = 0.4, -- size of the split (0-1 for percentage)
        },
      },
      tools = {
        copilot = {
          cmd = { "copilot", "--banner" },
          url = "https://github.com/github/copilot-cli",
        },
      },
    },
  },
}
