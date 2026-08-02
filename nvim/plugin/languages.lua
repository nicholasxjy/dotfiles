-- Filetype-specific language tooling.
local plugin_dir = vim.fn.stdpath("config") .. "/plugin/languages"

for _, file in ipairs({ "markdown.lua", "rust.lua" }) do
  dofile(plugin_dir .. "/" .. file)
end
