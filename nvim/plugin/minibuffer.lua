vim.g.minibuffer = {
  dynamic_window_resize = true, -- Shrink other windows when the minibuffer is expanded
  cmd = {
    -- NOTE: minibuffer cmd is not compatible with command line plugins that force `wildtrigger()` each `wildchar` such as mini.cmdline
    enabled = false, -- Enable command line wildmenu replacement through the minibuffer
    autotrigger = false, -- Display completion suggestions as you type
    dynamic_height = true, -- Whether the completion window should shrink as items disappear.
    max_height = 15, -- Maximum height when using the command line
  },
}

local loader = require("loader")

loader.on_very_lazy("minibuffer", function()
  loader.packadd("minibuffer.nvim")

  local minibuffer = require("minibuffer")
  vim.keymap.set("n", "<leader><CR>", function()
    minibuffer.resume(true)
  end, { desc = "Resume" })
end)
