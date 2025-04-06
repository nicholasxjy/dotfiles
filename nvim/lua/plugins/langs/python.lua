local lspUtil = require("utils.lsp")
local util = require("utils.util")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "ninja", "rst" } },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       ruff = {
  --         cmd_env = { RUFF_TRACE = "messages" },
  --         init_options = {
  --           settings = {
  --             logLevel = "error",
  --           },
  --         },
  --         keys = {
  --           {
  --             "<leader>co",
  --             lspUtil.action["source.organizeImports"],
  --             desc = "Organize Imports",
  --           },
  --         },
  --       },
  --     },
  --     setup = {
  --       ruff = function()
  --         lspUtil.on_attach(function(client, _)
  --           -- Disable hover in favor of Pyright
  --           client.server_capabilities.hoverProvider = false
  --         end, "ruff")
  --       end,
  --     },
  --   },
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = function(_, opts)
  --     local servers = { "pyright", "ruff" }
  --     for _, server in ipairs(servers) do
  --       opts.servers[server] = opts.servers[server] or {}
  --       opts.servers[server].enabled = true
  --     end
  --   end,
  -- },
  -- {
  --   "nvim-neotest/neotest",
  --   optional = true,
  --   dependencies = {
  --     "nvim-neotest/neotest-python",
  --   },
  --   opts = {
  --     adapters = {
  --       ["neotest-python"] = {
  --         -- Here you can specify the settings for the adapter, i.e.
  --         -- runner = "pytest",
  --         -- python = ".venv/bin/python",
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "mfussenegger/nvim-dap",
  --   optional = true,
  --   dependencies = {
  --     "mfussenegger/nvim-dap-python",
  --     -- stylua: ignore
  --     keys = {
  --       { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
  --       { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
  --     },
  --     config = function()
  --       if vim.fn.has("win32") == 1 then
  --         require("dap-python").setup(util.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
  --       else
  --         require("dap-python").setup(util.get_pkg_path("debugpy", "/venv/bin/python"))
  --       end
  --     end,
  --   },
  -- },
  --
  -- -- Don't mess up DAP adapters provided by nvim-dap-python
  -- {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   optional = true,
  --   opts = {
  --     handlers = {
  --       python = function() end,
  --     },
  --   },
  -- },
  {
    "joshzcold/python.nvim",
    opts = { ---@diagnostic disable-line: missing-fields`
      python_lua_snippets = true,
    },
    dependencies = {
      { "mfussenegger/nvim-dap" },
      { "mfussenegger/nvim-dap-python" },
      { "MunifTanjim/nui.nvim" },
      { "neovim/nvim-lspconfig" },
      { "L3MON4D3/LuaSnip" },
    },
    init = function()
      vim.api.nvim_set_keymap(
        "n",
        "<leader>cp",
        '<cmd>lua require("python.venv").pick_venv()<cr>',
        { desc = "Python pick venv" }
      )
    end,
  },
}
