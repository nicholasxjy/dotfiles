local util = require("util")

local function persistence()
  util.ensure_plugin("persistence.nvim", function()
    require("persistence").setup({
      dir = vim.fn.stdpath("state") .. "/sessions/",
      need = 1,
      branch = true,
    })
  end, false)

  return require("persistence")
end

vim.keymap.set("n", "<leader>S", function()
  persistence().select()
end, { desc = "Select session" })

local function setup_screenkey()
  util.ensure_plugin("screenkey.nvim", function()
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
  end)
end

vim.api.nvim_create_user_command("Screenkey", function(args)
  pcall(vim.api.nvim_del_user_command, "Screenkey")
  setup_screenkey()
  local cmd = "Screenkey"
  if args.bang then
    cmd = cmd .. "!"
  end
  if args.args ~= "" then
    cmd = cmd .. " " .. args.args
  end
  vim.cmd(cmd)
end, { nargs = "*", bang = true, desc = "Toggle Screenkey" })

local function treesj()
  util.ensure_plugin("treesj", function()
    require("treesj").setup({ use_default_keymaps = false })
  end, false)

  return require("treesj")
end

vim.keymap.set("n", "gS", function()
  treesj().toggle()
end, { desc = "Toggle Split" })

local function setup_rainbow_delimiters()
  util.ensure_plugin("rainbow-delimiters.nvim", function()
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
  end)
end

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("RainbowDelimitersDeferred", { clear = true }),
  once = true,
  callback = function()
    vim.schedule(setup_rainbow_delimiters)
  end,
})

vim.g.visual_whitespace = {
  enabled = true,
  highlight = { link = "LineNr", default = true },
  match_types = {
    space = true,
    tab = true,
    nbsp = true,
    lead = true,
    trail = false,
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
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("VisualWhitespaceDeferred", { clear = true }),
  once = true,
  callback = function()
    util.packadd("visual-whitespace.nvim")
  end,
})

local function jishiben()
  util.ensure_plugin("jishiben.nvim", function()
    local width = math.max(1, vim.o.columns)
    local height = math.max(1, math.floor(vim.o.lines * 0.4) - 2)
    require("jishiben").setup({
      win = {
        border = "rounded",
        width = width,
        height = height,
        row = vim.o.lines - height - 2,
        col = 0,
      },
    })
  end, false)

  return require("jishiben")
end

vim.api.nvim_create_user_command("JishibenOpen", function()
  jishiben().open()
end, { desc = "Open Jishiben" })

vim.api.nvim_create_user_command("JishibenClear", function()
  jishiben().clear_all()
  vim.notify("Jishiben: all notes cleared")
end, { desc = "Clear Jishiben notes" })

local function setup_editor_buffer_plugins()
  util.ensure_plugin("todo-comments.nvim", function()
    require("todo-comments").setup()
  end)

  util.ensure_plugin("nvim-highlight-colors", function()
    require("nvim-highlight-colors").setup({})
  end)
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("EditorBufferPluginsDeferred", { clear = true }),
  once = true,
  callback = function()
    vim.schedule(setup_editor_buffer_plugins)
  end,
})
