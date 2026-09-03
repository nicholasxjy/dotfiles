local loader = require("loader")

local function setup()
  loader.packadd("snacks.nvim")
  local ui = require("ui")

  require("snacks").setup({
    animate = { enabled = false },
    dashboard = { enabled = false },
    explorer = { enabled = true, replace_netrw = false },
    image = { enabled = true },
    dim = { enabled = false },
    bigfile = { enabled = true },
    zen = { enabled = false },
    scroll = { enabled = false },
    input = { enabled = true },
    words = { enabled = false },
    indent = { enabled = false },
    statuscolumn = { enabled = false },
    notifier = { enabled = false },
    toggle = { enabled = true },
    lazygit = { enabled = true },
    terminal = { enabled = true },
    scope = { enabled = true },
    gitbrowse = { enabled = true },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
        },
      },
      prompt = "> ", -- --
      ui_select = true,
      layout = {
        circle = false,
        hidden = { "preview" },
        layout = {
          box = "vertical",
          backdrop = false,
          row = -1,
          width = 0,
          height = 0.3,
          border = "none",
          title = " {title} {live} {flags}",
          title_pos = "left",
          { win = "input", height = 1, border = "none" },
          {
            box = "horizontal",
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", width = 0.6, border = "left" },
          },
        },
      },
      matcher = {
        cwd_bonus = true,
        frecency = true,
        history_bonus = true,
      },
      formatters = {
        file = {
          filename_first = true,
          truncate = "center",
          git_status_hl = true,
        },
        severity = {
          icons = true, -- show severity icons
          level = true, -- show severity level
          pos = "left", -- position of the diagnostics
        },
      },
      icons = { kinds = ui.icons.lspkind_kind_icons },
      win = {
        wo = {
          winhl = true,
        },
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<a-a>"] = {
              "sidekick_send",
              mode = { "n", "i" },
            },
          },
        },
        list = {
          keys = {
            ["<c-j>"] = "list_down",
            ["<c-k>"] = "list_up",
            ["<c-n>"] = "list_down",
            ["<c-p>"] = "list_up",
          },
        },
      },
    },
  })

  require("minibuffer.integrations.snacks-picker").setup({
    smart = { git_status = true },
    pickers = {
      explorer = false,
    },
  })

  Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
  Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
  Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
  Snacks.toggle.diagnostics():map("<leader>ud")
  Snacks.toggle.line_number():map("<leader>ul")
  Snacks.toggle
    .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
    :map("<leader>uc")
  Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
  Snacks.toggle.inlay_hints():map("<leader>uh")
  Snacks.toggle.indent():map("<leader>ug")
  Snacks.toggle.dim():map("<leader>uD")

  vim.keymap.set("n", "<leader>E", function()
    Snacks.explorer({
      layout = ui.snacks_layout.sidebar,
    })
  end, { desc = "Explorer" })

  vim.keymap.set("n", "<leader>ff", function()
    Snacks.picker.files()
  end, { desc = "Find Files", silent = true })

  vim.keymap.set("n", "<leader><space>", function()
    Snacks.picker.smart()
  end, { desc = "Smart", silent = true })

  vim.keymap.set("n", "<leader>h", function()
    Snacks.picker.buffers({
      sort_lastused = true,
      filter = { cwd = true },
      current = true,
    })
  end, { desc = "Buffers", silent = true })

  vim.keymap.set("n", "<leader><cr>", function()
    Snacks.picker.resume()
  end, { desc = "Resume", silent = true })

  vim.keymap.set("n", "<leader>sg", function()
    Snacks.picker.grep()
  end, { desc = "Grep", silent = true })

  vim.keymap.set("n", "<leader>sw", function()
    Snacks.picker.grep_word()
  end, { desc = "Grep word", silent = true })

  vim.keymap.set("n", "<leader>xt", function()
    ---@diagnostic disable-next-line: undefined-field
    Snacks.picker.todo_comments()
  end, { desc = "TODO/FIXME/NOTE etc" })
end

loader.on_very_lazy("snacks", setup)
