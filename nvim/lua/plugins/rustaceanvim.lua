return {
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
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
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    ft = { "rust" },
    opts = {
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
    },
    config = function(_, opts)
      local codelldb_path = vim.fn.exepath("codelldb")
      ---@diagnostic disable-next-line: undefined-field
      local this_os = vim.uv.os_uname().sysname

      local liblldb_path = vim.fn.expand("$HOME/.local/share/nvim/mason/share/lldb")
      -- The path in windows is different
      if this_os:find("Windows") then
        liblldb_path = liblldb_path .. "\\bin\\lldb.dll"
      else
        -- The liblldb extension is .so for linux and .dylib for macOS
        liblldb_path = liblldb_path .. "/lib/liblldb" .. (this_os == "Linux" and ".so" or ".dylib")
      end
      opts.dap = {
        adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path),
      }
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
      if vim.fn.executable("rust-analyzer") == 0 then
        Snacks.notify.error(
          "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
          { title = "rustaceanvim" }
        )
      end
    end,
  },
}
