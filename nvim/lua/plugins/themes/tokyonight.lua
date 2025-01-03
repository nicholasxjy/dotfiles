return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",
      transparent = false,
      terminal_colors = false,
      styles = {
        comments = { italic = true },
        sidebars = "dark",
        floats = "dark",
      },
      plugins = {
        all = true,
        auto = true,
      },
      on_colors = function(colors)
        colors.bg_dark = "#171928"
        colors.bg = "#212337"
        colors.bg_highlight = "#292e42"
        colors.terminal_black = "#414868"
        colors.fg = "#ebfafa"
        colors.fg_dark = "#ABB4DA"
        colors.fg_gutter = "#3b4261"
        colors.cyan = "#04d1f9"
        colors.magenta = "#bf4f8e"
        colors.magenta2 = "#722f55"
        colors.pink = "#f265b5"
        colors.purple = "#a48cf2"
        colors.orange = "#f7c67f"
        colors.yellow = "#f1fc79"
        colors.red = "#f16c75"
        colors.red1 = "#f0313e"
        colors.green = "#37f499"
        colors.green1 = "#0A97B0"
        colors.green2 = "#1F4529"
      end,
      on_highlights = function(highlights, colors)
        local prompt = colors.bg_highlight

        highlights.TelescopeNormal = {
          bg = prompt,
          fg = colors.fg,
        }
        highlights.TelescopePromptNormal = {
          bg = prompt,
        }
        highlights.TelescopeBorder = {
          bg = prompt,
          fg = prompt,
        }
        highlights.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        highlights.TelescopePromptTitle = {
          bg = colors.red,
          fg = colors.bg_dark,
        }
        highlights.TelescopePreviewTitle = {
          bg = colors.cyan,
          fg = colors.bg_dark,
        }
        highlights.TelescopeResultsTitle = {
          bg = colors.green,
          fg = colors.bg_dark,
        }
        -- highlights["@type"] = { fg = "#FF7EE2", bold = true }
        highlights["@tag"] = { bold = true }
        highlights["lessClass"] = { italic = true, fg = colors.cyan }
        -- highlights["@tag.attribute"] = { italic = true, fg = colors.blue5 }
        -- highlights["@keyword.return"] = { fg = "#FF6ABC" }
        -- highlights["@variable.builtin"] = { italic = true, fg = "#F02b77" }
        -- highlights["@constructor"] = { fg = "#E06c75" }
        highlights["@keyword.import"] = { italic = true, fg = colors.red }
        highlights["@keyword.export"] = { italic = true, fg = colors.red }
        --
        -- highlights["@keyword.repeat"] = { italic = true, bold = true, fg = "#FF8E00" }
        -- highlights["@keyword.coroutine"] = { italic = true, bold = true, fg = "#B51B75" }
        -- highlights["@keyword.exception"] = { italic = true, bold = true, fg = "#F94C10" }
        -- highlights["@module"] = { fg = "#E06c75" }

        highlights["@lsp.type.enum"] = { fg = "#0D7C66" }
        highlights["@lsp.type.enumMember"] = { fg = "#C08B5C" }
        highlights["@lsp.type.interface"] = { fg = "#9D5C0D" }
        highlights["@lsp.type.property"] = { fg = colors.blue }
      end,
    },
    -- init = function()
    --   vim.cmd("colorscheme tokyonight")
    -- end,
  },
}
