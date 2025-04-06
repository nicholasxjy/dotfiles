return {
  "2kabhishek/markit.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("markit").setup({
      default_mappings = true,
    })
  end,
}
