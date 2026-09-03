local M = {}

function M.setup()
  local loader = require("loader")
  loader.packadd("mini.hues")

  require("mini.hues").setup({
    -- REQUIRED base colors as '#rrggbb' hex strings
    background = "#24283b",
    foreground = "#eee7dc",

    -- Number of hues used for non-base colors (0 to 8)
    n_hues = 8,

    -- Saturation. One of 'low', 'lowmedium', 'medium', 'mediumhigh', 'high'.
    saturation = "medium",

    -- Accent color. One of: 'bg', 'fg', 'red', 'orange', 'yellow', 'green',
    -- 'cyan', 'azure', 'blue', 'purple'
    accent = "bg",

    -- Plugin integrations. Use `default = false` to disable all integrations.
    -- Also can be set per plugin (see |MiniHues.config|).
    plugins = { default = true },

    -- Whether to auto adjust highlight groups based on certain events
    autoadjust = true,
  })

  vim.g.colors_name = "hues"
end

return M
