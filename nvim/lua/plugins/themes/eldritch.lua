return {
  {
    "nicholasxjy/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { italic = true },
        variables = {},
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = false, -- dims inactive windows, transparent must be false for this to work
      lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
      on_highlights = function(highlights, colors)
        highlights.WhichKeyBorder = { fg = colors.border_highlight, bg = colors.bg_float }
        highlights.WhichKeyDesc = { fg = colors.fg_dark, bold = false, italic = false }

        highlights.FzfLuaBorder = { fg = colors.border_highlight, bg = colors.bg_float }
        highlights.FzfLuaCursor = { bg = colors.orange, fg = colors.black }
        highlights.FzfLuaDirPart = { fg = colors.fg_dark }
        highlights.FzfLuaFilePart = { fg = colors.fg }
        highlights.FzfLuaFzfCursorLine = { bg = colors.bg_visual }
        highlights.FzfLuaFzfNormal = { fg = colors.fg }
        highlights.FzfLuaFzfPointer = { fg = colors.magenta2 }
        highlights.FzfLuaFzfSeparator = { fg = colors.orange, bg = colors.bg_float }
        highlights.FzfLuaHeaderBind = { fg = colors.blue }
        highlights.FzfLuaHeaderText = { fg = colors.blue, bold = true }
        highlights.FzfLuaNormal = { fg = colors.fg, bg = colors.bg_float }
        highlights.FzfLuaPath = { fg = colors.blue }
        highlights.FzfLuaPreviewTitle = { fg = colors.bright_green, bg = colors.bg_float }
        highlights.FzfLuaTitle = { fg = colors.bright_red, bg = colors.bg_float }

        highlights.TelescopeNormal = {
          bg = colors.bg_dark,
        }
        highlights.TelescopePromptBorder = {
          bg = colors.bg_dark,
          fg = colors.bg_dark,
        }
        highlights.TelescopePreviewBorder = {
          bg = colors.bg_dark,
          fg = colors.bg_dark,
        }
        highlights.TelescopeResultsBorder = {
          bg = colors.bg_dark,
          fg = colors.bg_dark,
        }
        highlights.TelescopePromptTitle = {
          bg = colors.red,
          fg = colors.bg_dark,
        }
        highlights.TelescopePreviewTitle = {
          bg = colors.yellow,
          fg = colors.bg_dark,
        }
        highlights.TelescopeResultsTitle = {
          bg = colors.green,
          fg = colors.bg_dark,
        }
        highlights["@type"] = { fg = "#E8B86D", bold = true }
        highlights["@tag"] = { bold = true }
        highlights["@tag.attribute"] = { italic = true, fg = "#82aaff" }
        highlights["lessClass"] = { italic = true, fg = colors.blue }
        highlights["@keyword.return"] = { fg = colors.bright_red }
        highlights["@variable.builtin"] = { italic = true, fg = "#ff007c" }
        highlights["@keyword.import"] = { italic = true, bold = true, fg = "#FF6500" }
        highlights["@keyword.export"] = { italic = true, bold = true, fg = "#FF6500" }
        highlights["@keyword.repeat"] = { italic = true, bold = true, fg = "#FF8E00" }
        highlights["@keyword.coroutine"] = { italic = true, bold = true, fg = "#B51B75" }
        highlights["@keyword.exception"] = { italic = true, bold = true, fg = "#F94C10" }
        highlights["@module"] = { fg = colors.bright_red }

        highlights["@lsp.type.parameter"] = { fg = colors.orange }
        highlights["@lsp.type.enum"] = { fg = "#0D7C66" }
        highlights["@lsp.type.enumMember"] = { fg = "#C08B5C" }
        highlights["@lsp.type.interface"] = { fg = "#9D5C0D" }

        highlights.DiagnosticUnnecessary = { fg = colors.fg_dark, undercurl = true }

        highlights.BlinkCmpDoc = { fg = colors.fg, bg = colors.bg_float }
        highlights.BlinkCmpDocBorder = { fg = colors.border_highlight, bg = colors.bg_float }

        highlights.BlinkCmpLabel = { fg = colors.fg_dark, bg = colors.none }
        highlights.BlinkCmpMenuSelection = { fg = colors.fg, bg = colors.selection }
        highlights.BlinkCmpLabelDeprecated = { fg = colors.fg_dark, bg = colors.none, strikethrough = true }

        highlights.BlinkCmpKindText = { fg = colors.green }
        highlights.BlinkCmpKindMethod = { fg = colors.blue }
        highlights.BlinkCmpKindFunction = { fg = colors.purple }
        highlights.BlinkCmpKindConstructor = { fg = colors.bright_red }
        highlights.BlinkCmpKindField = { fg = colors.green }
        highlights.BlinkCmpKindVariable = { fg = colors.cyan }
        highlights.BlinkCmpKindClass = { fg = colors.red }
        highlights.BlinkCmpKindInterface = { fg = colors.orange }
        highlights.BlinkCmpKindModule = { fg = colors.red }
        highlights.BlinkCmpKindProperty = { fg = colors.bright_purple }
        highlights.BlinkCmpKindUnit = { fg = colors.green }
        highlights.BlinkCmpKindValue = { fg = colors.pink }
        highlights.BlinkCmpKindEnum = { fg = colors.yellow }
        highlights.BlinkCmpKindKeyword = { fg = colors.bright_green }
        highlights.BlinkCmpKindSnippet = { fg = colors.pink }
        highlights.BlinkCmpKindColor = { fg = colors.red }
        highlights.BlinkCmpKindFile = { fg = colors.blue }
        highlights.BlinkCmpKindReference = { fg = colors.yellow }
        highlights.BlinkCmpKindFolder = { fg = colors.orange }
        highlights.BlinkCmpKindEnumMember = { fg = colors.teal }
        highlights.BlinkCmpKindConstant = { fg = colors.pink }
        highlights.BlinkCmpKindStruct = { fg = colors.teal }
        highlights.BlinkCmpKindEvent = { fg = colors.bright_cyan }
        highlights.BlinkCmpKindOperator = { fg = colors.bright_purple }
        highlights.BlinkCmpKindTypeParameter = { fg = colors.pink }
      end,
    },
  },
}
