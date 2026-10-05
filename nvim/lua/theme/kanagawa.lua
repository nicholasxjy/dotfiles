local loader = require("loader")

local M = {}

---@param style? string "wave" | "dragon" | "lotus"
function M.setup(style)
  style = style or "wave"
  loader.packadd("kanagawa.nvim")

  require("kanagawa").setup({
    theme = style,
    transparent = false,
    overrides = function(colors)
      local theme = colors.theme
      return {
        FzfLuaDirPart = { fg = theme.ui.nontext, bold = false },
        ZedBarFile = { fg = theme.ui.nontext, bold = true },
        ["@keyword.import"] = { fg = theme.syn.type, italic = true },
        ["@keyword.export"] = { link = "@keyword.import" },
        ["@tag.tsx"] = { fg = theme.syn.preproc, bold = true },
        ["@tag.attribute"] = { fg = theme.syn.fun, italic = true },
      }
    end,
  })

  vim.cmd.colorscheme("kanagawa-" .. style)
end

return M
