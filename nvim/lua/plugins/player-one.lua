return {
  "jackplus-xyz/player-one.nvim",
  cmd = {
    "PlayerOneToggle",
    "PlayerOneEnable",
    "PlayerOneLoad",
  },
  opts = {
    is_enabled = true,
    theme = "chiptune",
    min_interval = 0.05,
    binary = {
      auto_update = true,
      proxy = {
        from_env = true,
      },
    },
  },
}
