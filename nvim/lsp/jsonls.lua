local lsp_util = require("lsp_util")

return {
  cmd = function(dispatchers, config)
    local cmd = "vscode-json-language-server"
    if (config or {}).root_dir then
      local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", cmd)
      if vim.fn.executable(local_cmd) == 1 then
        cmd = local_cmd
      end
    end
    return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers)
  end,
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { ".git" },
  settings = {},
  -- Keep the generated catalog out of memory until jsonls actually starts.
  before_init = lsp_util.add_schemastore("json"),
}
