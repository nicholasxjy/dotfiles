return {
  "gen740/SmoothCursor.nvim",
  lazy = false,
  opts = {
    type = "default",
    autostart = true,
    fancy = {
      enable = true, -- enable fancy mode
      head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil }, -- false to disable fancy head
      body = {
        { cursor = "󰝥", texthl = "SmoothCursorRed" },
        { cursor = "󰝥", texthl = "SmoothCursorOrange" },
        { cursor = "●", texthl = "SmoothCursorYellow" },
        { cursor = "●", texthl = "SmoothCursorGreen" },
        { cursor = "•", texthl = "SmoothCursorAqua" },
        { cursor = ".", texthl = "SmoothCursorBlue" },
        { cursor = ".", texthl = "SmoothCursorPurple" },
      },
      tail = { cursor = nil, texthl = "SmoothCursor" }, -- false to disable fancy tail
    },
    enabled_filetypes = nil,
    disabled_filetypes = nil,
  },
  config = function(_, opts)
    require("smoothcursor").setup(opts)
  end,
}
