local M = {}

function M.setup()
  local loader = require("loader")
  loader.packadd("mini.hues")

  require("mini.hues").setup({
    -- Pair TokyoNight Storm's background with a muted cyan foreground.
    background = "#24283b",
    foreground = "#cee6ec",

    -- Number of hues used for non-base colors
    n_hues = 8,

    -- Saturation. One of 'low', 'lowmedium', 'medium', 'mediumhigh', 'high'.
    saturation = "mediumhigh",

    -- Accent color. One of: 'bg', 'fg', 'red', 'orange', 'yellow', 'lime',
    -- 'green', 'teal', 'cyan', 'azure', 'blue', 'indigo', 'purple', 'pink',
    -- or a '#rrggbb' hex string.
    accent = "bg",

    -- Plugin integrations. Use `default = false` to disable all integrations.
    -- Also can be set per plugin (see |MiniHues.config|).
    plugins = { default = true },

    -- Whether to auto adjust highlight groups based on certain events
    autoadjust = true,
  })
  local p = require("mini.hues").get_palette()

  vim.api.nvim_set_hl(0, "PmenuMatch", { fg = p.accent, bold = true })
  vim.api.nvim_set_hl(0, "SnacksPickerDir", { link = "Comment" })
  vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = p.red, bold = true })

  vim.g.colors_name = "hues"
end

return M
