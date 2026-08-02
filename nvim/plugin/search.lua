-- Search and find-and-replace tools.
local plugin_dir = vim.fn.stdpath("config") .. "/plugin/search"

for _, file in ipairs({ "fzf.lua", "grug-far.lua" }) do
  dofile(plugin_dir .. "/" .. file)
end
