local M = {}

local configured = false

function M.setup()
  if configured then
    return
  end

  local loader = require("loader")
  loader.packadd("catppuccin")

  require("catppuccin").setup({
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = "latte",
      dark = "macchiato",
    },
    transparent_background = false, -- disables setting the background color.
    float = {
      transparent = false, -- enable transparent floating windows
      solid = false, -- use solid styling for floating windows, see |winborder|
    },
    term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = false, -- dims the background color of inactive window
      shade = "dark",
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" }, -- Change the style of comments
      conditionals = { "bold" },
      loops = { "bold" },
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
        ok = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
        ok = { "underline" },
      },
      inlay_hints = {
        background = false,
      },
    },
    -- Keep Catppuccin's palette roles, but carry over TokyoNight's Circadia
    -- warm/cool balance and contrast hierarchy for the dark flavour.
    color_overrides = {
      macchiato = {
        base = "#24283b",
        mantle = "#1f2335",
        crust = "#1b1e2d",
        surface0 = "#292e42",
        surface1 = "#343a53",
        surface2 = "#4d3a4b",
        overlay0 = "#807580",
        overlay1 = "#a0968b",
        overlay2 = "#bdb2a7",
        subtext0 = "#ada49a",
        subtext1 = "#c7bdb2",
        text = "#eee7dc",
      },
      mocha = {
        rosewater = "#f5e0dc",
        flamingo = "#f2cdcd",
        pink = "#f5c2e7",
        mauve = "#cba6f7",
        red = "#f38ba8",
        maroon = "#eba0ac",
        peach = "#fab387",
        yellow = "#f9e2af",
        green = "#a6e3a1",
        teal = "#94e2d5",
        sky = "#89dceb",
        sapphire = "#74c7ec",
        blue = "#89b4fa",
        lavender = "#b4befe",
        text = "#cdd6f4",
        subtext1 = "#bac2de",
        subtext0 = "#a6adc8",
        overlay2 = "#9399b2",
        overlay1 = "#7f849c",
        overlay0 = "#6c7086",
        surface2 = "#585b70",
        surface1 = "#45475a",
        surface0 = "#313244",
        base = "#1e1e2e",
        mantle = "#181825",
        crust = "#11111b",
      },
      circadia = {
        base = "#24283b",
        mantle = "#1f2335",
        crust = "#1b1e2d",
        surface0 = "#292e42",
        surface1 = "#343a53",
        surface2 = "#4d3a4b",
        overlay0 = "#807580",
        overlay1 = "#a0968b",
        overlay2 = "#bdb2a7",
        subtext0 = "#ada49a",
        subtext1 = "#c7bdb2",
        text = "#eee7dc",
        rosewater = "#f8cb94",
        flamingo = "#eba0ac",
        pink = "#e5a3e6",
        mauve = "#cba6f7",
        red = "#f38ba8",
        maroon = "#df6b62",
        peach = "#dc8e3d",
        yellow = "#f4b258",
        green = "#addd7c",
        teal = "#94e2d5",
        sky = "#89dceb",
        sapphire = "#74c7ec",
        blue = "#89b4fa",
        lavender = "#b4befe",
      },
      -- Kanagawa Wave palette mapped to Catppuccin roles.
      kanagawa = {
        base = "#1f1f28",
        mantle = "#1a1a22",
        crust = "#16161d",
        surface0 = "#2a2a37",
        surface1 = "#363646",
        surface2 = "#3e3e51",
        overlay0 = "#54546d",
        overlay1 = "#6a6a7d",
        overlay2 = "#8e8ea3",
        subtext0 = "#c8c093",
        subtext1 = "#d4ceaa",
        text = "#dcd7ba",
        rosewater = "#c0a36e",
        flamingo = "#ff5d62",
        pink = "#d27e99",
        mauve = "#957fb8",
        red = "#e46876",
        maroon = "#c34043",
        peach = "#ffa066",
        yellow = "#FF9E3B",
        green = "#98bb6c",
        teal = "#7aa89f",
        sky = "#a3d4d5",
        sapphire = "#7fb4ca",
        blue = "#7e9cd8",
        lavender = "#9CABCA",
      },
      -- Gruvbox palette mapped to Catppuccin roles.
      gruvbox = {
        base = "#32302f",
        mantle = "#282828",
        crust = "#1d2021",
        surface0 = "#3c3836",
        surface1 = "#504945",
        surface2 = "#665c54",
        overlay0 = "#7c6f64",
        overlay1 = "#928374",
        overlay2 = "#a89984",
        subtext0 = "#bdae93",
        subtext1 = "#d5c4a1",
        text = "#ebdbb2",
        rosewater = "#efb6a0",
        flamingo = "#e78a4e",
        pink = "#d3869b",
        mauve = "#a06f9c",
        red = "#fb4934",
        maroon = "#cc241d",
        peach = "#fe8019",
        yellow = "#fabd2f",
        green = "#b8bb26",
        teal = "#5f9f85",
        sky = "#7fb5a3",
        sapphire = "#458588",
        blue = "#7e9cd8",
        lavender = "#9CABCA",
      },
    },
    custom_highlights = function(colors)
      return {
        -- Preserve TokyoNight's semantic syntax accents.
        Include = { fg = colors.teal },
        ["@module"] = { fg = colors.yellow },
        ["@lsp.type.namespace"] = { link = "@module" },
        ["@keyword.import"] = { link = "Include" },
        ["@keyword.export"] = { link = "Include" },
        ["@keyword.conditional"] = { fg = colors.pink },
        ["@tag.tsx"] = { fg = colors.red, style = { "bold" } },
        ["@tag.jsx"] = { link = "@tag.tsx" },
        ["@tag.attribute"] = { fg = colors.sapphire, style = { "italic" } },

        FloatBorder = { fg = colors.lavender, bg = colors.mantle },
        ZedBarFile = { fg = colors.overlay1, style = { "bold" } },
        PmenuMatch = { fg = colors.sapphire, bold = true },

        SnacksPicker = { bg = colors.base },
        SnacksPickerDir = { fg = colors.subtext0, bg = colors.crust },
        SnacksPickerMatch = { fg = colors.sapphire, bg = colors.none, style = { "bold" } },
        SnacksPickerInput = { fg = colors.mauve, bg = colors.none },
        SnacksPickerPrompt = { fg = colors.peach, style = { "bold" } },
        SnacksPickerInputSearch = { fg = colors.sapphire, style = { "bold" } },
        SnacksPickerListTitle = { fg = colors.green, style = { "bold" } },
        SnacksPickerPreviewTitle = { fg = colors.teal, style = { "bold" } },
        SnacksPickerPreviewBorder = { link = "FloatBorder" },
        SnacksPickerListBorder = { link = "FloatBorder" },
        SnacksPickerBoxBorder = { link = "FloatBorder" },
        SnacksPickerInputBorder = { fg = colors.sky },
        SnacksPickerDelim = { fg = colors.pink },

        FzfLuaDirPart = { link = "SnacksPickerDir" },
        FzfLuaBorder = { link = "FloatBorder" },
        FzfLuaPreviewBorder = { link = "SnacksPickerPreviewBorder" },

        BlinkCmpLabelDescription = { link = "NonText" },
        BlinkCmpLabelDetail = { link = "NonText" },
        BlinkCmpMenu = { fg = colors.text, bg = colors.mantle },
        BlinkCmpMenuBorder = { link = "FloatBorder" },
        BlinkCmpDocBorder = { fg = colors.green },
        BlinkCmpSignatureHelpBorder = { fg = colors.yellow },
        BlinkPairsUnmatched = { link = "DiagnosticError" },
        BlinkPairsMatchParen = { link = "MatchParen" },
        BlinkIndent = { link = "Whitespace" },
        BlinkIndentScope = { link = "Delimiter" },

        BlinkPairsBlue = { link = "RainbowDelimiterBlue" },
        BlinkPairsCyan = { link = "RainbowDelimiterCyan" },
        BlinkPairsGreen = { link = "RainbowDelimiterGreen" },
        BlinkPairsOrange = { link = "RainbowDelimiterOrange" },
        BlinkPairsRed = { link = "RainbowDelimiterRed" },
        BlinkPairsViolet = { link = "RainbowDelimiterViolet" },
        BlinkPairsYellow = { link = "RainbowDelimiterYellow" },
        BlinkIndentBlue = { link = "RainbowDelimiterBlue" },
        BlinkIndentCyan = { link = "RainbowDelimiterCyan" },
        BlinkIndentGreen = { link = "RainbowDelimiterGreen" },
        BlinkIndentOrange = { link = "RainbowDelimiterOrange" },
        BlinkIndentRed = { link = "RainbowDelimiterRed" },
        BlinkIndentViolet = { link = "RainbowDelimiterViolet" },
        BlinkIndentYellow = { link = "RainbowDelimiterYellow" },
      }
    end,
    auto_integrations = true,
    integrations = {
      rainbow_delimiters = true,
      mini = { enabled = true },
      blink_pairs = true,
      illuminate = {
        enabled = true,
        lsp = false,
      },
    },
  })

  configured = true
end

return M
