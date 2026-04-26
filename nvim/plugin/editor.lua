require("persistence").setup({
  dir = vim.fn.stdpath("state") .. "/sessions/",
  need = 1,
  branch = true,
})
vim.keymap.set("n", "<leader>S", function()
  require("persistence").select()
end, { desc = "Select session" })

-- screenkey
require("screenkey").setup({
  win_opts = {
    row = vim.o.lines - vim.o.cmdheight - 1,
    col = vim.o.columns - 1,
    relative = "editor",
    anchor = "SE",
    width = 20,
    height = 2,
    border = "single",
    title = "Screenkey",
    title_pos = "center",
    style = "minimal",
    focusable = false,
    noautocmd = true,
  },
  hl_groups = {
    ["screenkey.hl.key"] = { link = "Type" },
    ["screenkey.hl.map"] = { link = "Keyword" },
    ["screenkey.hl.sep"] = { link = "Normal" },
  },
})

-- treesj
vim.keymap.set("n", "gS", function()
  require("treesj").toggle()
end, { desc = "Toggle Split" })

-- rainbow delimiters
require("rainbow-delimiters.setup").setup({
  query = {
    [""] = "rainbow-delimiters",
    javascript = "rainbow-delimiters",
    typescript = "rainbow-delimiters",
    tsx = "rainbow-delimiters",
    typescriptreact = "rainbow-delimiters",

    commonlisp = "rainbow-delimiters",
    scheme = "rainbow-delimiters",
    query = function(bufnr)
      -- Use blocks for read-only buffers like in `:InspectTree`
      local is_nofile = vim.bo[bufnr].buftype == "nofile"
      return is_nofile and "rainbow-blocks" or "rainbow-delimiters"
    end,
    clojure = "rainbow-delimiters",
    html = "rainbow-delimiters",
    lua = "rainbow-delimiters",
    go = "rainbow-delimiters",
    rust = "rainbow-delimiters",
  },
})

vim.g.visual_whitespace = {
  enabled = true,
  highlight = { link = "LineNr", default = true },
  match_types = {
    space = true,
    tab = true,
    nbsp = true,
    lead = true,
    trail = true,
  },
  list_chars = {
    space = "·",
    tab = "↦",
    nbsp = "␣",
    lead = "‹",
    trail = "›",
  },
  fileformat_chars = {
    unix = "↲",
    mac = "←",
    dos = "↙",
  },
  ignore = { filetypes = {}, buftypes = {} },
}
