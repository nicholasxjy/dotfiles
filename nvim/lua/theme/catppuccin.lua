local loader = require("loader")

local M = {}

function M.setup()
  loader.packadd("catppuccin")
  require("catppuccin").setup({
    flavour = "frappe",
    styles = {
      keywords = { "bold" },
    },
    lsp_styles = {
      inlay_hints = {
        background = false,
      },
    },
    auto_integrations = true,
  })

  -- Another theme's background must not override an explicitly selected flavour.
  vim.api.nvim_create_autocmd("ColorSchemePre", {
    group = vim.api.nvim_create_augroup("sjvim_catppuccin_background", { clear = true }),
    pattern = { "catppuccin-latte", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha" },
    callback = function(args)
      if not (vim.g.colors_name or ""):match("^catppuccin%-") then
        vim.o.background = args.match == "catppuccin-latte" and "light" or "dark"
      end
    end,
  })
end

return M
