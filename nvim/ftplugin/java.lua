local util = require("utils.util")

local root_dir = util.get_raw_config("jdtls").default_config.root_dir

-- How to find the project name for a given root dir.
local project_name = root_dir and vim.fs.basename(root_dir)

-- where are the config and workspace dirs for a project?
local jdtls_config_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
local jdtls_workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
local lombok_jar = vim.fn.expand("$HOME/.local/share/nvim/mason/share/jdtls/lombok.jar")

local cmd = {
  vim.fn.exepath("jdtls"),
  string.format("--jvm-arg=-javaagent:%s", lombok_jar),
  "-configuration",
  jdtls_config_dir,
  "-data",
  jdtls_workspace_dir,
}

local config = {
  cmd = cmd,
  root_dir = root_dir,
  init_options = {
    bundles = {
      vim.fn.expand(
        "$HOME/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"
      ),
      -- unpack remaining bundles
      (table.unpack or unpack)(
            vim.split(vim.fn.glob("$HOME/.local/share/nvim/mason/share/java-test/*.jar"), "\n", {})
          ),
    },
  },
  settings = {
    java = {
      eclipse = { downloadSources = true },
      configuration = { updateBuildConfiguration = "interactive" },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      inlayHints = { parameterNames = { enabled = "all" } },
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
    },
  },
  capabilities = require("blink.cmp").get_lsp_capabilities(nil, true),
}


require("jdtls").start_or_attach(config)
