local loader = require("loader")

local setup = function()
  loader.packadd("differ.nvim", "gitsigns.nvim")

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

  require("differ").setup({
    layout = "split", -- "stacked" | "split", toggleable per-view
    context = math.huge, -- fold threshold; math.huge = whole file, no folds
    wrap = true, -- soft-wrap long lines in the diff view
    diff_counter = true, -- "hunk K/N" counter in the diff window's winbar
    cursorline_tint = true, -- tint the cursor line by add/remove so the change
    deep_diff = {
      enabled = true,
      granularity = "word", -- "word" | "char"
      similarity_threshold = 0.5, -- line-pairing cutoff for word-level diffing
    },
    merge = { -- merge tool pane layout; no per-invocation override
      layout = "default", -- "default" (ours | theirs) | "diff4" (adds base)
    },
    relative_dates = false, -- "3 days ago" instead of YYYY-MM-DD wherever a date shows
    base = nil, -- base branch for `base`/`log base`; nil auto-detects origin/HEAD
    sidecar_bin = nil, -- override the go sidecar path
    command_alias = nil, -- extra :command(s) routing to :Differ, e.g. "D" or { "D", "Df" }
  })
end

loader.defer_buffer("git", setup, { schedule = true })
