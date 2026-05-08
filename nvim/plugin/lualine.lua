local util = require("util")

util.later(function()
  require("lualine").setup({
    options = {
      theme = "auto",
      section_separators = { left = "", right = "" },
      component_separators = { left = "│", right = "│" },
      -- section_separators = { left = "", right = "" },
      globalstatus = true,
      refresh = {
        statusline = 100,
      },
    },
    sections = {
      lualine_a = {
        { "fancy_mode", width = 3 },
      },
      lualine_b = {
        { "fancy_branch" },
        { "fancy_cwd", substitute_home = true },
        { "fancy_macro" },
      },
      lualine_c = {
        { "fancy_diff" },
        { "fancy_diagnostics" },
      },
      lualine_x = {
        { "fancy_lsp_servers" },
      },
      lualine_y = {
        { "fancy_searchcount" },
      },
      lualine_z = {
        { "fancy_filetype", ts_icon = "" },
        { "fancy_location" },
      },
    },
  })
end, 20, "VimEnter", true)
