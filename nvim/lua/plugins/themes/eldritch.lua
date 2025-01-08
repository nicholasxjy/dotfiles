return {
  {
    "eldritch-theme/eldritch.nvim",
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
      on_colors = function(colors)
        colors.green = "#C5FF95"
      end,
      on_highlights = function(highlights, colors)
        highlights.WhichKeyBorder = { fg = colors.border_highlight, bg = colors.bg_float }
        highlights.WhichKeyDesc = { fg = colors.fg_dark, bold = false, italic = false }

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
        highlights["@type"] = { fg = "#FFBF00", bold = true }
        highlights["@tag"] = { bold = true }
        highlights["@tag.attribute"] = { italic = true, fg = "#7AB2B2" }
        highlights["lessClass"] = { italic = true, fg = colors.blue }
        highlights["@keyword.return"] = { fg = colors.bright_red }
        highlights["@variable.builtin"] = { italic = true, fg = "#ff007c" }
        highlights["@keyword.import"] = { italic = true, bold = true, fg = "#FF6500" }
        highlights["@keyword.export"] = { italic = true, bold = true, fg = "#FF6500" }
        -- highlights["@keyword.repeat"] = { italic = true, bold = true, fg = "#FF8E00" }
        -- highlights["@keyword.coroutine"] = { italic = true, bold = true, fg = "#B51B75" }
        -- highlights["@keyword.exception"] = { italic = true, bold = true, fg = "#F94C10" }
        highlights["@module"] = { fg = colors.bright_red }
        highlights["@lsp.type.enum"] = { fg = "#677D6A" }
        highlights["@lsp.type.enumMember"] = { fg = "#C08B5C" }
        highlights["@lsp.type.interface"] = { fg = "#9D5C0D" }

        highlights.DiagnosticUnnecessary = { fg = colors.fg_dark, undercurl = true }
      end,
    },
  },
}
