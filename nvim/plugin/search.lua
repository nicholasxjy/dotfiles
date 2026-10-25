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
  loader.packadd("fzf-lua", "fzf-lua-smart", "fzf-lua-image")

  local fzflua = require("fzf-lua")
  local fzfluasmart = require("fzf-lua-smart")
  local minibuffer = require("minibuffer")
  local layout_group = vim.api.nvim_create_augroup("sjvim_fzf_minibuffer_layout", { clear = true })

  require("fzf-lua-image").setup({ enabled = true })

  -- The integration owns window geometry and starts with the preview hidden.
  require("minibuffer.integrations.fzf")({
    fzf_colors = true,
    keymap = {
      builtin = {
        ["<A-p>"] = "toggle-preview",
      },
      fzf = {
        ["alt-p"] = "toggle-preview",
      },
    },
    defaults = {
      -- formatter = "path.filename_first",
      treesitter = {
        enabled = true,
        -- fzf_colors = { ["hl"] = "-1:reverse", ["hl+"] = "-1:reverse" },
      },
      winopts = {
        -- Anchor both windows at the bottom of the minibuffer area.
        row = 1,
        zindex = 201,
        on_create = function(event)
          vim.api.nvim_clear_autocmds({ group = layout_group })
          local update_height = vim.schedule_wrap(function()
            local session = minibuffer.get_active_session()
            if not session or session:type() ~= "scratch" then
              return
            end
            ---@cast session minibuffer.core.ScratchSession
            if session:get_win() ~= event.winid or not vim.api.nvim_win_is_valid(event.winid) then
              return
            end

            local state = require("minibuffer.internal.state")
            local bottom = vim.o.lines
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
              if vim.w[win].fzf_lua_preview then
                local preview = vim.api.nvim_win_get_config(win)
                if not preview.hide then
                  bottom = math.min(bottom, preview.row)
                end
              end
            end
            -- ScratchSession anchors the list to the screen bottom; leave room for the preview below it.
            local config = vim.api.nvim_win_get_config(event.winid)
            if config.row ~= bottom or config.anchor ~= "SW" then
              state.default_nvim_win_set_config(
                event.winid,
                { relative = "editor", anchor = "SW", row = bottom, col = 0 }
              )
            end
            local height = vim.o.lines - bottom + config.height
            if height == vim.o.cmdheight then
              return
            end
            -- cmdheight already resizes splits; saved sizes can be stale after a terminal resize.
            require("minibuffer.internal.util").set_cmdheight(state.win_states, false, height)
          end)
          vim.api.nvim_create_autocmd({ "WinResized", "VimResized" }, {
            group = layout_group,
            callback = update_height,
          })
          update_height()
        end,
        on_close = function()
          vim.api.nvim_clear_autocmds({ group = layout_group })
        end,
        preview = {
          title_pos = "left",
          layout = "vertical",
          vertical = "down:50%",
          border = "single",
        },
      },
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
