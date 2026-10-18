local loader = require("loader")

local M = {}

local function link_snacks_highlights()
  local p = require("mini.hues").get_palette()
  local links = {
    SnacksPicker = "FzfLuaNormal",
    SnacksPickerBorder = "FzfLuaBorder",
    SnacksPickerTitle = "FzfLuaTitle",
    SnacksPickerFooter = "FzfLuaTitle",
    SnacksPickerCursorLine = "FzfLuaCursorLine",
    SnacksPickerInput = "FzfLuaFzfQuery",
    SnacksPickerInputBorder = "FzfLuaBorder",
    SnacksPickerInputTitle = "FzfLuaTitle",
    SnacksPickerInputFooter = "FzfLuaTitle",
    SnacksPickerInputCursorLine = "FzfLuaCursorLine",
    SnacksPickerList = "FzfLuaFzfNormal",
    SnacksPickerListBorder = "FzfLuaBorder",
    SnacksPickerListTitle = "FzfLuaTitle",
    SnacksPickerListFooter = "FzfLuaTitle",
    SnacksPickerListCursorLine = "FzfLuaFzfCursorLine",
    SnacksPickerPreview = "FzfLuaPreviewNormal",
    SnacksPickerPreviewBorder = "FzfLuaPreviewBorder",
    SnacksPickerPreviewTitle = "FzfLuaPreviewTitle",
    SnacksPickerPreviewFooter = "FzfLuaPreviewTitle",
    SnacksPickerPreviewCursorLine = "FzfLuaCursorLine",
    SnacksPickerMatch = "FzfLuaFzfMatch",
    SnacksPickerSearch = "FzfLuaSearch",
    SnacksPickerPrompt = "FzfLuaFzfPrompt",
    SnacksPickerInputSearch = "FzfLuaFzfQuery",
    SnacksPickerSelected = "FzfLuaFzfMarker",
    SnacksPickerUnselected = "FzfLuaFzfGutter",
    SnacksPickerSpinner = "FzfLuaFzfSpinner",
    SnacksPickerTotals = "FzfLuaFzfInfo",
    SnacksPickerFile = "FzfLuaFilePart",
    SnacksPickerDirectory = "FzfLuaDirIcon",
    SnacksPickerDir = "FzfLuaDirPart",
    SnacksPickerPathHidden = "FzfLuaDirPart",
    SnacksPickerPathIgnored = "FzfLuaDirPart",
    SnacksPickerTree = "FzfLuaDirPart",
    SnacksPickerRow = "FzfLuaPathLineNr",
    SnacksPickerCol = "FzfLuaPathColNr",
    SnacksPickerBufNr = "FzfLuaBufNr",
    SnacksPickerCmd = "FzfLuaCmdEx",
    SnacksPickerCmdBuiltin = "FzfLuaCmdEx",
  }

  for group, target in pairs(links) do
    vim.api.nvim_set_hl(0, group, { link = target })
  end

  vim.api.nvim_set_hl(0, "PmenuSel", { fg = nil, bg = p.bg_mid, reverse = false })
end

function M.setup()
  loader.packadd("mini.hues")

  -- Apply after the theme so Snacks' default highlights respect these links on lazy load.
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("sjvim_mini_hues_highlights", { clear = true }),
    pattern = "randomhue",
    callback = link_snacks_highlights,
  })

  -- vim.o.background = "light"
  vim.cmd.colorscheme("randomhue")
end

return M
