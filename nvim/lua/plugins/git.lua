local function config(name)
  return function()
    require("config." .. name)
  end
end

return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = config("gitsigns"),
  },
  {
    "barrettruth/diffs.nvim",
    cmd = "Diff",
    init = function()
      vim.g.diffs = {
        integrations = {
          fugitive = true,
          neogit = true,
          neojj = true,
          gitsigns = true,
        },
      }
    end,
  },
  {
    "esmuellert/codediff.nvim",
    cmd = { "CodeDiff", "VscodeDiff" },
    opts = {
      explorer = { view_mode = "tree" },
      history = { view_mode = "tree" },
    },
  },
}
