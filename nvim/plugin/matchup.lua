local util = require("util")

local structured_filetypes = {
  bash = true,
  c = true,
  cpp = true,
  css = true,
  dockerfile = true,
  go = true,
  html = true,
  java = true,
  javascript = true,
  javascriptreact = true,
  json = true,
  jsonc = true,
  lua = true,
  markdown = true,
  python = true,
  rust = true,
  sh = true,
  toml = true,
  tsx = true,
  typescript = true,
  typescriptreact = true,
  vue = true,
  yaml = true,
  zsh = true,
}

local function setup_matchup()
  util.ensure_plugin("vim-matchup", function()
    require("match-up").setup({
      matchparen = {
        enabled = 1,
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

local matchup_group = vim.api.nvim_create_augroup("MatchupDeferredSetup", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = matchup_group,
  callback = function(ev)
    if vim.bo[ev.buf].buftype ~= "" or not structured_filetypes[vim.bo[ev.buf].filetype] then
      return
    end
    vim.defer_fn(setup_matchup, 100)
    pcall(vim.api.nvim_del_augroup_by_id, matchup_group)
  end,
})
