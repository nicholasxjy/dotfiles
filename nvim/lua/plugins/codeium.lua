return {
  {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    event = "InsertEnter",
    build = ":Codeium Auth",
    opts = {
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
      },
    },
  },
}
