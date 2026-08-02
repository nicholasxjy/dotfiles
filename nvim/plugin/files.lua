-- File explorers and filesystem navigation.
local plugin_dir = vim.fn.stdpath("config") .. "/plugin/files"

for _, file in ipairs({ "oil.lua", "yazi.lua" }) do
  dofile(plugin_dir .. "/" .. file)
end
