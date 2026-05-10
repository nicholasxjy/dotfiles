local util = require("util")

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

local tiny_actions = {
  "enable",
  "disable",
  "toggle",
  "toggle_cursor_only",
  "toggle_all_diags_on_cursorline",
  "reset",
}

local function setup_tiny_inline_diagnostic()
  if not vim.g.tiny_inline_diagnostic_setup_done then
    pcall(vim.api.nvim_del_user_command, "TinyInlineDiag")
  end

  util.ensure_plugin("tiny-inline-diagnostic.nvim", function()
    require("tiny-inline-diagnostic").setup(tiny_opts)
    vim.g.tiny_inline_diagnostic_setup_done = true
  end, false)

  return require("tiny-inline-diagnostic")
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("TinyInlineDiagnosticDeferred", { clear = true }),
  once = true,
  callback = setup_tiny_inline_diagnostic,
})

vim.api.nvim_create_user_command("TinyInlineDiag", function(args)
  setup_tiny_inline_diagnostic()
  vim.cmd({ cmd = "TinyInlineDiag", args = args.fargs })
end, {
  nargs = 1,
  complete = function()
    return tiny_actions
  end,
  desc = "Control tiny-inline-diagnostic display",
})
