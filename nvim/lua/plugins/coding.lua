return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.default = { "lsp", "path", "luasnip", "buffer" }
      opts.sources.cmdline = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        -- Commands
        if type == ":" or type == "@" then
          return { "cmdline" }
        end
        return {}
      end
    end,
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
  --   dependencies = {
  --     "hrsh7th/cmp-cmdline", -- add cmp-cmdline as dependency of cmp
  --   },
  --   config = function(plugin, opts)
  --     local cmp = require("cmp")
  --     -- run cmp setup
  --     cmp.setup(opts)
  --
  --     -- configure `cmp-cmdline` as described in their repo: https://github.com/hrsh7th/cmp-cmdline#setup
  --     cmp.setup.cmdline("/", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = {
  --         { name = "buffer" },
  --       },
  --     })
  --     cmp.setup.cmdline(":", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = cmp.config.sources({
  --         { name = "path" },
  --       }, {
  --         {
  --           name = "cmdline",
  --           option = {
  --             ignore_cmds = { "Man", "!" },
  --           },
  --         },
  --       }),
  --     })
  --   end,
  -- },
}
