local icons = require("config.icons")
return {
  "Saghen/blink.cmp",
  event = "InsertEnter",
  opts = function(_, opts)
    opts.signature = { enabled = true }
    opts.appearance = opts.appearance or {}
    opts.appearance.kind_icons = icons.kind_icons

    opts.completion.menu = opts.completion.menu or {}
    opts.completion.menu.border = {
      { "󱐋", "WarningMsg" },
      "─",
      "╮",
      "│",
      "╯",
      "─",
      "╰",
      "│",
    }
    opts.completion.menu.draw.columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } }

    opts.completion.documentation = opts.completion.documentation or {}
    opts.completion.documentation.window = opts.completion.documentation.window or {}
    opts.completion.documentation.window.border = {
      { "", "DiagnosticHint" },
      "─",
      "╮",
      "│",
      "╯",
      "─",
      "╰",
      "│",
    }
    -- opts.completion.list = opts.completion.list or {}
    -- opts.completion.list.selection = function(ctx)
    --   return ctx.mode == "cmdline" and "auto_insert" or "preselect"
    -- end

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
