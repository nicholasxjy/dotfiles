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
        maki = {
          cmd = { "maki" },
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
        backend = "zellij",
        enabled = true,
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

vim.keymap.set({ "n", "t", "i", "x" }, "<c-.>", function()
  local _, cli = load_sidekick()
  cli.focus()
end, {
  desc = "Focus Sidekick",
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
