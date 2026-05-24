local util = require("util")

local function setup_sidekick()
  util.ensure_plugin("sidekick.nvim", function()
    require("sidekick").setup({
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
    })
  end, false)

  return require("sidekick"), require("sidekick.cli")
end

vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    setup_sidekick()
  end,
})

vim.api.nvim_create_user_command("Sidekick", function(args)
  pcall(vim.api.nvim_del_user_command, "Sidekick")
  setup_sidekick()
  require("sidekick.commands").cmd(args)
end, {
  range = true,
  nargs = "?",
  desc = "Sidekick",
})

vim.keymap.set("n", "<tab>", function()
  local sidekick = setup_sidekick()
  if not sidekick.nes_jump_or_apply() then
    return "<Tab>"
  end
end, {
  expr = true,
  desc = "Next Suggestion",
})

vim.keymap.set({ "n", "t", "i", "x" }, "<c-.>", function()
  local _, cli = setup_sidekick()
  cli.focus()
end, {
  desc = "Focus Sidekick",
  silent = true,
})

vim.keymap.set("n", "<leader>aa", function()
  local _, cli = setup_sidekick()
  cli.toggle()
end, { desc = "Toggle CLI" })

vim.keymap.set("n", "<leader>as", function()
  local _, cli = setup_sidekick()
  cli.select({ filter = { installed = true } })
end, { desc = "Select CLI" })

vim.keymap.set("n", "<leader>ad", function()
  local _, cli = setup_sidekick()
  cli.close()
end, { desc = "Close CLI" })

vim.keymap.set({ "x", "n" }, "<leader>at", function()
  local _, cli = setup_sidekick()
  cli.send({ msg = "{this}" })
end, { desc = "Send Current" })

vim.keymap.set("n", "<leader>af", function()
  local _, cli = setup_sidekick()
  cli.send({ msg = "{file}" })
end, { desc = "Send File" })

vim.keymap.set("x", "<leader>av", function()
  local _, cli = setup_sidekick()
  cli.send({ msg = "{selection}" })
end, { desc = "Send Selection" })

vim.keymap.set({ "n", "x" }, "<leader>ap", function()
  local _, cli = setup_sidekick()
  cli.prompt()
end, { desc = "Select Prompt" })
