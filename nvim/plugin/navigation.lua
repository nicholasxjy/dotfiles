-- Motions, multiple cursors, and split navigation.
local plugin_dir = vim.fn.stdpath("config") .. "/plugin/navigation"

for _, file in ipairs({ "flash.lua", "herdr-splits.lua", "multicursor.lua", "smart-splits.lua" }) do
  dofile(plugin_dir .. "/" .. file)
end
