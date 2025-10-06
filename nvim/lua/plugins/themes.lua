local colorUtil = require("utils.color")

return {
  {
    "nicholasxjy/bamboo.nvim",
    lazy = false,
    branch = "dev",
    priority = 1000,
    config = function()
      local float_border_color = "#3B38A0"
      local float_title_fg = "#D92C54"
      local match_fg = "#e55285"
      local bg0 = "#222436"
      local normal_bg = vim.g.transparent and "none" or bg0
      local dim_bg = vim.g.transparent and normal_bg or colorUtil.darken("#161c2d", 0.25)
      local float_border_fg = vim.g.transparent and float_border_color or normal_bg

      require("bamboo").setup({
        style = "yorumi",
        toggle_style_key = nil,
        transparent = vim.g.transparent,
        dim_inactive = false,
        term_colors = true,
        ending_tildes = true,
        cmp_itemkind_reverse = false,
        code_style = {
          comments = { italic = true },
          conditionals = { italic = true, bold = true },
          keywords = { italic = false, bold = false },
          functions = {},
          namespaces = { italic = false },
          parameters = { italic = true },
          strings = {},
          variables = {},
        },
        lualine = {
          transparent = true,
        },
        highlights = {
          CursorLine = { bg = "#2f447f" },
          FloatTitle = { fg = float_title_fg, fmt = "bold" },
          NormalFloat = { bg = dim_bg, fg = "$fg" },
          FloatBorder = { bg = dim_bg, fg = float_border_fg },
          PmenuSel = { bg = "#2f2a7a", fg = "NONE", fmt = "bold" }, --"#2f447f" -- "#503240"
          Slimline = { bg = "NONE", fg = "$fg" },
          StatusLine = { bg = "NONE" },
          SnacksPickerBorder = { fg = float_border_fg, bg = normal_bg },
          SnacksPickerList = { bg = normal_bg },
          SnacksPickerTitle = { link = "FloatTitle" },
          SnacksPickerPreview = { bg = normal_bg },
          SnacksPickerPreviewTitle = { fg = "$cyan", fmt = "bold" },
          SnacksPickerInput = { bg = normal_bg, fg = "$fg" },
          SnacksPickerMatch = { fg = match_fg, fmt = "bold" },
          SnacksPickerCursorLine = { link = "PmenuSel" },
          SnacksPickerListCursorLine = { link = "PmenuSel" },
          SnacksPickerDir = { fg = "$grey", fmt = "italic" },
          FzfLuaTitle = { link = "FloatTitle" },
          FzfLuaPreviewTitle = { link = "SnacksPickerPreviewTitle" },
          FzfLuaCursorLine = { link = "PmenuSel" },
          BlinkCmpLabelMatch = { fg = match_fg, fmt = "bold" },
          LspInlayHint = { fg = "$grey", fmt = "italic" },
        },
        diagnostics = {
          darker = false,
          undercurl = true,
          background = true,
        },
      })
    end,
  },
}
