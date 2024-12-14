return {
  {
    "maxmx03/fluoromachine.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local hl = require("fluoromachine.utils").set_hl
      require("fluoromachine").setup({
        glow = true,
        brightness = 0.06,
        theme = "retrowave",
        transparent = false,
        styles = {},
        overrides = function(c, color)
          local darken = color.darken
          local lighten = color.lighten
          local shade = color.shade
          return {
            TelescopeResultsBorder = { fg = c.bgdark, bg = c.bgdark },
            TelescopeResultsNormal = { bg = c.bgdark },
            TelescopePreviewNormal = { bg = c.bgdark },
            TelescopePreviewBorder = { fg = c.bgdark, bg = c.bgdark },
            TelescopePromptBorder = { fg = c.bgdark, bg = c.bgdark },
            TelescopeTitle = { fg = c.red, bg = shade(c.red, 5) },
            TelescopePreviewTitle = { fg = c.yellow, bg = shade(c.yellow, 5) },
            TelescopeResultsTitle = { fg = c.green, bg = shade(c.green, 5) },
            TelescopePromptPrefix = { fg = c.purple },

            WhichKeyBorder = { fg = darken(c.cyan, 30), bg = c.bgdark },
            WhichKeyDesc = { fg = c.fg, bold = false, italic = false },

            FzfLuaBorder = { fg = c.editor.separator, bg = c.bgdark },
            FzfLuaFzfNormal = { fg = c.fg },
            FzfLuaFzfPointer = { fg = c.yellow },
            FzfLuaNormal = { fg = c.fg, bg = c.bgdark },
            FzfLuaPreviewTitle = { fg = c.green, bg = shade(c.green, 5) },
            FzfLuaTitle = { fg = c.red, bg = shade(c.red, 5) },

            FzfLuaCursor = { fg = c.orange, bg = shade(c.orange, 5) },
            FzfLuaDirPart = { fg = darken(c.fg, 30) },
            FzfLuaFilePart = { fg = c.fg },
            FzfLuaFzfCursorLine = { bg = c.editor.selection },
            FzfLuaFzfSeparator = { fg = c.orange, bg = shade(c.orange, 5) },
            FzfLuaHeaderBind = { fg = c.cyan },
            FzfLuaHeaderText = { fg = c.cyan, bold = true },

            ["@tag"] = { bold = true },
            ["@type"] = { bold = true },
            ["@function"] = { italic = true },
            ["@function.call"] = { italic = true },
            ["@comment"] = { italic = true },
            hl("@tag.attribute", { italic = true, bold = false }, { glow = false }),
            hl("@keyword.return", { fg = darken(c.pink, 30), italic = true, bold = true }, { glow = true }),
            hl("@variable.builtin", { italic = true, fg = lighten(c.red, 50) }, { glow = true }),
            hl("@keyword.import", { italic = true, bold = true, fg = "#13C3F7" }, { glow = true }),
            hl("@keyword.export", { italic = true, bold = true, fg = "#13C3F7" }, { glow = true }),
            hl("@keyword.conditional", { fg = "#F637EC", italic = true, bold = false }, { glow = false }),
            hl("@lsp.mod.controlFlow", { fg = "#F637EC", italic = true, bold = false }, { glow = false }),
            hl("@keyword.repeat", { italic = true, bold = false, fg = "#FF8E00" }, { glow = false }),
            hl("@keyword.coroutine", { italic = true, bold = false, fg = "#B51B75" }, { glow = false }),
            hl("@lsp.typemod.keyword.async", { italic = true, bold = false, fg = "#B51B75" }, { glow = false }),
            hl("@keyword.exception", { italic = true, bold = false, fg = "#F94C10" }, { glow = false }),
            hl("@module", { fg = darken(c.red, 20), italic = true, bold = false }, { glow = true }),
            hl("@lsp.type.namespace", { fg = darken(c.red, 20), italic = true, bold = false }, { glow = true }),
            hl("@lsp.typemod.function", { fg = c.yellow, bold = true }, { glow = true }),

            hl("@lsp.type.enum", { fg = "#257180" }, { glow = false }),
            hl("@lsp.type.enumMember", { fg = "#C08B5C" }, { glow = true }),
            hl("@lsp.type.interface", { fg = "#9D5C0D" }, { glow = true }),

            BlinkCmpDoc = { fg = c.fg, bg = c.bgdark },
            BlinkCmpDocBorder = { fg = c.editor.separator, bg = c.bgdark },

            BlinkCmpLabel = { fg = c.fg, bg = c.bg },
            BlinkCmpMenuSelection = { fg = c.yellow, bg = c.editor.selection },
            BlinkCmpLabelDeprecated = { fg = c.comment, strikethrough = true },

            BlinkCmpKindText = { fg = c.orange },
            BlinkCmpKindMethod = { fg = c.yellow },
            BlinkCmpKindFunction = { fg = c.purple },
            BlinkCmpKindConstructor = { fg = lighten(c.red, 50) },
            BlinkCmpKindField = { fg = c.green },
            BlinkCmpKindVariable = { fg = darken(c.cyan, 30) },
            BlinkCmpKindClass = { fg = darken(c.red, 30) },
            BlinkCmpKindInterface = { fg = c.pink },
            BlinkCmpKindModule = { fg = c.red },
            BlinkCmpKindProperty = { fg = lighten(c.green, 50) },
            BlinkCmpKindUnit = { fg = c.green },
            BlinkCmpKindValue = { fg = c.pink },
            BlinkCmpKindEnum = { fg = c.orange },
            BlinkCmpKindKeyword = { fg = lighten(c.green, 50) },
            BlinkCmpKindSnippet = { fg = c.pink },
            BlinkCmpKindColor = { fg = c.red },
            BlinkCmpKindFile = { fg = c.cyan },
            BlinkCmpKindReference = { fg = c.yellow },
            BlinkCmpKindFolder = { fg = c.orange },
            BlinkCmpKindEnumMember = { fg = c.green },
            BlinkCmpKindConstant = { fg = c.red },
            BlinkCmpKindStruct = { fg = c.red },
            BlinkCmpKindEvent = { fg = lighten(c.cyan, 50) },
            BlinkCmpKindOperator = { fg = lighten(c.purple, 50) },
            BlinkCmpKindTypeParameter = { fg = c.pink },
          }
        end,
      })
      vim.cmd("colorscheme fluoromachine")
    end,
  },
}
