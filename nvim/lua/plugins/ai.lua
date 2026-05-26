return {
  {
    "nicholasxjy/translator.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>bv",
        function()
          require("translator").transVisualSel()
        end,
        mode = "v",
        desc = "Translate Selection",
      },
      {
        "<leader>bc",
        function()
          require("translator").transCurWord()
        end,
        desc = "Translate Word",
      },
    },
    opts = {
      default_target_lang = "zh",
      default_source_lang = nil,
      window = {
        width = 60,
      },
    },
  },

  {
    "nicholasxjy/sidekick.nvim",
    event = "InsertEnter",
    cmd = "Sidekick",
    keys = {
      {
        "<tab>",
        function()
          local sidekick = require("sidekick")
          if not sidekick.nes_jump_or_apply() then
            return "<Tab>"
          end
        end,
        expr = true,
        desc = "Next Suggestion",
      },
      {
        "<c-.>",
        function()
          require("sidekick.cli").focus()
        end,
        mode = { "n", "t", "i", "x" },
        desc = "Focus Sidekick",
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
        mode = "x",
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
        tools = {
          codex = {
            cmd = { "codex" },
          },
          omp = {
            cmd = { "omp" },
          },
        },
        watch = true,
        win = {
          layout = "right",
          split = {
            width = 0.45,
          },
        },
        mux = {
          backend = vim.env.ZELLIJ and "zellij" or "tmux",
          enabled = true,
          create = vim.env.ZELLIJ and "terminal" or "split",
          split = {
            vertical = true,
            size = 0.45,
          },
        },
        prompts = {
          optimize = "optimize {this}",
          improve = "improve this function {function}",
          commit = "commit changes",
        },
      },
    },
    config = function(_, opts)
      require("sidekick").setup(opts)
    end,
  },
}
