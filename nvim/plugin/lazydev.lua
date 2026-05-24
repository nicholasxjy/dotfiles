local util = require("util")

local function setup_lazydev()
  util.ensure_plugin("lazydev.nvim", function()
    require("lazydev").setup({
      library = {
        "~/.local/share/nvim/lazy/",
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    })
  end)
end

_G.__setup_lazydev = setup_lazydev
