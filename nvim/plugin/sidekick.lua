local loader = require("loader")

local setup = function()
  loader.packadd("sidekick.nvim")

  local ui = require("ui")

  local cli = require("sidekick.cli")
  local sidekick = require("sidekick")

  sidekick.setup({
    nes = {
      enabled = false,
    },
    cli = {
      tools = {
        grok = {
          cmd = { "grok" },
        },
        omp = {
          cmd = { "omp" },
        },
      },
      watch = true,
      win = {
        layout = "float",
        float = {
          row = 0,
          width = 1,
          height = 0.8,
        },
        split = {
          width = 0.3,
        },
      },
      mux = {
        enabled = true,
        backend = "tmux",
        create = "split",
        split = {
          vertical = true,
          size = 0.4,
        },
      },
      prompts = {
        optimize = "optimize {this}",
      },
    },
  })

  vim.keymap.set("n", "<tab>", function()
    if sidekick.nes_jump_or_apply() then
      return ""
    end
    return "<Tab>"
  end, {
    expr = true,
    desc = "Next Suggestion",
  })

  vim.keymap.set({ "n", "t", "i", "x" }, "<M-.>", function()
    cli.toggle({
      snacks = {
        layout = ui.snacks_layout.vscode,
      },
    })
  end, {
    desc = "Toggle Sidekick",
    silent = true,
  })

  vim.keymap.set("n", "<leader>aa", function()
    cli.toggle({
      snacks = {
        layout = ui.snacks_layout.vscode,
      },
    })
  end, { desc = "Toggle CLI" })

  vim.keymap.set("n", "<leader>as", function()
    cli.select({ filter = { installed = true } })
  end, { desc = "Select CLI" })

  vim.keymap.set("n", "<leader>ad", function()
    cli.close()
  end, { desc = "Close CLI" })

  vim.keymap.set({ "x", "n" }, "<leader>at", function()
    cli.send({ msg = "{this}" })
  end, { desc = "Send Current" })

  vim.keymap.set("n", "<leader>af", function()
    cli.send({ msg = "{file}" })
  end, { desc = "Send File" })

  vim.keymap.set("x", "<leader>av", function()
    cli.send({ msg = "{selection}" })
  end, { desc = "Send Selection" })

  vim.keymap.set({ "n", "x" }, "<leader>ap", function()
    cli.prompt()
  end, { desc = "Select Prompt" })
end

loader.on_very_lazy("sidekick", setup)
