local M = {}

function M.setup()
  local loader = require("loader")
  loader.packadd("mini.hues")

  require("mini.hues").setup({
    -- REQUIRED base colors as '#rrggbb' hex strings
    background = "#303446",
    foreground = "#eee7dc",

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

  vim.g.colors_name = "hues"
end

return M
