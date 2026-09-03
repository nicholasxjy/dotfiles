local theme = require("theme")

-- Currently set to tokyonight
theme.setup("hues")

vim.api.nvim_create_user_command("Theme", function(opts)
  local name = vim.trim(opts.args)
  if name == "" then
    vim.notify(
      string.format("Current theme: %s\nAvailable: %s", theme.current, table.concat(theme.available(), ", ")),
      vim.log.levels.INFO
    )
  elseif name == "toggle" then
    theme.toggle()
  else
    theme.set(name)
  end
end, {
  nargs = "?",
  complete = function()
    local completions = theme.available()
    table.insert(completions, "toggle")
    return completions
  end,
  desc = "Switch or toggle color theme",
})

vim.api.nvim_create_user_command("ThemeToggle", function()
  theme.toggle()
end, { desc = "Toggle color theme" })

vim.keymap.set("n", "<leader>uT", function()
  theme.toggle()
end, { desc = "Toggle color theme" })
