return {
  "barrettruth/diffs.nvim",
  cmd = "Gdiff",
  init = function()
    vim.g.diffs = {
      fugitive = true,
      neogit = true,
    }
  end,
}
