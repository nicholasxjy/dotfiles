vim.pack.add({
  "https://github.com/meuter/lualine-so-fancy.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
}, { load = false })

local lualine_loaded = false

local function load_lualine()
  if lualine_loaded then
    return
  end

  vim.cmd.packadd("lualine-so-fancy.nvim")
  vim.cmd.packadd("lualine.nvim")

  local opts = {
    options = {
      theme = "auto",
      component_separators = { left = "│", right = "│" },
      section_separators = { left = "", right = "" },
      globalstatus = true,
      refresh = {
        statusline = 100,
      },
    },
    sections = {
      lualine_a = {
        { "fancy_mode", width = 3 },
      },
      lualine_b = {
        { "fancy_branch" },
        { "fancy_diff" },
      },
      lualine_c = {
        { "fancy_cwd", substitute_home = true },
      },
      lualine_x = {
        { "fancy_macro" },
        { "fancy_diagnostics" },
        { "fancy_searchcount" },
        { "fancy_location" },
      },
      lualine_y = {
        { "fancy_filetype", ts_icon = "" },
      },
      lualine_z = {
        { "fancy_lsp_servers" },
      },
    },
  }
  require("lualine").setup(opts)

  lualine_loaded = true
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  once = true,
  callback = function()
    load_lualine()
  end,
})
