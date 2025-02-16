return {
  "bassamsdata/namu.nvim",
  keys = {
    {
      "<leader>ss",
      function()
        require("namu.namu_symbols").show()
      end,
      desc = "Jump to LSP symbol",
      silent = true,
    },
  },
  config = function()
    require("namu").setup({
      -- Enable the modules you want
      namu_symbols = {
        enable = true,
        options = {}, -- here you can configure namu
      },
      -- Optional: Enable other modules if needed
      colorscheme = {
        enable = true,
        options = {
          -- NOTE: if you activate persist, then please remove any vim.cmd("colorscheme ...") in your config, no needed anymore
          persist = true, -- very efficient mechanism to Remember selected colorscheme
          write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
        },
      },
      ui_select = { enable = false },
    })
  end,
}
