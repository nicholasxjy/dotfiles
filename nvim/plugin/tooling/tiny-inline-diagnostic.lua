local loader = require("loader")

local setup = function()
  loader.packadd("tiny-inline-diagnostic.nvim")

  local tiny_opts = {
    preset = "modern",
    transparent_bg = false,
    transparent_cursorline = true,
    signs = {
      vertical = " │",
      vertical_end = " └",
    },
    blend = {
      factor = 0.1,
    },
    options = {
      show_source = {
        enabled = true,
        if_many = true,
      },
      add_messages = {
        display_count = true,
      },
      set_arrow_to_diag_color = true,
      multilines = {
        enabled = true,
        always_show = true,
      },
      show_all_diags_on_cursorline = true,
      enable_on_insert = false,
      enable_on_select = false,
    },
  }

  require("tiny-inline-diagnostic").setup(tiny_opts)

  -- setup() registers the plugin's LspAttach handler after this event has
  -- started, so replay it for buffers that already have a client.
  for _, client in ipairs(vim.lsp.get_clients()) do
    for bufnr in pairs(client.attached_buffers) do
      vim.api.nvim_exec_autocmds("LspAttach", {
        group = "TinyInlineDiagnosticAutocmds",
        buffer = bufnr,
        data = { client_id = client.id },
        modeline = false,
      })
    end
  end
end

loader.defer("tiny-inline-diagnostic", setup, "LspAttach")
