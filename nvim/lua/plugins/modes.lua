return {
  "mvllow/modes.nvim",
  event = "VeryLazy",
  config = function()
    require("modes").setup({
      colors = {
        bg = "#24283b", -- Optional bg param, defaults to Normal hl group
        copy = "#e0af68",
        delete = "#db4b4b",
        insert = "#9ece6a",
        visual = "#ff007c",
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
