-- Syntax, structure, and code navigation plugins.
local plugin_dir = vim.fn.stdpath("config") .. "/plugin/coding"

for _, file in ipairs({
  "nvim-ts-autotag.lua",
  "illuminate.lua",
  "matchup.lua",
  "origami.lua",
  "rainbow-tags.lua",
  "treesitter.lua",
  "zed-bar.lua",
}) do
  dofile(plugin_dir .. "/" .. file)
end
