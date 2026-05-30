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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("TinyInlineDiagnosticDeferred", { clear = true }),
  once = true,
  callback = function()
    require("tiny-inline-diagnostic").setup(tiny_opts)
  end,
})
