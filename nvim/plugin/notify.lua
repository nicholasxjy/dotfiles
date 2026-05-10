local util = require("util")

local fallback_notify = vim.notify
local loading_notify = false

local notify_opts = {
  render = "wrapped-compact",
  stages = "fade_in_slide_out",
  on_open = function(win)
    local buf = vim.api.nvim_win_get_buf(win)
    vim.bo[buf].filetype = "markdown"
  end,
}

local progress_opts = {
  notification = notify_opts,
}

local function setup_notify()
  if vim.g.notify_setup_done then
    return require("notify")
  end

  if loading_notify then
    return nil
  end

  loading_notify = true
  vim.notify = fallback_notify

  local ok, notify = pcall(function()
    util.ensure_plugin("nvim-notify", function()
      require("notify").setup(notify_opts)
      vim.g.notify_setup_done = true
    end, false)

    return require("notify")
  end)

  loading_notify = false

  if ok then
    vim.notify = notify
    return notify
  end

  vim.notify = fallback_notify
  fallback_notify(notify, vim.log.levels.ERROR)
  return nil
end

local function setup_lsp_progress_notify()
  if vim.g.lsp_progress_notify_setup_done then
    return
  end

  setup_notify()
  util.ensure_plugin("lsp-progress-notify.nvim", function()
    require("lsp-progress-notify").setup(progress_opts)
    vim.g.lsp_progress_notify_setup_done = true
  end, false)
end

vim.notify = function(...)
  local notify = setup_notify()
  if notify then
    return notify(...)
  end

  return fallback_notify(...)
end

vim.keymap.set("n", "<leader>un", function()
  setup_notify().clear_history()
end, { desc = "Clear Notifications" })

vim.keymap.set("n", "<leader>N", function()
  setup_notify()
  if type(_G.__setup_fzf) == "function" then
    _G.__setup_fzf()
  end
  require("notify.integrations.fzf").open()
end, { desc = "Notifications", silent = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspProgressNotifyDeferred", { clear = true }),
  once = true,
  callback = function()
    vim.schedule(setup_lsp_progress_notify)
  end,
})
