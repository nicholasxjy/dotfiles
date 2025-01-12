-- local custom_icons = require("core.icons")
-- local lspUtil = require("utils.lsp")
local lualineUtil = require("utils.lualine")
return {
  {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    event = "InsertEnter",
    build = ":Codeium Auth",
    opts = {
      enable_cmp_source = true,
      virtual_text = {
        enabled = false,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.sections = opts.sections or {}
      table.insert(opts.sections.lualine_x or {}, lualineUtil.cmp_source("codeium"))
    end,
  },
  -- lualine
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     opts.sections = opts.sections or {}
  --     table.insert(
  --       opts.sections.lualine_x or {},
  --       lualineUtil.status(custom_icons.lazy_kind_icons.Copilot, function()
  --         local clients = package.loaded["copilot"] and lspUtil.get_clients({ name = "copilot", bufnr = 0 }) or {}
  --         if #clients > 0 then
  --           local status = require("copilot.api").status.data.status
  --           return (status == "InProgress" and "pending") or (status == "Warning" and "error") or "ok"
  --         end
  --       end)
  --     )
  --   end,
  -- },
}
