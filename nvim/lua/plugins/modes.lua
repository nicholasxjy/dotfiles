return {
  "mvllow/modes.nvim",
  config = function()
    require("modes").setup({
      colors = {
        bg = "", -- Optional bg param, defaults to Normal hl group
        copy = "#f9e2af",
        delete = "#f38ba8",
        insert = "#a6e3a1",
        visual = "#f5c2e7",
      },
      -- Enable cursor highlights
      set_cursor = true,

      -- Enable cursorline initially, and disable cursorline for inactive windows
      -- or ignored filetypes
      set_cursorline = true,

      -- Enable line number highlights to match cursorline
      set_number = true,
      -- Disable modes highlights in specified filetypes
      -- Please PR commonly ignored filetypes
      ignore_filetypes = { "NvimTree", "TelescopePrompt" },
      -- Set opacity for cursorline and number background
      line_opacity = 0.2,
    })
  end,
}
