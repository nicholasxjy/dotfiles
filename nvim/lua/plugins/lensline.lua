return {
  "oribarilan/lensline.nvim",
  event = "LspAttach",
  cmd = { "LensLineToggle" },
  config = function()
    require("lensline").setup({
      providers = { -- Array format: order determines display sequence
        {
          name = "references",
          enabled = true, -- enable references provider
          quiet_lsp = true, -- suppress noisy LSP log messages (e.g., Pyright reference spam)
        },
        {
          name = "last_author",
          enabled = true, -- enabled by default with caching optimization
          cache_max_files = 50, -- maximum number of files to cache blame data for (default: 50)
        },
        -- built-in providers that are diabled by default:
        {
          name = "diagnostics",
          enabled = false, -- disabled by default - enable explicitly to use
          min_level = "HINT", -- only show WARN and ERROR by default (HINT, INFO, WARN, ERROR)
        },
        {
          name = "complexity",
          enabled = false, -- disabled by default - enable explicitly to use
          min_level = "L", -- only show L (Large) and XL (Extra Large) complexity by default
        },
      },
    })
  end,
}
