return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    "BufReadPre " .. vim.fn.expand("~/notes/*.md"),
    "BufNewFile " .. vim.fn.expand("~/notes/*.md"),
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/notes",
      },
    },
    picker = {
      name = "snacks",
    },
  },
}
