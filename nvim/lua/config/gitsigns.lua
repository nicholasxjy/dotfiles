local gs = require("gitsigns")

gs.setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "-" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "?" },
  },
  signcolumn = true,
  current_line_blame = true,
  on_attach = function(buffer)
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = buffer, desc = desc })
    end

    map("]h", function()
      gs.nav_hunk("next")
    end, "Next Hunk")
    map("[h", function()
      gs.nav_hunk("prev")
    end, "Prev Hunk")
  end,
})
