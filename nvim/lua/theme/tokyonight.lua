local M = {}

local configured = false

function M.setup()
  if configured then
    return
  end

  local loader = require("loader")
  loader.packadd("tokyonight.nvim")

  require("tokyonight").setup({
    style = "moon", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
    light_style = "day", -- The theme is used when the background is set to light
    transparent = true, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = false, bold = true },
      functions = {},
      variables = {},
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = "transparent", -- style for sidebars, see below
      floats = "transparent", -- style for floating windows
    },
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    dim_inactive = false, -- dims inactive windows
    lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights table<string, any>
    ---@param colors table<string, any>
    on_highlights = function(highlights, colors)
      highlights.WinBar = { fg = colors.fg, bg = "NONE" }
      highlights.ZedBarFile = { fg = colors.fg_gutter, bold = true }
      highlights.XuePickerGrepPath = { link = "Comment" }

      highlights["@keyword.import"] = { fg = colors.teal, italic = true }
      highlights["@keyword.export"] = { link = "@keyword.import" }
      highlights["@tag.tsx"] = { fg = colors.red, bold = true }
      highlights["@tag.attribute"] = { fg = colors.blue2, italic = true }
    end,

    cache = true, -- When set to true, the theme will be cached for better performance

    ---@type table<string, boolean|{enabled:boolean}>
    plugins = {
      -- enable all plugins when not using lazy.nvim
      -- set to false to manually enable/disable plugins
      all = true,
      -- uses your plugin manager to automatically enable needed plugins
      -- currently only lazy.nvim is supported
      auto = true,
      -- add any plugins here that you want to enable
      -- for all possible plugins, see:
      --   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
    },
  })

  configured = true
end

return M
