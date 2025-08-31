local colorUtil = require("utils.color")
return {
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    config = function()
      local c = {
        none = "none",
        inverse = "#f7eaf5",
        contrast = "#0e0e0e",
        bg0 = "#222831",
        bg1 = "#2f312c",
        bg2 = "#383b35",
        bg3 = "#3a3d37",
        bg_d = "#35374B",
        bg_blue = "#68aee8",
        bg_yellow = "#dbb651",
        fg = "#f1e9d2",
        purple = "#aaaaff",
        bright_purple = "#df73ff",
        green = "#2cf392",
        orange = "#b581b0",
        blue = "#94ffff",
        light_blue = "#ccffff",
        yellow = "#FFE893", --"#dbb651",
        cyan = "#00d4f8",
        red = "#e7477e",
        coral = "#bb595c",
        grey = "#5b5e5a",
        light_grey = "#838781",
      }
      local normal_bg = vim.g.transparent and c.none or c.bg0
      local dim_bg = vim.g.transparent and normal_bg or colorUtil.darken(c.bg0, 0.25)
      local float_border_fg = vim.g.transparent and c.red or dim_bg

      local rainblend = 0.25
      local rainbows = {
        red = colorUtil.blend(c.red, c.inverse, rainblend),
        orange = colorUtil.blend(c.orange, c.inverse, rainblend),
        yellow = colorUtil.blend(c.yellow, c.inverse, rainblend),
        green = colorUtil.blend(c.green, c.inverse, rainblend),
        cyan = colorUtil.blend(c.cyan, c.inverse, rainblend),
        blue = colorUtil.blend(c.blue, c.inverse, rainblend),
        purple = colorUtil.blend(c.purple, c.inverse, rainblend),
      }

      require("bamboo").setup({
        style = "multiplex", -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
        toggle_style_key = nil, -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
        toggle_style_list = { "vulgaris", "multiplex", "light" }, -- List of styles to toggle between
        transparent = vim.g.transparent, -- Show/hide background
        dim_inactive = false, -- Dim inactive windows/buffers
        term_colors = true, -- Change terminal color as per the selected theme style
        ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
        code_style = {
          comments = { italic = true },
          conditionals = { italic = true, bold = true },
          keywords = { italic = false, bold = true },
          functions = {},
          namespaces = { italic = false },
          parameters = { italic = true },
          strings = {},
          variables = {},
        },
        lualine = {
          transparent = true,
        },
        colors = c,
        highlights = {
          TreesitterContext = { bg = "$bg_d" },
          FloatTitle = { fg = "$yellow" },
          NormalFloat = { bg = dim_bg, fg = "$fg" },
          FloatBorder = { bg = dim_bg, fg = float_border_fg },

          SnacksNormal = { link = "Normal" },
          SnacksNormalNC = { link = "NormalNC" },
          SnacksBackdrop = { bg = dim_bg },
          SnacksPickerBorder = { fg = dim_bg, bg = dim_bg },
          Comment = { fg = "#3a3a3a", fmt = "italic" },
          LspInlayHint = { fg = "#34392D", bg = "NONE", fmt = "italic" },
          Slimline = { bg = "NONE", fg = "$fg" },
          PmenuSel = { bg = "#2f2a7a", fg = "NONE" },
          FzfLuaCursorLine = { link = "PmenuSel" },
          SnacksPickerCursorLine = { link = "PmenuSel" },
          SnacksPickerListCursorLine = { link = "PmenuSel" },
          ["@tag.builtin"] = { fg = "#61A3BA" },
          ["@tag.tsx"] = { fg = "#dbb651", fmt = "bold" },
          ["@operator"] = { fg = "#685742", fmt = "bold" },
          ["@tag.attribute"] = { fg = "#f7eaf5", fmt = "italic" },
          ["@comment"] = { fg = "#4f5172", fmt = "italic" },
          ["@type"] = { fg = "$yellow", fmt = "bold" },
          ["@attribute"] = { fg = "#94aef9" },
          ["@keyword.import"] = { fg = "#6FE6FC", fmt = "bold" },
          ["@keyword.export"] = { fg = "#6FE6FC", fmt = "bold" },
          ["@keyword.return"] = { fg = "#d8647e", fmt = "italic,bold" },
          ["@keyword.coroutine"] = { fg = "#e482ff", fmt = "italic" },
          ["@keyword.exception"] = { fg = "#e482ff", fmt = "italic" },
          ["@keyword.modifier"] = { fg = "#bb9dbd", fmt = "italic,bold" },
          ["@lsp.type.modifier"] = { fg = "#bb9dbd", fmt = "italic,bold" },
          ["@type.builtin"] = { fg = "#ff7eda" },
          ["@lsp.type.enum"] = { fg = "#31a6a5" },
          ["@lsp.typemod.enum"] = { fg = "#31a6a5" },
          ["@lsp.type.enumMember"] = { fg = "#0089ff", fmt = "bold" },
          ["@lsp.typemod.enumMember"] = { fg = "#0089ff", fmt = "bold" },
          ["@lsp.type.interface"] = { fg = "#A06A2C", fmt = "bold" },
          ["@lsp.type.namespace"] = { fg = "#88a4f7" },
          ["@lsp.mod.readonly"] = { fg = "#fee1fb" },

          ["BlinkPairsGreen"] = { fg = rainbows.green },
          ["BlinkPairsRed"] = { fg = rainbows.red },
          ["BlinkPairsOrange"] = { fg = rainbows.orange },
          ["BlinkPairsYellow"] = { fg = rainbows.yellow },
          ["BlinkPairsCyan"] = { fg = rainbows.cyan },
          ["BlinkPairsBlue"] = { fg = rainbows.blue },
          ["BlinkPairsViolet"] = { fg = rainbows.purple },

          ["BlinkIndentGreen"] = { fg = rainbows.green },
          ["BlinkIndentRed"] = { fg = rainbows.red },
          ["BlinkIndentOrange"] = { fg = rainbows.orange },
          ["BlinkIndentYellow"] = { fg = rainbows.yellow },
          ["BlinkIndentCyan"] = { fg = rainbows.cyan },
          ["BlinkIndentBlue"] = { fg = rainbows.blue },
          ["BlinkIndentViolet"] = { fg = rainbows.purple },
        },

        diagnostics = {
          darker = true,
          undercurl = true,
          background = true,
        },
      })
    end,
  },
  {
    "oonamo/ef-themes.nvim",
    opts = {
      light = "ef-spring",
      dark = "ef-winter",
      transparent = true,
      styles = {
        comments = { italic = true },
        keywords = { bold = true, italic = true },
        functions = {},
        variables = {},
        classes = { bold = true },
        types = { bold = true, italic = false },
        diagnostic = "full",
        pickers = "borderless",
      },

      modules = {
        blink = true,
        fzf = true,
        mini = true,
        semantic_tokens = true,
        snacks = true,
        treesitter = true,
        gitsigns = true,
        render_markdown = true,
      },
      on_colors = function(colors, name)
        colors.bg_main = "NONE"
        colors.bg_dim = "NONE"
        colors.bg_inactive = "NONE"

        -- colors.green_cooler = "#00d4f8"
        -- colors.magenta_warmer = "#b581b0"
        -- colors.magenta_cooler = "#e482ff"
        -- colors.cyan_cooler = "#94ffff"
        -- colors.yellow = "#d6a477"
      end,
      on_highlights = function(highlights, colors, name)
        local custom_hls = {
          Slimline = { bg = "NONE", fg = colors.fg_dim },
          StatusLine = { bg = "NONE" },
          MatchParen = { bold = true, bg = colors.bg_paren },
          LspInlayHint = { fg = "#34392D", bg = "NONE" },

          ["@keyword.import"] = { fg = "#FFE893", bold = true },
          ["@keyword.export"] = { fg = "#FFE893", bold = true },
          ["@keyword.return"] = { fg = "#d8647e", bold = true, italic = true },
          ["@keyword.coroutine"] = { fg = "#e482ff" },
          ["@keyword.exception"] = { fg = "#e482ff" },
          ["@punctuation.delimiter"] = { fg = colors.fg_dim, italic = false },
          ["@operator"] = { fg = "#f1e5f0", italic = false, bold = true },
          ["@attribute"] = { fg = "#94aef9" },
          ["@tag.attribute"] = { fg = "#b8cfe6", italic = true },
          ["@type.builtin"] = { fg = "#ff7eda" },
          ["@keyword.modifier"] = { fg = "#fee1fb", bold = true, italic = true },

          ["@lsp.type.enum"] = { fg = "#31a6a5", bold = true },
          ["@lsp.type.enumMember"] = { fg = "#0089ff", italic = true, bold = true },
          ["@lsp.type.modifier"] = { fg = "#fee1fb", bold = true, italic = false },
          ["@lsp.type.interface"] = { fg = "#A06A2C", bold = true, italic = false },
          ["@lsp.typemod.type.defaultLibrary"] = { link = "@type.builtin" },
        }
        custom_hls["BlinkPairsRed"] = { fg = colors.rainbow_1 }
        custom_hls["BlinkPairsOrange"] = { fg = colors.rainbow_2 }
        custom_hls["BlinkPairsYellow"] = { fg = colors.rainbow_3 }
        custom_hls["BlinkPairsGreen"] = { fg = colors.rainbow_4 }
        custom_hls["BlinkPairsCyan"] = { fg = colors.rainbow_5 }
        custom_hls["BlinkPairsBlue"] = { fg = colors.rainbow_6 }
        custom_hls["BlinkPairsViolet"] = { fg = colors.rainbow_7 }

        custom_hls["BlinkIndentRed"] = { fg = colors.rainbow_1 }
        custom_hls["BlinkIndentOrange"] = { fg = colors.rainbow_2 }
        custom_hls["BlinkIndentYellow"] = { fg = colors.rainbow_3 }
        custom_hls["BlinkIndentGreen"] = { fg = colors.rainbow_4 }
        custom_hls["BlinkIndentCyan"] = { fg = colors.rainbow_5 }
        custom_hls["BlinkIndentBlue"] = { fg = colors.rainbow_6 }
        custom_hls["BlinkIndentViolet"] = { fg = colors.rainbow_7 }
        return custom_hls
      end,
    },
  },
}
