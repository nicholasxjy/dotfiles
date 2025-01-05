local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function is_visible(cmp)
  return cmp.core.view:visible() or vim.fn.pumvisible() == 1
end

return {
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
    },
    opts = function()
      local cmp = require("cmp")
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        preselect = cmp.PreselectMode.Item,
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        sources = cmp.config.sources({
          { name = "lazydev", priority = 1100 },
          { name = "nvim_lsp", priority = 1000 },
          { name = "path", priority = 250 },
          { name = "buffer", priority = 500, group_index = 2 },
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local completion_item = entry:get_completion_item()
            local highlights_info = require("colorful-menu").highlights(completion_item, vim.bo.filetype)

            -- error, such as missing parser, fallback to use raw label.
            if highlights_info == nil then
              vim_item.abbr = completion_item.label
            else
              vim_item.abbr_hl_group = highlights_info.highlights
              vim_item.abbr = highlights_info.text
            end

            local kind = require("lspkind").cmp_format({
              mode = "symbol_text",
              symbol_map = { Codeium = "", Copilot = "" },
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            vim_item.kind = " " .. (strings[1] or "") .. " "
            vim_item.menu = ""

            return vim_item
          end,
        },
        mapping = {
          ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-P>"] = cmp.mapping(function()
            if is_visible(cmp) then
              cmp.select_prev_item()
            else
              cmp.complete()
            end
          end),
          ["<C-N>"] = cmp.mapping(function()
            if is_visible(cmp) then
              cmp.select_next_item()
            else
              cmp.complete()
            end
          end),
          ["<C-K>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<C-J>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<C-U>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-D>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-Y>"] = cmp.config.disable,
          ["<C-E>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c" }),
          ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "c" }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if is_visible(cmp) then
              cmp.select_next_item()
            elseif vim.api.nvim_get_mode().mode ~= "c" and vim.snippet and vim.snippet.active({ direction = 1 }) then
              vim.schedule(function()
                vim.snippet.jump(1)
              end)
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if is_visible(cmp) then
              cmp.select_prev_item()
            elseif vim.api.nvim_get_mode().mode ~= "c" and vim.snippet and vim.snippet.active({ direction = -1 }) then
              vim.schedule(function()
                vim.snippet.jump(-1)
              end)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
      }
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = vim.fn.has("win32") == 0
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
      or nil,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      region_check_events = "CursorMoved",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "saadparwaiz1/cmp_luasnip" },
    opts = function(_, opts)
      local luasnip, cmp = require("luasnip"), require("cmp")

      if not opts.snippet then
        opts.snippet = {}
      end
      opts.snippet.expand = function(args)
        luasnip.lsp_expand(args.body)
      end

      if not opts.sources then
        opts.sources = {}
      end
      table.insert(opts.sources, { name = "luasnip", priority = 750 })

      if not opts.mappings then
        opts.mappings = {}
      end
      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if is_visible(cmp) then
          cmp.select_next_item()
        elseif vim.api.nvim_get_mode().mode ~= "c" and luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" })
      opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
        if is_visible(cmp) then
          cmp.select_prev_item()
        elseif vim.api.nvim_get_mode().mode ~= "c" and luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" })
    end,
  },
  { -- override nvim-cmp plugin
    "hrsh7th/nvim-cmp",
    keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
    dependencies = {
      "hrsh7th/cmp-cmdline", -- add cmp-cmdline as dependency of cmp
    },
    config = function(plugin, opts)
      local cmp = require("cmp")
      -- run cmp setup
      cmp.setup(opts)

      -- configure `cmp-cmdline` as described in their repo: https://github.com/hrsh7th/cmp-cmdline#setup
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, { name = "codeium", priority = 900 })
    end,
  },
}
