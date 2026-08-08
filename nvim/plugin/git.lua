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
    -- kind reads under the cursor; false = plain neutral
    deep_diff = {
      enabled = true,
      granularity = "word", -- "word" | "char"
      similarity_threshold = 0.5, -- line-pairing cutoff for word-level diffing
    },
    comments = { -- pr review threads
      inline = true,
      collapsed = false,
    },
    panel = { -- file panel default placement/size; `:Differ panel`
      -- and the runtime Panel.current() setters override per-session
      position = "right", -- "bottom" | "top" | "left" | "right"
      height = 9, -- top/bottom
      width = 35, -- left/right
      listing = "tree", -- "tree" | "name"
      progress = true, -- "file K/N" position meter in the panel winbar
    },
    history = { -- log/history sidebar default placement/size
      position = "bottom",
      height = 10, -- top/bottom
      width = 40, -- left/right
    },
    merge = { -- merge tool pane layout; no per-invocation override
      layout = "default", -- "default" (ours | theirs) | "diff4" (adds base)
    },
    keymaps = { -- one flat action -> lhs table, shared across the diff,
      -- a value is a string, a list of strings, or false to disable. override globally
      -- here, or scope to one surface via a diff/panel/history/merge = {...} subtable
      next_hunk = "]c", -- diff, panel, history
      prev_hunk = "[c",
      next_file = "]f", -- diff; panel/history step the selection
      prev_file = "[f",
      first_file = "gg", -- panel/history: jump to the first/last file or commit
      last_file = "G",
      next_section = "]]", -- panel: sections (Staged/Unstaged); history: commits
      prev_section = "[[",
      scroll_down = "f", -- all three (shadows native f/b; set false to restore)
      scroll_up = "b",
      select = { "<CR>", "o" }, -- panel, history
      help = "g?", -- panel, history
      toggle_listing = "i", -- panel: toggle tree / name
      close_node = "c", -- panel: collapse the dir under the cursor; history: the commit
      close_all = "C", -- panel/history: collapse every dir / commit
      open_all = "O", -- panel/history: expand every dir / commit
      stage = "s",
      unstage = "u", -- diff (hunk-level), panel (file-level)
      stage_all = "S",
      unstage_all = "U",
      more_context = "d=",
      less_context = "d-", -- diff
      edit_file = "df", -- diff: edit-in-review; pr diff: worktree split beside the pinned diff
      goto_file = "de", -- diff: open the real file and end the session; pr diff: zoom-edit in a tab instead
      discard = "X", -- diff (revert a hunk), panel (discard a file)
      refresh = "R", -- panel
      toggle_fold = "za", -- history (range mode)
      close = "dc", -- diff/panel/history: end the session
      toggle_panel = "dd", -- diff/panel: hide/show the file panel sidebar
      toggle_layout = "dl", -- diff: flip stacked / split
      -- pr review (pr diff + panel)
      toggle_viewed = "<Tab>", -- pr panel: flip the github viewed checkbox
      next_unviewed = "]u",
      prev_unviewed = "[u", -- pr panel + diff
      next_thread = "]t",
      prev_thread = "[t", -- pr diff
      comment = "ga", -- pr diff: comment on the line (normal) or selection (visual)
      reply = "gp", -- pr diff: reply to the thread under the cursor
      delete_comment = "gx", -- pr diff: delete the latest comment of the thread
      toggle_thread = "gc", -- pr diff: collapse/expand the thread under the cursor
      resolve_thread = "gr", -- pr diff: resolve/unresolve the thread under the cursor
      overview = "go", -- pr diff + panel: back to the PR overview home
      review_submit = "gS", -- pr: submit the pending review
      review_discard = "gD", -- pr: discard the pending review and its drafts
      -- merge tool, bound on the result buffer
      next_conflict = "]x",
      prev_conflict = "[x",
      choose_ours = "<leader>co",
      choose_theirs = "<leader>ct",
      choose_base = "<leader>cb",
      choose_all = "<leader>ca", -- take both (ours then theirs)
      choose_none = "<leader>cx", -- drop the conflict region
    },
    relative_dates = false, -- "3 days ago" instead of YYYY-MM-DD wherever a date shows
    base = nil, -- base branch for `base`/`log base`; nil auto-detects origin/HEAD
    sidecar_bin = nil, -- override the go sidecar path
    command_alias = nil, -- extra :command(s) routing to :Differ, e.g. "D" or { "D", "Df" }
  })
end

loader.defer_buffer("git", setup, { schedule = true })
