local loader = require("loader")

local setup = function()
  loader.packadd("SmoothCursor.nvim")

  require("smoothcursor").setup({
    type = "default", -- Cursor movement calculation method, choose "default", "exp" (exponential) or "matrix".

    cursor = "", -- Cursor shape (requires Nerd Font). Disabled in fancy mode.
    texthl = "SmoothCursor", -- Highlight group. Default is { bg = nil, fg = "#FFD400" }. Disabled in fancy mode.
    linehl = nil, -- Highlights the line under the cursor, similar to 'cursorline'. "CursorLine" is recommended. Disabled in fancy mode.
  })
end

loader.defer_buffer("smoothcursor", setup, { schedule = true })
