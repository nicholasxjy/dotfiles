local loader = require("loader")

local M = {}

---@param colors table<string, any>
M.on_colors = function(colors) end

---@param highlights table<string, any>
---@param colors table<string, any>
M.on_highlights = function(highlights, colors)
  highlights.WinBar = { fg = colors.fg, bg = "NONE" }
  highlights.FzfLuaDirPart = { fg = colors.fg_gutter, bold = true }
  highlights.ZedBarFile = { fg = colors.fg_gutter, bold = true }
  highlights.XuePickerGrepPath = { link = "Comment" }

  highlights["@keyword.import"] = { fg = colors.teal, italic = true }
  highlights["@keyword.export"] = { link = "@keyword.import" }
  highlights["@tag.tsx"] = { fg = colors.red, bold = true }
  highlights["@tag.attribute"] = { fg = colors.blue2, italic = true }
end

--- Setup tokyonight theme
---@param style? string "moon" | "storm" | "night" | "day"
function M.setup(style)
  loader.packadd("tokyonight.nvim")

  require("tokyonight").setup({
    style = style or "moon",
    light_style = "day",
    transparent = true,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = false, bold = false },
      functions = {},
      variables = {},
      sidebars = "transparent",
      floats = "transparent",
    },
    day_brightness = 0.3,
    dim_inactive = false,
    lualine_bold = true,
    on_colors = M.on_colors,
    on_highlights = M.on_highlights,
    cache = true,
    plugins = {
      all = true,
      auto = true,
    },
  })

  vim.cmd.colorscheme("tokyonight")
end

return M
