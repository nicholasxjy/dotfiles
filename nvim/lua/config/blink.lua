local ui = require("ui")

local excmds_cache = {}
local function populate_excmds_cache()
  local ts = vim.treesitter

  local path = vim.api.nvim_get_runtime_file("doc/index.txt", false)[1]
  local bufnr = vim.fn.bufadd(path)
  local buf_was_already_loaded = vim.api.nvim_buf_is_loaded(bufnr)
  if not buf_was_already_loaded then
    vim.fn.bufload(bufnr)
  end

  local parser = ts.get_parser(bufnr, "vimdoc")
  local tree = assert(parser):parse()[1]
  local root = tree:root()
  local query = ts.query.parse(
    "vimdoc",
    [[
    (h1 (tag text: (_) @tag) (#eq? @tag "ex-cmd-index")) @heading
    (block (line (column_heading))) @block
  ]]
  )

  local ex_cmd_heading_end
  local target_block
  for id, node, _ in query:iter_captures(root, bufnr, 0, -1) do
    local name = query.captures[id]
    if name == "heading" then
      ex_cmd_heading_end = select(3, node:range())
    end
    if name == "block" and ex_cmd_heading_end and node:start() >= ex_cmd_heading_end then
      target_block = node
      break
    end
  end

  local text = ts.get_node_text(target_block, bufnr)
  local lines = vim.split(text, "\n")
  local pattern = "^|:([^|]+)|%s+:%S+%s+(.+)$"
  for i, line in ipairs(lines) do
    local cmd, description = line:match(pattern)
    if cmd then
      -- HACK: some descriptions in index.txt are wrapped to
      -- the next line. I want to append those bits to this line
      -- and this heuristic seems to work
      local next_line = lines[i + 1]
      if next_line and not vim.startswith(next_line, "|:") then
        description = description .. " " .. vim.trim(next_line)
      end
      excmds_cache[cmd] = description
    end
  end

  -- clean up after ourselves
  if not buf_was_already_loaded then
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end
end

local usercmds_cache = {}
local function populate_usercmds_cache()
  for cmd, cmd_spec in pairs(vim.api.nvim_get_commands({})) do
    usercmds_cache[cmd] = cmd_spec.desc ~= "" and cmd_spec.desc
      or cmd_spec.definition ~= "" and cmd_spec.definition
      or ""
  end
end

local get_kind_hl = function(ctx)
  local kinds = require("blink.cmp.types").CompletionItemKind
  if ctx.item.kind ~= kinds.Color then
    return
  end

  local ok, highlight_colors = pcall(require, "nvim-highlight-colors")
  local doc = vim.tbl_get(ctx, "item", "documentation")
  if not ok or not doc then
    return
  end

  local color_item = highlight_colors.format(doc, { kind = kinds[kinds.Color] })
  return color_item and color_item.abbr_hl_group
end

local blink_opts = {
  fuzzy = { implementation = "prefer_rust_with_warning", sorts = { "exact", "score", "sort_text" } },
  keymap = {
    preset = "enter",
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
  },
  signature = {
    enabled = true,
    window = {
      show_documentation = false,
    },
  },
  appearance = {
    -- Icons in ui.icons.default_kind_icons include trailing spaces (non-mono nerd font).
    nerd_font_variant = "normal",
    kind_icons = ui.icons.default_kind_icons,
  },
  completion = {
    ghost_text = { enabled = false },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
      update_delay_ms = 250,
    },
    accept = { auto_brackets = { enabled = true } },
    list = { selection = { preselect = true, auto_insert = false } },
    menu = {
      scrollbar = true,
      draw = {
        treesitter = { "lsp" },
        -- Keep kind_icon in its own column so appearance.kind_icons always renders.
        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
        components = {
          kind_icon = {
            text = function(ctx)
              -- Resolve from appearance.kind_icons explicitly (do not use mini.icons
              -- for the glyph — that would ignore appearance.kind_icons).
              local icons = require("blink.cmp.config").appearance.kind_icons
              local icon = icons[ctx.kind] or ctx.kind_icon
              return icon
            end,
            highlight = function(ctx)
              -- priority 20000 beats CursorLine so kind colors stay visible
              local hl = get_kind_hl(ctx)
              if not hl then
                _, hl = require("mini.icons").get("lsp", ctx.kind)
              end
              return { { group = hl or ctx.kind_hl, priority = 20000 } }
            end,
          },
          kind = {
            highlight = function(ctx)
              local hl = get_kind_hl(ctx)
              if not hl then
                _, hl = require("mini.icons").get("lsp", ctx.kind)
              end
              return hl or ctx.kind_hl
            end,
          },
        },
      },
    },
  },
  cmdline = {
    enabled = true,
    keymap = {
      preset = "cmdline",
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
    },
    completion = {
      ghost_text = { enabled = false },
      list = { selection = { preselect = false, auto_insert = true } },
      menu = {
        auto_show = function()
          return vim.fn.getcmdtype() == ":"
        end,
        draw = { columns = { { "label" }, { "label_description" } } },
      },
    },
  },
  snippets = { preset = "luasnip" },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
      cmdline = {
        transform_items = function(ctx, items)
          -- HACK: some labels will incorrectly match descriptions, for example
          -- "lsp stop" will match the "stop" label for ":stop" command
          -- which is incorrect. Here I just check if there are any
          -- whitespaces before the cursor and don't match on those occurances
          local text_before_cursor = ctx.line:sub(1, ctx.cursor[2])
          if text_before_cursor:find("%s") then
            return items
          end

          return vim
            .iter(ipairs(items))
            :map(function(_, item)
              item.labelDetails = item.labelDetails or {}
              item.labelDetails.description = excmds_cache[item.label] or usercmds_cache[item.label] or ""
              return item
            end)
            :totable()
        end,
      },
    },
  },
}

local ls = require("luasnip")
ls.config.set_config({
  enable_autosnippets = true,
  history = true,
  updateevents = "TextChanged,TextChangedI",
})
ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("javascriptreact", { "javascript" })
ls.filetype_extend("typescriptreact", { "javascript" })
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").lazy_load({ paths = { "./snippets" } })

local cmp = require("blink.cmp")
cmp.setup(blink_opts)

vim.schedule(function()
  populate_excmds_cache()
  populate_usercmds_cache()
end)
