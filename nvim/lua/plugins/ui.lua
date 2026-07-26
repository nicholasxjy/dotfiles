local function config(name)
  return function()
    require("config." .. name)
  end
end

local function hl_color(group, attr, fallback)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
  local color = ok and hl[attr] or nil
  return color and string.format("#%06x", color) or fallback
end

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = config("tokyonight"),
  },
  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
        [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
        gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
        postcss = { glyph = "󰌜", hl = "MiniIconsOrange" },
      },
    },
    config = function(_, opts)
      require("mini.icons").setup(opts)
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-mini/mini.icons" },
    config = config("lualine"),
  },
  {
    "nvim-mini/mini.tabline",
    event = "VeryLazy",
    dependencies = { "nvim-mini/mini.icons" },
    opts = { show_icons = true },
  },
  {
    "nvim-mini/mini.notify",
    event = "VeryLazy",
    opts = {
      lsp_progress = {
        enable = true,
        level = "INFO",
        duration_last = 1000,
      },
      window = {
        max_width_share = 0.382,
        winblend = 0,
      },
    },
  },
  {
    "nicholasxjy/modes.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        colors = {
          bg = "#362706",
          copy = hl_color("WarningMsg", "fg", "#f5c359"),
          delete = hl_color("ErrorMsg", "fg", "#c75c6a"),
          change = hl_color("ErrorMsg", "fg", "#c75c6a"),
          format = hl_color("Operator", "fg", "#c79585"),
          insert = hl_color("DiagnosticInfo", "fg", "#78ccc5"),
          replace = hl_color("Substitute", "bg", "#245361"),
          select = hl_color("Search", "bg", "#9745be"),
          visual = hl_color("Visual", "bg", "#9745be"),
        },
        line_opacity = 0.15,
        set_cursor = false,
        set_cursorline = true,
        set_number = true,
        set_signcolumn = true,
        ignore = { "NvimTree", "TelescopePrompt", "!minifiles" },
      }
    end,
  },
  {
    "NStefan002/screenkey.nvim",
    cmd = "Screenkey",
    opts = function()
      return {
        win_opts = {
          row = vim.o.lines - vim.o.cmdheight - 1,
          col = vim.o.columns - 1,
          relative = "editor",
          anchor = "SE",
          width = 20,
          height = 2,
          title = "Screenkey",
          title_pos = "center",
          style = "minimal",
          focusable = false,
          noautocmd = true,
        },
        hl_groups = {
          ["screenkey.hl.key"] = { link = "Type" },
          ["screenkey.hl.map"] = { link = "Keyword" },
          ["screenkey.hl.sep"] = { link = "Normal" },
        },
      }
    end,
  },
  {
    "2KAbhishek/nerdy.nvim",
    cmd = "Nerdy",
    opts = {
      max_recents = 30,
      copy_to_clipboard = false,
      copy_register = "+",
    },
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    config = config("tiny-inline-diagnostic"),
  },
  {
    "nicholasxjy/zed-bar.nvim",
    branch = "feature/optional-nvim-treesitter",
    event = "VeryLazy",
    config = config("zed-bar"),
  },
}
