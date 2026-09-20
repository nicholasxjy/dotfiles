local loader = require("loader")

loader.on_very_lazy("bufferline", function()
  loader.packadd("nvim-web-devicons", "bufferline.nvim")

  require("bufferline").setup({
    options = {
      diagnostics = "nvim_lsp",
      -- Keep the visual order aligned with the existing H/L buffer mappings.
      sort_by = "id",
    },
  })
end)
