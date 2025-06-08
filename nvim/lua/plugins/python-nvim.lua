return {
  "joshzcold/python.nvim",
  opts = {
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
}
