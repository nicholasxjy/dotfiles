return {
  {
    "ramojus/mellifluous.nvim",
    opts = {
      colorset = "mellifluous", -- mellifluous alduin mountain tender kanagawa_dragon
      dim_inactive = false,
      styles = {
        main_keywords = { italic = true },
        other_keywords = { italic = false },
        types = { bold = true, italic = true },
        operators = { bold = true },
        strings = {},
        functions = {},
        constants = {},
        comments = { italic = true },
        markup = {
          headings = { bold = true },
        },
        folds = {},
      },
      flat_background = {
        line_numbers = true,
        floating_windows = false,
        file_tree = true,
        cursor_line_number = true,
      },
      highlight_overrides = {
        dark = function(hl, colors)
          -- hl.set("@type", { fg = colors.types:darkened(10), bold = true })
          hl.set("@type.builtin", { fg = "#C34043", bold = false, italic = true })
          hl.set("@lsp.type.interface", { fg = "#A06A2C", bold = true })
          hl.set("@lsp.type.namespace", { fg = colors.red:darkened(10), bold = false })
          hl.set("@lsp.type.enum", { fg = "#7AA89F", bold = true })
          hl.set("@keyword.import", { fg = "#A3D4D5", italic = true })
          hl.set("@keyword.export", { fg = "#A3D4D5", italic = true })
        end,
      },
    },
  },
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
          conditionals = { italic = true },
          keywords = { italic = false },
          functions = {},
          namespaces = { italic = false },
          parameters = { italic = true },
          strings = {},
          variables = {},
        },

        lualine = {
          transparent = true,
        },

        colors = {},
        highlights = {
          NormalFloat = { fg = "$fg", bg = "$bg1" },
          FloatBorder = { fg = "$bg1", bg = "$bg1" },

          Comment = { fg = "#4f5172", italic = true },
          LspInlayHint = { fg = "#363a4f", bg = "NONE" },
          ["@type"] = { fg = "$yellow", fmt = "bold,italic" },
          ["@keyword.import"] = { fg = "#a3336f", fmt = "italic" },
          ["@keyword.export"] = { fg = "#a3336f", fmt = "italic" },
          ["@keyword.return"] = { fg = "#C65E53", fmt = "italic,bold" },
          ["@keyword.coroutine"] = { fg = "#BB5D7D", fmt = "italic,bold" },

          ["@type.builtin"] = { fg = "#c45a99" },
          ["@lsp.type.enum"] = { fg = "#7AA89F" },
          ["@lsp.type.enumMember"] = { fg = "#597BC0" },
          ["@lsp.type.interface"] = { fg = "#A06A2C", fmt = "bold,italic" },
          ["@lsp.type.namespace"] = { fg = "#85c3f9" },
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
      dark = "ef-bio", -- Ef-theme to select for dark backgrounds
      transparent = false,
      styles = {
        comments = { italic = true },
        keywords = { bold = true, italic = true },
        functions = {},
        variables = {},
        classes = { bold = true },
        types = { bold = true },

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
        colors.bg_main = "#12121f"
        colors.bg_dim = "#1d1d2f"
        colors.bg_active = "#222236"
        colors.bg_inactive = "#262640"
        colors.fg_main = "#B5C0D0"
      end,
      on_highlights = function(highlights, colors, name)
        return {
          Comment = { fg = "#4f5172", italic = true },
          LspInlayHint = { fg = "#363a4f", bg = "NONE" },
          ["@keyword.import"] = { fg = "#a3336f", italic = true, bold = true },
          ["@keyword.export"] = { fg = "#a3336f", italic = true, bold = true },
          ["@keyword.return"] = { fg = "#C65E53", italic = true, bold = true },
          ["@keyword.coroutine"] = { fg = "#BB5D7D", italic = true, bold = true },
          ["@keyword.modifier"] = { fg = "#85c3f9", bold = true, italic = false },

          ["@type.builtin"] = { fg = "#c45a99" },
          ["@lsp.type.enum"] = { fg = "#7AA89F" },
          ["@lsp.type.enumMember"] = { fg = "#597BC0" },
          ["@lsp.type.modifier"] = { fg = "#9486e4", bold = true, italic = false },
          ["@lsp.type.interface"] = { fg = "#A06A2C", bold = true, italic = false },
        }
      end,
    },
  },
}
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
