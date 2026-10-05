local loader = require("loader")

local M = {}

function M.setup()
  loader.packadd("cyberdream.nvim")

  require("cyberdream").setup({
    transparent = true,
    italic_comments = true,
    overrides = function(colors)
      return {
        WinBar = { fg = colors.fg, bg = "NONE" },
        FzfLuaDirPart = { fg = colors.grey, bold = true },
        ZedBarFile = { fg = colors.grey, bold = true },
        ["@keyword.import"] = { fg = colors.cyan, italic = true },
        ["@keyword.export"] = { link = "@keyword.import" },
        ["@tag.tsx"] = { fg = colors.red, bold = true },
        ["@tag.attribute"] = { fg = colors.blue, italic = true },
      }
    end,
  })

  vim.cmd.colorscheme("cyberdream")
end

return M
