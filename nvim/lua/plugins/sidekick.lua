return {
  "folke/sidekick.nvim",
  cmd = "Sidekick",
  enabled = false,
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
  -- keys = {
  --   {
  --     "<Tab>",
  --     function()
  --       if not require("sidekick").nes_jump_or_apply() then
  --         return "<Tab>"
  --       end
  --     end,
  --     expr = true,
  --     desc = "Goto/Apply Next Edit Suggestion",
  --   },
  --   {
  --     "<leader>aa",
  --     function()
  --       require("sidekick.cli").toggle({ focus = true })
  --     end,
  --     mode = { "n", "v" },
  --     desc = "Sidekick Toggle CLI",
  --   },
  --   {
  --     "<leader>as",
  --     function()
  --       require("sidekick.cli").select({ filter = { installed = true } })
  --     end,
  --     desc = "Sidekick Select CLI",
  --   },
  --   {
  --     "<leader>at",
  --     function()
  --       require("sidekick.cli").send({ msg = "{this}" })
  --     end,
  --     mode = { "x", "n" },
  --     desc = "Send This",
  --   },
  --   {
  --     "<leader>av",
  --     function()
  --       require("sidekick.cli").send({ msg = "{selection}" })
  --     end,
  --     mode = { "x" },
  --     desc = "Send Visual Selection",
  --   },
  --   {
  --     "<leader>ap",
  --     function()
  --       require("sidekick.cli").prompt()
  --     end,
  --     mode = { "n", "v" },
  --     desc = "Sidekick Select Prompt",
  --   },
  --   {
  --     "<c-.>",
  --     function()
  --       require("sidekick.cli").focus()
  --     end,
  --     mode = { "n", "x", "i", "t" },
  --     desc = "Sidekick Switch Focus",
  --   },
  -- },
  config = function(_, opts)
    require("sidekick").setup(opts)
    local disabled = false
    vim.api.nvim_create_autocmd("User", {
      pattern = "SidekickNesHide",
      callback = function()
        if disabled then
          disabled = false
          require("tiny-inline-diagnostic").enable()
        end
      end,
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "SidekickNesShow",
      callback = function()
        disabled = true
        require("tiny-inline-diagnostic").disable()
      end,
    })
  end,
}
