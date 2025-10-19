return {
  "lewis6991/hover.nvim",
  event = "VeryLazy",
  config = function()
    require("hover").config({
      providers = {
        {
          module = "hover.providers.lsp",
          priority = 2000,
        },
      },
      preview_opts = {
        border = vim.g.bordered and "rounded" or "none",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
      },
      preview_window = false,
      title = true,
      mouse_providers = {
        -- "hover.providers.lsp",
      },
      mouse_delay = 1000,
    })

    -- Setup keymaps
    vim.keymap.set("n", "K", function()
      require("hover").open()
    end, { desc = "hover.nvim (open)", silent = true, noremap = true })

    vim.keymap.set("n", "<MouseMove>", function()
      require("hover").mouse()
    end, { desc = "hover.nvim (mouse)" })

    vim.o.mousemoveevent = true
  end,
}
