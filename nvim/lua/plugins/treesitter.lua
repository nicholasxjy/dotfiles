return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      desc = "Enable highlight and indent",
      callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match)
        local available_langs = require("nvim-treesitter").get_available()
        local is_available = vim.tbl_contains(available_langs, lang)
        if is_available then
          local installed_langs = require("nvim-treesitter").get_installed()
          local installed = vim.tbl_contains(installed_langs, lang)
          if not installed then
            require("nvim-treesitter").install(lang)
          end
          vim.treesitter.start()
          require("nvim-treesitter").indentexpr()
        end
      end,
    })
  end,
}
