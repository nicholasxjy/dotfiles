return {
  "folke/sidekick.nvim",
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
          height = 0.8,
        },
        keys = {
          hide_n = { "q", "hide", mode = "n" }, -- hide the terminal window in normal mode
          hide_t = { "<c-q>", "hide" }, -- hide the terminal window in terminal mode
          win_p = { "<c-w>p", "blur" }, -- leave the cli window
          prompt = { "<c-p>", "prompt" }, -- insert prompt or context
        },
      },
      mux = {
        backend = "zellij",
        enabled = true,
      },
      tools = {
        copilot = {
          cmd = { "copilot", "--banner" },
          url = "https://github.com/github/copilot-cli",
        },
      },
    },
  },
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
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle({ focus = true })
      end,
      mode = { "n", "v" },
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>as",
      function()
        require("sidekick.cli").select({ filter = { installed = true } })
      end,
      desc = "Sidekick Select CLI",
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "v" },
      desc = "Sidekick Select Prompt",
    },
    {
      "<c-.>",
      function()
        require("sidekick.cli").focus()
      end,
      mode = { "n", "x", "i", "t" },
      desc = "Sidekick Switch Focus",
    },
  },
}
