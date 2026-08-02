local loader = require("loader")

local function setup_crates()
  require("crates").setup({
    completion = {
      crates = {
        enabled = true,
      },
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

local setup = function()
  vim.cmd.packadd("rustaceanvim")

  local function rustaceanvim_opts()
    return {
      tools = {
        float_win_config = {
          border = "rounded",
        },
      },
      server = {
        on_attach = function(_, bufnr) end,
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
    }
  end

  local function rustaceanvim_dap_adapter()
    local codelldb_path = vim.fn.exepath("codelldb")
    ---@diagnostic disable-next-line: undefined-field
    local this_os = vim.uv.os_uname().sysname

    local liblldb_path = vim.fn.expand("$HOME/.local/share/nvim/mason/share/lldb")
    if this_os:find("Windows") then
      liblldb_path = liblldb_path .. "\\bin\\lldb.dll"
    else
      liblldb_path = liblldb_path .. "/lib/liblldb" .. (this_os == "Linux" and ".so" or ".dylib")
    end

    return require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
  end

  vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, rustaceanvim_opts())

  if vim.fn.executable("rust-analyzer") == 0 then
    require("snacks").notify.error(
      "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
      { title = "rustaceanvim" }
    )
  end

  vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, {
    dap = {
      adapter = rustaceanvim_dap_adapter(),
    },
  })
end

setup()
