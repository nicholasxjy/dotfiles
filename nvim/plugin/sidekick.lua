local cli = require("sidekick.cli")
local sidekick = require("sidekick")

sidekick.setup({
  nes = {
    enabled = true,
  },
  cli = {
    tools = {
      codex = {
        cmd = { "omx", "--madmax", "--high" },
      },
      ohmypi = {
        cmd = { "omp" },
      },
      jcode = {
        cmd = { "jcode" },
      },
    },
    watch = true,
    win = {
      layout = "left",
      split = {
        width = 0.4,
      },
    },
    mux = {
      backend = vim.env.ZELLIJ and "zellij" or "tmux",
      enabled = true,
      -- terminal: new sessions will be created for each CLI tool and shown in a Neovim terminal
      -- window: when run inside a terminal multiplexer, new sessions will be created in a new tab
      -- split: when run inside a terminal multiplexer, new sessions will be created in a new split
      -- NOTE: zellij only supports `terminal`
      create = "terminal", --vim.env.ZELLIJ and "terminal" or "split",
      split = {
        vertical = true, -- vertical or horizontal split
        size = 0.4, -- size of the split (0-1 for percentage)
      },
    },
    prompts = {
      optimize = "optimize {this}",
    },
  },
})

vim.keymap.set("n", "<tab>", function()
  if not sidekick.nes_jump_or_apply() then
    return "<Tab>" -- fallback to normal tab
  end
end, {
  expr = true,
  desc = "Next Suggestion",
})

vim.keymap.set({ "n", "t", "i", "x" }, "<c-.>", function()
  cli.focus()
end, {
  desc = "Focus Sidekick",
  silent = true,
})

vim.keymap.set("n", "<leader>aa", function()
  cli.toggle()
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
