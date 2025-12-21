-- How to find the project name for a given root dir.
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_extend("force", capabilities, {
  offsetEncoding = { "utf-16" },
})

local config = {
  name = "jdtls",
  cmd = cmd,
  root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw", "pom.xml" }),
  init_options = {
    bundles = {
      vim.fn.expand("$HOME/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
      -- unpack remaining bundles
      (table.unpack or unpack)(vim.split(vim.fn.glob("$HOME/.local/share/nvim/mason/share/java-test/*.jar"), "\n", {})),
    },
  },
  capabilities = capabilities,
  settings = {
    java = {
      eclipse = { downloadSources = true },
      configuration = {
        updateBuildConfiguration = "interactive",
        -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        runtimes = {
          {
            name = "JavaSE-1.8",
            path = "/Library/Java/JavaVirtualMachines/temurin-8.jdk/Contents/Home",
          },
          {
            default = true,
            name = "JavaSE-21",
            path = "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home",
          },
        },
      },
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
}

require("jdtls").start_or_attach(config)
