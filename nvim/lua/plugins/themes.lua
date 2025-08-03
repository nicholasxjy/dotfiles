return {
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    config = function()
      require("bamboo").setup({
        style = "multiplex", -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
        toggle_style_key = nil, -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
        toggle_style_list = { "vulgaris", "multiplex", "light" }, -- List of styles to toggle between
        transparent = false, -- Show/hide background
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
          parameters = { italic = false },
          strings = {},
          variables = {},
        },

        lualine = {
          transparent = false,
        },

        colors = {
          bg0 = "#222236",
          bg1 = "#262640",
          bg_d = "#041F24",
        },
        highlights = {
          NormalFloat = { fg = "$fg", bg = "$bg1" },
          FloatBorder = { fg = "$bg1", bg = "$bg1" },

          PmenuSel = { bg = "$bg_d" },
          Comment = { fg = "#4f5172", italic = true },
          LspInlayHint = { fg = "#35374B", bg = "NONE" }, --"#1F2544" --"#35374B" -- #503C3C

          ["@comment"] = { fg = "#4f5172", fmt = "italic" },
          ["@type"] = { fg = "$yellow", fmt = "bold" },
          ["@attribute"] = { fg = "#94aef9" },
          ["@keyword.import"] = { fg = "#a3336f", fmt = "italic,bold" },
          ["@keyword.export"] = { fg = "#a3336f", fmt = "italic,bold" },
          ["@keyword.return"] = { fg = "#C65E53", fmt = "italic,bold" },
          ["@keyword.coroutine"] = { fg = "#BB5D7D", fmt = "italic,bold" },
          ["@keyword.modifier"] = { fg = "#9486e4", fmt = "italic" },
          ["@lsp.type.modifier"] = { fg = "#9486e4", fmt = "italic" },

          ["@type.builtin"] = { fg = "#c45a99" },
          ["@lsp.type.enum"] = { fg = "#7AA89F" },
          ["@lsp.typemod.enum"] = { fg = "#7AA89F" },
          ["@lsp.type.enumMember"] = { fg = "#597BC0" },
          ["@lsp.typemod.enumMember"] = { fg = "#597BC0" },
          ["@lsp.type.interface"] = { fg = "#A06A2C", fmt = "bold" },
          ["@lsp.type.namespace"] = { fg = "#88a4f7" },
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
      light = "ef-spring", -- Ef-theme to select for light backgrounds
      dark = "ef-symbiosis", -- Ef-theme to select for dark backgrounds
      transparent = false,
      styles = {
        comments = { italic = true },
        keywords = { bold = false, italic = true },
        functions = {},
        variables = {},
        classes = { bold = true },
        types = { bold = true, italic = false },
        diagnostic = "full", -- Can be "full"
        pickers = "borderless", -- Can be "borderless"
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
        colors.bg_main = "#0d1b2a"
        colors.bg_dim = "#12121f"
        colors.bg_active = "#222236"
        colors.bg_inactive = "#262640"
        colors.fg_main = "#d4d7ff"
      end,
      on_highlights = function(highlights, colors, name)
        local kinds = {
          Array = "fg_dim",
          Boolean = "constant",
          Class = "type",
          Color = "string",
          Constant = "constant",
          Constructor = "magenta",
          Enum = "type",
          EnumMember = "type",
          Event = "constant",
          Field = "accent_2",
          File = "fg_main",
          Folder = "accent_0",
          Function = "fnname",
          Interface = "accent_1",
          Key = "accent_2",
          Keyword = "keyword",
          Method = "preprocessor",
          Module = "preprocessor",
          Namespace = "preprocessor",
          Null = "builtin",
          Number = "constant",
          Object = "constant",
          Operator = "fg_dim",
          Package = "preprocessor",
          Property = "green_cool",
          Reference = "link",
          Snippet = "fg_alt",
          String = "string",
          Struct = "type",
          Unit = "type",
          Text = "fg_main",
          TypeParameter = "type",
          Variable = "variable",
          Value = "string",
        }
        local custom_hls = {
          Comment = { fg = "#4f5172", italic = true },
          LspInlayHint = { fg = "#34392D", bg = "NONE" }, --"#1F2544" --"#35374B" -- #503C3C
          ["@keyword.import"] = { fg = "#a3336f", italic = true, bold = true },
          ["@keyword.export"] = { fg = "#a3336f", italic = true, bold = true },
          ["@keyword.return"] = { fg = "#C65E53", italic = true, bold = true },
          ["@keyword.coroutine"] = { fg = "#BB5D7D", italic = true, bold = true },
          ["@keyword.modifier"] = { fg = "#85c3f9", bold = true, italic = false },

          ["@punctuation.delimiter"] = { fg = colors.fg_dim, italic = false },

          ["@type.builtin"] = { fg = "#c45a99" },
          ["@lsp.type.enum"] = { fg = "#7AA89F" },
          ["@lsp.type.enumMember"] = { fg = "#597BC0" },
          ["@lsp.type.modifier"] = { fg = "#9486e4", bold = true, italic = false },
          ["@lsp.type.interface"] = { fg = "#A06A2C", bold = true, italic = true },
        }
        -- add navic support
        for k, v in pairs(kinds) do
          custom_hls[string.format("NavicIcons%s", k)] = { fg = colors[v] }
        end
        custom_hls["BlinkPairsRed"] = { fg = colors.rainbow_1 }
        custom_hls["BlinkPairsOrange"] = { fg = colors.rainbow_2 }
        custom_hls["BlinkPairsYellow"] = { fg = colors.rainbow_3 }
        custom_hls["BlinkPairsGreen"] = { fg = colors.rainbow_4 }
        custom_hls["BlinkPairsCyan"] = { fg = colors.rainbow_5 }
        custom_hls["BlinkPairsBlue"] = { fg = colors.rainbow_6 }
        custom_hls["BlinkPairsViolet"] = { fg = colors.rainbow_7 }

        return custom_hls
      end,
    },
  },
}

-- -- Color Definition
-- local forest = hsl("#34392D")
-- local maple = hsl("#F4D2AE")
-- local paduak = hsl("#FF9653")
-- local walnut = hsl("#CC967B")
-- local white_oak = hsl("#B5955E")
-- local dark_walnut = hsl("#685742")
-- local lush_green = hsl("#6C9861")
-- local golden_oak = hsl("#c9a554")
--
-- local olive = hsl("#97976D")
--
-- bg1 = "#12121f",
-- bg2 = "#171728",
-- bg3 = "#1d1d2f",
-- bg4 = "#222236",
-- bg5 = "#262640",
--
-- fg = "#d4d7ff",
--
-- grey1 = "#63668c",
-- grey2 = "#4f5172",
-- grey3 = "#444564",
--
-- green1 = "#74d2b7",
-- green2 = "#7ed7c0",
--
-- blue1 = "#82bdf7",
-- blue2 = "#85c3f9",
--
-- ice1 = "#97e7f7",
-- ice2 = "#a1eaf7",
--
-- purple1 = "#9486e4",
-- purple2 = "#9f95e9",
--
-- lilac1 = "#88a4f7",
-- lilac2 = "#94aef9",
--
-- yellow1 = "#e5dca4",
-- yellow2 = "#ecdfac",
--
-- orange1 = "#e2b88d",
-- orange2 = "#e8bf9c",
--
-- red1 = "#bd4277",
-- red2 = "#bf4a7f",
--
-- pink1 = "#c45a99",
-- pink2 = "#d864aa",
--
-- -- syntax specific colors
-- virt_err_bg = "#12070C",
-- virt_warn_bg = "#041F24",
-- virt_info_bg = "#061423",
-- virt_hint_bg = "#0D111C",
-- virt_ok_bg = "#0A1512",
--
-- variable_fg = "#c0cffc",
--
-- comment_err_bg = "#a3336f",
--
-- visual_sel_bg = "#27273f",
--
-- markup_h1 = "#95c7f9",
-- markup_h2 = "#9acafa",
-- markup_h3 = "#9fccfa",
-- markup_h4 = "#a4cffa",
-- markup_h5 = "#a8d1fa",
-- markup_h6 = "#acd3fa",
--     bg0 = '#252623',
-- bg1 = '#2f312c',
-- bg2 = '#383b35',
-- bg3 = '#3a3d37',
-- bg_d = '#1c1e1b',
--
