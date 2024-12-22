local icons = require("config.icons")
return {
  "Saghen/blink.cmp",
  event = "InsertEnter",
  opts = function(_, opts)
    opts.appearance = opts.appearance or {}
    opts.appearance.kind_icons = icons.kind_icons
    opts.sources = opts.sources or {}
    opts.sources.cmdline = function()
      local type = vim.fn.getcmdtype()
      -- Search forward and backward
      if type == "/" or type == "?" then
        return { "buffer" }
      end
      -- Commands
      if type == ":" then
        return { "cmdline" }
      end
      return {}
    end
  end,
}
