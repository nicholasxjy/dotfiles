return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.capabilities = opts.capabilities or {}
      opts.capabilities.textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      }
    end,
  },
}
