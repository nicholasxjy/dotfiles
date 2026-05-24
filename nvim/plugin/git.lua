local util = require("util")

local function setup_minifugit()
  util.ensure_plugin("minifugit.nvim", function()
    require("minifugit").setup({
      preview = {
        wrap = false,
        show_line_numbers = true,
        show_metadata = true,
        diff_layout = "stacked",
        diff_auto_threshold = 120,
      },
      status = {
        width = 0.4,
        min_width = 20,
      },
    })
  end, false)

  return require("minifugit")
end

vim.api.nvim_create_user_command("MinifugitStatus", function()
  setup_minifugit().status()
end, {
  desc = "Open Minifugit status",
})

local function buffer_in_git_repo(bufnr)
  if vim.bo[bufnr].buftype ~= "" then
    return false
  end

  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local start = bufname ~= "" and vim.fs.dirname(bufname) or vim.fn.getcwd()
  return vim.fs.find(".git", { upward = true, path = start })[1] ~= nil
end

local function setup_gitsigns(bufnr)
  util.ensure_plugin("gitsigns.nvim", function()
    local gs = require("gitsigns")

    gs.setup({
      signs = {
        add = { text = "▎" },
        change = { text = "┋" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "?" },
      },
      signcolumn = false,
      current_line_blame = true,
      on_attach = function(buffer)
        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = buffer, desc = desc })
        end

        map("]h", gs.next_hunk, "Next Hunk")
        map("[h", gs.prev_hunk, "Prev Hunk")
      end,
    })

    if bufnr and vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buftype == "" then
      vim.schedule(function()
        gs.attach({ bufnr = bufnr, trigger = "manual-init" })
      end)
    end
  end, false)
end

local gitsigns_group = vim.api.nvim_create_augroup("GitsignsDeferredSetup", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = gitsigns_group,
  callback = function(ev)
    if not buffer_in_git_repo(ev.buf) then
      return
    end
    setup_gitsigns(ev.buf)
    pcall(vim.api.nvim_del_augroup_by_id, gitsigns_group)
  end,
})

local function setup_diffs()
  util.ensure_plugin("diffs.nvim", function()
    vim.g.diffs = {
      integrations = {
        fugitive = true,
        neogit = true,
        neojj = true,
        gitsigns = true,
      },
    }
  end, false)
end

local function setup_codediff()
  util.ensure_plugin("codediff.nvim", function()
    require("codediff").setup({
      explorer = {
        view_mode = "tree",
      },
      history = {
        view_mode = "tree",
      },
    })

    require("codediff.core.virtual_file").setup()
    require("codediff.ui.highlights").setup()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("CodeDiffHighlights", { clear = true }),
      callback = function()
        require("codediff.ui.highlights").setup()
      end,
    })
  end, false)
end

vim.api.nvim_create_user_command("CodeDiff", function(opts)
  setup_codediff()
  require("codediff.commands").vscode_diff(opts)
end, {
  nargs = "*",
  bang = true,
  range = true,
  desc = "VSCode-style diff view",
})

vim.api.nvim_create_user_command("VscodeDiff", function(opts)
  setup_codediff()
  require("codediff.commands").vscode_diff(opts)
end, {
  nargs = "*",
  bang = true,
  range = true,
  desc = "VSCode-style diff view",
})

vim.api.nvim_create_user_command("Gdiff", function(opts)
  setup_diffs()
  require("diffs.commands").gdiff(opts.args ~= "" and opts.args or nil, false)
end, {
  nargs = "*",
  desc = "Show unified diff against a Fugitive object",
})

vim.api.nvim_create_user_command("Gvdiff", function(opts)
  setup_diffs()
  require("diffs.commands").gdiff(opts.args ~= "" and opts.args or nil, true)
end, {
  nargs = "*",
  desc = "Show unified diff against a Fugitive object in vertical split",
})

vim.api.nvim_create_user_command("Ghdiff", function(opts)
  setup_diffs()
  require("diffs.commands").gdiff(opts.args ~= "" and opts.args or nil, false)
end, {
  nargs = "*",
  desc = "Show unified diff against a Fugitive object in horizontal split",
})

vim.api.nvim_create_user_command("Greview", function(opts)
  setup_diffs()
  local review = require("diffs.review")
  local spec, err = review.parse_arg(opts.args ~= "" and opts.args or nil)
  if not spec then
    vim.notify(err, vim.log.levels.ERROR)
    return
  end

  require("diffs.commands").greview(spec)
end, {
  nargs = "?",
  complete = function(arglead)
    setup_diffs()
    return require("diffs.review").complete(arglead)
  end,
  desc = "Review the repo against the default branch or a git review spec",
})
