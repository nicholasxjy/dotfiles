require("gitsigns").setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  current_line_blame = true,
  on_attach = function(buffer)
    local gs = package.loaded.gitsigns
    local function map(l, r, desc)
      vim.keymap.set("n", l, r, { buffer = buffer, desc = desc })
    end

    map("]h", gs.next_hunk, "Next Hunk")
    map("[h", gs.prev_hunk, "Prev Hunk")
  end,
})

vim.g.diffs = {
  integrations = {
    fugitive = true,
    neogit = true,
    neojj = true,
    gitsigns = true,
  },
}

require("codediff").setup({
  explorer = {
    view_mode = "tree",
  },
  history = {
    view_mode = "tree",
  },
})
