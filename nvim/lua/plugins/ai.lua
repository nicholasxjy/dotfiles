return {
  {
    "nicholasxjy/sidekick.nvim",
    event = "VeryLazy",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      { "<Tab>", mode = "n", desc = "Next Suggestion" },
      { "<M-.>", mode = { "n", "t", "i", "x" }, desc = "Toggle Sidekick" },
      { "<leader>aa", desc = "Toggle CLI" },
      { "<leader>as", desc = "Select CLI" },
      { "<leader>ad", desc = "Close CLI" },
      { "<leader>at", mode = { "n", "x" }, desc = "Send Current" },
      { "<leader>af", desc = "Send File" },
      { "<leader>av", mode = "x", desc = "Send Selection" },
      { "<leader>ap", mode = { "n", "x" }, desc = "Select Prompt" },
    },
    config = function()
      require("config.sidekick")
    end,
  },
}
