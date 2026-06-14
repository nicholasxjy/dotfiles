vim.pack.add({
  "https://github.com/nicholasxjy/sidekick.nvim",
}, { load = false })

local loaded = false

local function load_sidekick()
  if loaded then
    return require("sidekick"), require("sidekick.cli")
  end

  vim.cmd.packadd("sidekick.nvim")

  local sidekick = require("sidekick")
  local cli = require("sidekick.cli")

  sidekick.setup({
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
        jcode = {
          cmd = { "jcode" },
        },
        maki = {
          cmd = { "maki" },
        },
      },
      watch = true,
      win = {
        layout = "float",
        float = {
          row = 0,
          width = 0.9,
          height = 0.7,
        },
        split = {
          width = 0.45,
        },
      },
      mux = {
        enabled = false,
        backend = "zellij",
        create = "terminal",
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
  })

  loaded = true

  return sidekick, cli
end

vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    load_sidekick()
  end,
})

vim.keymap.set("n", "<tab>", function()
  local sidekick = loaded and require("sidekick") or nil
  if sidekick and sidekick.nes_jump_or_apply() then
    return ""
  end
  return "<Tab>"
end, {
  expr = true,
  desc = "Next Suggestion",
})

vim.keymap.set({ "n", "t", "i", "x" }, "<M-.>", function()
  local _, cli = load_sidekick()
  cli.toggle()
end, {
  desc = "Toggle Sidekick",
  silent = true,
})

vim.keymap.set("n", "<leader>aa", function()
  local _, cli = load_sidekick()
  cli.toggle()
end, { desc = "Toggle CLI" })

vim.keymap.set("n", "<leader>as", function()
  local _, cli = load_sidekick()
  cli.select({ filter = { installed = true } })
end, { desc = "Select CLI" })

vim.keymap.set("n", "<leader>ad", function()
  local _, cli = load_sidekick()
  cli.close()
end, { desc = "Close CLI" })

vim.keymap.set({ "x", "n" }, "<leader>at", function()
  local _, cli = load_sidekick()
  cli.send({ msg = "{this}" })
end, { desc = "Send Current" })

vim.keymap.set("n", "<leader>af", function()
  local _, cli = load_sidekick()
  cli.send({ msg = "{file}" })
end, { desc = "Send File" })

vim.keymap.set("x", "<leader>av", function()
  local _, cli = load_sidekick()
  cli.send({ msg = "{selection}" })
end, { desc = "Send Selection" })

vim.keymap.set({ "n", "x" }, "<leader>ap", function()
  local _, cli = load_sidekick()
  cli.prompt()
end, { desc = "Select Prompt" })
