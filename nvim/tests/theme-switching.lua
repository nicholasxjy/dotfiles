-- Run with: nvim --headless -i NONE "+luafile tests/theme-switching.lua"
vim.defer_fn(function()
  local ok, err = xpcall(function()
    vim.v.errmsg = ""
    assert(vim.g.colors_name == "minischeme", "startup theme should be minischeme")
    assert(package.loaded["tokyonight.config"] == nil, "tokyonight should stay lazy at startup")
    assert(package.loaded["catppuccin"] == nil, "catppuccin should stay lazy at startup")

    local initial_tokyonight_options
    local setup_counts = {}
    for _, name in ipairs({ "catppuccin", "mini-hues", "tokyonight" }) do
      local module = require("theme." .. name)
      local setup = module.setup
      setup_counts[name] = 0
      module.setup = function(...)
        setup_counts[name] = setup_counts[name] + 1
        setup(...)
        if name == "tokyonight" and not initial_tokyonight_options then
          initial_tokyonight_options = vim.deepcopy(require("tokyonight.config").options)
        end
      end
    end

    -- Exercise the same command used by picker previews, before the plugin is loaded.
    vim.cmd.colorscheme("catppuccin-mocha")
    assert(vim.g.colors_name == "catppuccin-mocha", "cold theme switch failed")

    for _ = 1, 2 do
      for _, name in ipairs({
        "catppuccin-latte",
        "catppuccin-frappe",
        "catppuccin-macchiato",
        "catppuccin-mocha",
        "minispring",
        "minisummer",
        "miniautumn",
        "miniwinter",
        "randomhue",
        "minischeme",
        "tokyonight-night",
        "tokyonight-storm",
        "tokyonight-day",
        "tokyonight-moon",
        "habamax",
      }) do
        vim.cmd.colorscheme(name)
        assert(vim.g.colors_name == name, "failed to switch to " .. name)
      end
    end

    for _, style in ipairs({ "mocha", "latte", "frappe", "macchiato" }) do
      local name = "catppuccin-" .. style
      vim.cmd.colorscheme(name)
      vim.cmd.colorscheme(style == "latte" and "tokyonight-moon" or "tokyonight-day")
      vim.cmd.colorscheme(name)
      assert(vim.g.colors_name == name, "another theme's background changed " .. name)
    end
    vim.cmd.colorscheme("catppuccin-mocha")
    vim.o.background = "light"
    assert(vim.g.colors_name == "catppuccin-latte", "light background switch failed")
    vim.o.background = "dark"
    assert(vim.g.colors_name == "catppuccin-mocha", "dark background switch failed")

    local theme = require("theme")
    theme.load("catppuccin-latte")
    assert(vim.g.colors_name == "catppuccin-latte", "theme variant silently fell back")
    theme.load("catppuccin")
    assert(vim.g.colors_name == "catppuccin-frappe", "Catppuccin alias failed")
    theme.load("mini-hues")
    assert(vim.g.colors_name == "minischeme", "mini.hues alias failed")
    local palette = require("mini.hues").get_palette()
    assert(vim.api.nvim_get_hl(0, { name = "Comment" }).fg == tonumber(palette.fg_mid:sub(2), 16))
    theme.load("tokyonight-day")
    assert(vim.g.colors_name == "tokyonight-day", "Tokyo Night variant failed")

    assert(vim.fn.maparg("<leader>fC", "n") ~= "", "theme picker keymap missing")
    require("fzf-lua.actions").colorscheme({ "catppuccin-mocha" }, {})
    assert(vim.g.colors_name == "catppuccin-mocha", "picker selection failed")
    assert(initial_tokyonight_options ~= nil, "Tokyo Night setup never ran")
    theme.load("tokyonight")
    assert(vim.g.colors_name == "tokyonight-" .. initial_tokyonight_options.style, "default Tokyo Night style changed")
    assert(setup_counts.catppuccin == 1, "Catppuccin setup ran more than once")
    assert(setup_counts["mini-hues"] == 0, "mini.hues setup repeated after startup")
    assert(setup_counts.tokyonight == 1, "Tokyo Night setup ran more than once")
    local options = require("tokyonight.config").options
    assert(vim.deep_equal(options.styles, initial_tokyonight_options.styles), "theme styles changed")
    assert(options.day_brightness == initial_tokyonight_options.day_brightness, "theme brightness changed")
    assert(vim.v.errmsg == "", vim.v.errmsg)
    print("PASS: cold/repeated theme switches, variants, picker, highlights, and setup counts")
  end, debug.traceback)
  if not ok then
    io.stderr:write(tostring(err) .. "\n")
    vim.cmd("cquit 1")
  else
    vim.cmd("qa!")
  end
end, 200)
