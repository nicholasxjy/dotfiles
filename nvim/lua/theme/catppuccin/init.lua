local loader = require("loader")

local M = {}

--- Shared highlight overrides across all Catppuccin flavors
---@param highlights table<string, any>
---@param colors table<string, string>
local function shared_highlights(highlights, colors)
  highlights.WinBar = { fg = colors.text, bg = "NONE" }
  highlights.FzfLuaDirPart = { fg = colors.overlay0, bold = true }
  highlights.ZedBarFile = { fg = colors.overlay0, bold = true }
  highlights.XuePickerGrepPath = { link = "Comment" }

  highlights["@keyword.import"] = { fg = colors.teal, italic = true }
  highlights["@keyword.export"] = { link = "@keyword.import" }
  highlights["@tag.tsx"] = { fg = colors.red, bold = true }
  highlights["@tag.attribute"] = { fg = colors.sapphire, italic = true }
end

--- Extract color overrides from on_colors (supports function or table)
---@param flavour string
---@param on_colors function|table|nil
---@return table<string, string>
local function get_color_overrides(flavour, on_colors)
  if not on_colors then
    return {}
  end
  if type(on_colors) == "table" then
    return on_colors
  end
  if type(on_colors) == "function" then
    local ok, orig = pcall(require, "catppuccin.palettes." .. flavour)
    if not ok or type(orig) ~= "table" then
      return {}
    end
    local copy = vim.deepcopy(orig)
    local res = on_colors(copy)
    if type(res) == "table" then
      return res
    end
    local diff = {}
    for k, v in pairs(copy) do
      if v ~= orig[k] then
        diff[k] = v
      end
    end
    return diff
  end
  return {}
end

--- Setup catppuccin with modular flavors
---@param flavour? string "mocha" | "macchiato" | "frappe" | "latte"
function M.setup(flavour)
  flavour = flavour or "mocha"

  loader.load("catppuccin", function()
    loader.packadd("catppuccin")

    local color_overrides = {}
    local highlight_overrides = {
      all = function(c)
        local hl = {}
        shared_highlights(hl, c)
        return hl
      end,
    }

    for _, flvr in ipairs({ "mocha", "macchiato", "frappe", "latte" }) do
      local ok, mod = pcall(require, "theme.catppuccin." .. flvr)
      if ok and type(mod) == "table" then
        color_overrides[flvr] = get_color_overrides(flvr, mod.on_colors)
        if mod.on_highlights then
          highlight_overrides[flvr] = function(c)
            local hl = {}
            local res = mod.on_highlights(hl, c)
            if type(res) == "table" then
              hl = vim.tbl_extend("force", hl, res)
            end
            return hl
          end
        end
      end
    end

    require("catppuccin").setup({
      flavour = flavour,
      transparent_background = true,
      term_colors = true,
      styles = {
        comments = { "italic" },
        conditionals = {},
        loops = {},
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
      color_overrides = color_overrides,
      highlight_overrides = highlight_overrides,
      float = {
        transparent = true,
        solid = false,
      },
      auto_integrations = true,
      integrations = {
        blink_cmp = true,
        fzf = true,
        gitsigns = true,
        mini = { enabled = true },
        neotree = true,
        rainbow_delimiters = true,
        render_markdown = true,
        treesitter = true,
        which_key = true,
      },
    })
  end)

  vim.cmd.colorscheme("catppuccin-" .. flavour)
end

return M
