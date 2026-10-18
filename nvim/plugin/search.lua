local loader = require("loader")

local function setup_grug_far()
  loader.packadd("grug-far.nvim")
  require("grug-far").setup()
end

local function grug_available(engine)
  local binary = engine and engine:match("^astgrep") and "ast-grep" or "rg"
  if vim.fn.executable(binary) == 1 then
    return true
  end
  vim.notify("Find and replace requires " .. binary, vim.log.levels.WARN)
  return false
end

for _, command in ipairs({ "GrugFar", "GrugFarWithin" }) do
  vim.api.nvim_create_user_command(command, function(ctx)
    if grug_available(ctx.fargs[1]) and loader.load("grug-far", setup_grug_far) then
      vim.api.nvim_cmd({
        cmd = command,
        args = ctx.fargs,
        mods = ctx.smods,
        range = ctx.range > 0 and { ctx.line1, ctx.line2 } or nil,
      }, {})
    end
  end, {
    nargs = "?",
    range = true,
    complete = function(lead)
      if loader.load("grug-far", setup_grug_far) then
        return vim.fn.getcompletion(command .. " " .. lead, "cmdline")
      end
      return {}
    end,
    desc = "Project find and replace",
  })
end

vim.keymap.set({ "n", "v" }, "<leader>sr", function()
  if not grug_available() or not loader.load("grug-far", setup_grug_far) then
    return
  end
  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
  require("grug-far").open({
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
    },
  })
end, { desc = "Find and replace" })

loader.on_very_lazy("search", function()
  loader.packadd("fzf-lua", "fzf-lua-smart", "snacks.nvim")

  require("snacks").setup({
    explorer = {
      enabled = true,
      -- Leave directory buffers to Oil.
      replace_netrw = false,
    },
    image = {
      enabled = true,
      formats = {
        "png",
        "jpg",
        "jpeg",
        "gif",
        "bmp",
        "webp",
        "tiff",
        "heic",
        "avif",
        "mp4",
        "mov",
        "avi",
        "mkv",
        "webm",
        "pdf",
        "icns",
      },
    },
    picker = {
      enabled = true,
      ui_select = false,
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          layout = { layout = { position = "left", width = 32 } },
        },
      },
    },
  })

  vim.keymap.set("n", "<leader>e", function()
    Snacks.explorer()
  end, { desc = "Toggle File Explorer", silent = true })

  local fzflua = require("fzf-lua")
  local fzfluasmart = require("fzf-lua-smart")

  fzflua.setup({
    "border-fused",
    fzf_colors = true,
    winopts = {
      -- A split replaces the float, so float geometry/border options don't apply.
      split = "belowright new",
      treesitter = {
        enabled = true,
      },
      preview = {
        border = "border-top",
        title = true,
        title_pos = "left",
        vertical = "down:50%",
        horizontal = "right:50%",
        layout = "vertical",
      },
    },
    defaults = {
      formatter = "path.filename_first",
    },
  })

  fzfluasmart.setup({
    matcher = {
      fuzzy = true,
      smartcase = true,
      ignorecase = true,
      sort_empty = true,
      filename_bonus = true,
      file_pos = true,
      cwd_bonus = true,
      frecency = true,
      history_bonus = true,
    },
    sort = { fields = { "score:desc", "#text", "idx" } },
    filter = { cwd = true },
    hidden = true,
    multiprocess = true,
  })

  -- Fzf-lua keymaps
  vim.keymap.set("n", "<leader><space>", function()
    -- Everything else comes from the fzfluasmart.setup() defaults above.
    fzfluasmart.smart({ git_icons = true })
  end, { desc = "Smart files" })

  vim.keymap.set("n", "<leader>h", function()
    fzflua.buffers({
      sort_lastused = true,
      ignore_current_buffer = false,
    })
  end, { desc = "Find Buffers", silent = true, nowait = true })

  vim.keymap.set("n", "<leader><cr>", fzflua.resume, { desc = "Resume Search" })
  vim.keymap.set("n", "<leader>:", fzflua.commands, { desc = "Commands" })
  vim.keymap.set("n", "<leader>/", fzflua.grep_curbuf, { desc = "Grep Curbuf" })
  vim.keymap.set("n", "<leader>m", fzflua.marks, { desc = "Marks" })

  vim.keymap.set("n", "<leader>fg", fzflua.global, { desc = "Global" })
  vim.keymap.set("n", "<leader>ff", fzflua.files, { desc = "Files" })
  vim.keymap.set("n", "<leader>fa", fzflua.autocmds, { desc = "Autocmds" })
  vim.keymap.set("n", "<leader>fC", fzflua.colorschemes, { desc = "Colorschemes" })
  vim.keymap.set("n", "<leader>fc", fzflua.command_history, { desc = "Command History" })
  vim.keymap.set("n", "<leader>fi", fzflua.filetypes, { desc = "Filetypes" })
  vim.keymap.set("n", "<leader>fl", fzflua.loclist, { desc = "Location" })
  vim.keymap.set("n", "<leader>fk", fzflua.keymaps, { desc = "Keymaps" })
  vim.keymap.set("n", "<leader>fh", fzflua.highlights, { desc = "Highlights" })
  vim.keymap.set("n", "<leader>fr", fzflua.registers, { desc = "Registers" })
  vim.keymap.set("n", "<leader>fu", fzflua.undotree, { desc = "Undos" })
  vim.keymap.set("n", "<leader>fq", fzflua.quickfix, { desc = "Quickfix" })
  vim.keymap.set("n", "<leader>fs", fzflua.search_history, { desc = "Search History" })

  vim.keymap.set("n", "<leader>sw", fzflua.grep_cword, { desc = "Grep word" })
  vim.keymap.set("x", "<leader>sv", fzflua.grep_visual, { desc = "Grep Visual" })
  vim.keymap.set("n", "<leader>sg", fzflua.live_grep, { desc = "Live Grep" })
  vim.keymap.set("n", "<leader>xt", function()
    fzflua.grep({
      search = [[\b(TODO|FIXME|HACK|NOTE)\b]],
      no_esc = true,
      prompt = "TODO❯ ",
    })
  end, { desc = "Find TODO/FIXME/HACK/NOTE" })
end)
