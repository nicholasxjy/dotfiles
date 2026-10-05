local loader = require("loader")

-- ============================================================================
-- Markdown (render-markdown & markdown-preview)
-- ============================================================================
local function setup_markdown()
  vim.g.mkdp_filetypes = { "markdown" }
  loader.packadd("markdown-preview.nvim", "render-markdown.nvim")

  require("render-markdown").setup({
    enabled = true,
    file_types = { "markdown" },
    completions = { blink = { enabled = true }, lsp = { enabled = false } },
    code = {},
  })
end

loader.defer("markdown", setup_markdown, { "BufReadPre", "BufNewFile" }, { pattern = { "*.md", "*.mdx" } })

-- ============================================================================
-- Rust (rustaceanvim & crates.nvim)
-- ============================================================================
local function setup_crates()
  loader.packadd("crates.nvim")
  require("crates").setup({
    completion = {
      crates = { enabled = true },
    },
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
  })
end

local crates_group = vim.api.nvim_create_augroup("sjvim_crates", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = crates_group,
  pattern = "Cargo.toml",
  callback = function()
    loader.load("crates", setup_crates)
  end,
})

local function setup_rust()
  loader.packadd("rustaceanvim")

  if vim.fn.executable("rust-analyzer") == 0 then
    vim.notify("rust-analyzer not found in PATH (install it with :MasonToolsInstall)", vim.log.levels.WARN)
  end

  local liblldb = vim.fn.stdpath("data") .. "/mason/share/lldb/lib/liblldb"
  liblldb = liblldb .. (vim.uv.os_uname().sysname == "Linux" and ".so" or ".dylib")

  -- rustaceanvim reads vim.g.rustaceanvim lazily from its ftplugin, which runs
  -- after this BufReadPre hook.
  vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, {
    tools = {
      float_win_config = {
        border = "rounded",
      },
    },
    server = {
      default_settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },
          checkOnSave = true,
          diagnostics = {
            enable = true,
          },
          procMacro = {
            enable = true,
            ignored = {
              ["async-trait"] = { "async_trait" },
              ["napi-derive"] = { "napi" },
              ["async-recursion"] = { "async_recursion" },
            },
          },
          files = {
            excludeDirs = {
              ".direnv",
              ".git",
              ".github",
              ".gitlab",
              "bin",
              "node_modules",
              "target",
              "venv",
              ".venv",
            },
          },
        },
      },
    },
    dap = {
      adapter = require("rustaceanvim.config").get_codelldb_adapter(vim.fn.exepath("codelldb"), liblldb),
    },
  })
end

loader.defer("rust", setup_rust, { "BufReadPre", "BufNewFile" }, { pattern = "*.rs" })
