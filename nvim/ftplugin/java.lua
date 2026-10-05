local jdtls_bin = vim.fn.exepath("jdtls")
if jdtls_bin == "" then
  vim.notify_once("jdtls not found in PATH (install it with :MasonToolsInstall)", vim.log.levels.WARN)
  return
end

require("loader").packadd("nvim-jdtls")

local mason_share = vim.fn.stdpath("data") .. "/mason/share"
local root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw", "pom.xml" })

-- Name the workspace after the project root, not whatever the cwd happens to be.
local project_name = vim.fn.fnamemodify(root_dir or vim.fn.getcwd(), ":p:h:t")
local jdtls_config_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
local jdtls_workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
local lombok_jar = mason_share .. "/jdtls/lombok.jar"

local cmd = {
  jdtls_bin,
  string.format("--jvm-arg=-javaagent:%s", lombok_jar),
  "-configuration",
  jdtls_config_dir,
  "-data",
  jdtls_workspace_dir,
}

-- jdtls is started directly, not via vim.lsp.enable(), so the shared "*"
-- config (blink.cmp completion capabilities) has to be applied here.
local capabilities = vim.tbl_deep_extend("force", vim.lsp.config["*"].capabilities or {}, {
  offsetEncoding = { "utf-16" },
})

local config = {
  name = "jdtls",
  cmd = cmd,
  root_dir = root_dir,
  init_options = {
    bundles = {
      mason_share .. "/java-debug-adapter/com.microsoft.java.debug.plugin.jar",
      unpack(vim.fn.glob(mason_share .. "/java-test/*.jar", false, true)),
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
