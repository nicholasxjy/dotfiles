local util = require("util")

local function setup_matchup()
  util.ensure_plugin("vim-matchup", function()
    require("match-up").setup({
      matchparen = {
        enabled = 1,
        -- Match-up runs on TextChangedI/CursorMovedI and can feel laggy in insert mode,
        -- especially when typing spaces in large buffers. Keep it for normal mode only.
        nomode = "i",
        insert_timeout = 20,
        hi_background = 1,
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
  end)
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("MatchupDeferredSetup", { clear = true }),
  once = true,
  callback = setup_matchup,
})
