vim.pack.add({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" }, { load = false })

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

local loaded = false

local function load_tiny_inline_diagnostic()
  if loaded then
    return require("tiny-inline-diagnostic")
  end

  vim.cmd.packadd("tiny-inline-diagnostic.nvim")

  local tiny_inline_diagnostic = require("tiny-inline-diagnostic")
  tiny_inline_diagnostic.setup(tiny_opts)

  loaded = true

  return tiny_inline_diagnostic
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("TinyInlineDiagnosticDeferred", { clear = true }),
  once = true,
  callback = function()
    load_tiny_inline_diagnostic()
  end,
})
