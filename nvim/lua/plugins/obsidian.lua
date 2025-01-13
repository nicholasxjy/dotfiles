return {
  {
    "epwalsh/obsidian.nvim",
    cmd = {
      "ObsidianOpen",
      "ObsidianNew",
      "ObsidianQuickSwitch",
      "ObsidianSearch",
      "ObsidianWorkspace",
      "ObsidianRename",
      "ObsidianToggleCheckbox",
      "ObsidianTags",
    },
    version = "*", -- recommended, use latest release instead of latest commit
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      -- refer to `:h file-pattern` for more examples
      -- stylua: ignore
      "BufReadPre " .. vim.fn.expand("~") .. "/obsidian/notes/*.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/obsidian/notes/*.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    opts = {
      ui = { enable = false },
      workspaces = {
        {
          name = "notes",
          path = "~/obsidian/notes",
        },
      },
      completion = {
        -- Set to false to disable completion.
        nvim_cmp = false,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },
    },
  },
}
