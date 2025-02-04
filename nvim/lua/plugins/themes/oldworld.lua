return {
  "dgox16/oldworld.nvim",
  lazy = false,
  priority = 1000,
  config = function(_, opts)
    local colors = require("oldworld.variants")("cooler")

    opts = vim.tbl_deep_extend("force", opts or {}, {
      terminal_colors = true,
      variant = "cooler",
      styles = {
        comments = { italic = true },
        keywords = { bold = true },
      },
    })
    opts.highlight_overrides = vim.tbl_deep_extend("force", opts.highlight_overrides or {}, {

      -- Pmenu = { fg = colors.fg, bg = colors.bg_dark },
      -- NormalFloat = { fg = colors.fg, bg = colors.bg_dark },
      FzfLuaTitle = { fg = colors.bg, bg = colors.red },
      FzfLuaPreviewTitle = { fg = colors.bg, bg = colors.green },
      FzfLuaBorder = { fg = colors.bg_dark },

      SnacksPickerBoxTitle = { fg = colors.bg, bg = colors.bright_red },
    })
    require("oldworld").setup(opts)
  end,
}
