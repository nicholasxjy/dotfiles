-- Formatting, linting, diagnostics, and external tool installation.
local plugin_dir = vim.fn.stdpath("config") .. "/plugin/tooling"

for _, file in ipairs({ "conform.lua", "lint.lua", "mason.lua", "tiny-inline-diagnostic.lua" }) do
  dofile(plugin_dir .. "/" .. file)
end
