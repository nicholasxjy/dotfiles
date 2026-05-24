vim.fn.setenv("ENABLE_WASMTIME", "ON")

pcall(function()
  require("vim._core.ui2").enable({})
end)

if vim.fn.executable("go") == 1 and vim.env.GOROOT and vim.env.GOROOT ~= "" then
  local result = vim.system({ "env", "-u", "GOROOT", "go", "env", "GOROOT" }, { text = true }):wait()
  local detected_goroot = result.code == 0 and vim.trim(result.stdout) or ""
  if detected_goroot ~= "" and detected_goroot ~= vim.env.GOROOT then
    vim.env.GOROOT = detected_goroot
  end
end

require("options")
require("keymaps")
require("autocmds")

require("pack")
require("lsp")

vim.cmd.colorscheme("randomhue")
