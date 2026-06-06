vim.pack.add({
  "https://github.com/andymass/vim-matchup",
}, { load = false })

local loaded = false

local function load_matchup()
  if loaded then
    return require("match-up")
  end

  vim.cmd.packadd("vim-matchup")

  local matchup = require("match-up")

  matchup.setup({
    matchparen = {
      enabled = 1,
      nomode = "i",
      insert_timeout = 20,
      hi_background = 0,
      hi_surround_always = 0,
      offscreen = {
        method = "status",
      },
    },
    surround = {
      enabled = 1,
    },
    text_obj = {
      enabled = 1,
    },
    treesitter = {
      enabled = true,
      stopline = 300,
      enable_quotes = true,
      include_match_words = true,
      disable_virtual_text = true,
    },
  })

  loaded = true

  return matchup
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  once = true,
  callback = function()
    load_matchup()
  end,
})
