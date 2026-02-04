-- Java filetype plugin using nvim-jdtls
-- Enhanced Java development with debugging support

local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
  return
end

local mason_path = vim.fn.stdpath("data") .. "/mason"
local jdtls_path = mason_path .. "/packages/jdtls"
local java_debug_path = mason_path .. "/packages/java-debug-adapter"
local java_test_path = mason_path .. "/packages/java-test"

-- Find root directory
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
local root_dir = require("jdtls.setup").find_root(root_markers)

if root_dir == "" then
  root_dir = vim.fn.getcwd()
end

-- Project name for workspace
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

-- Determine OS
local os_config = "linux"
if vim.fn.has("mac") == 1 then
  os_config = "mac"
elseif vim.fn.has("win32") == 1 then
  os_config = "win"
end

-- Find Java runtime
local function get_java_home()
  local java_home = os.getenv("JAVA_HOME")
  if java_home then
    return java_home
  end
  -- Fallback to system java
  local handle = io.popen("dirname $(dirname $(readlink -f $(which java)))")
  if handle then
    local result = handle:read("*a"):gsub("%s+", "")
    handle:close()
    return result
  end
  return nil
end

-- Extended capabilities for debugging and testing
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Build bundles for debugging
local bundles = {}

-- Java debug adapter
local java_debug_bundle = vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true)
if java_debug_bundle ~= "" then
  table.insert(bundles, java_debug_bundle)
end

-- Java test runner
local java_test_bundles = vim.fn.glob(java_test_path .. "/extension/server/*.jar", true, true)
if java_test_bundles then
  vim.list_extend(bundles, java_test_bundles)
end

-- Configuration
local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration", jdtls_path .. "/config_" .. os_config,
    "-data", workspace_dir,
  },

  root_dir = root_dir,

  settings = {
    java = {
      home = get_java_home(),
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {},
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all",
        },
      },
      format = {
        enabled = true,
      },
      signatureHelp = {
        enabled = true,
      },
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
        importOrder = {
          "java",
          "javax",
          "com",
          "org",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
    },
  },

  init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities,
  },

  capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

-- Keymaps for Java-specific actions
config.on_attach = function(client, bufnr)
  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  -- Standard LSP keymaps
  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  map("n", "gr", vim.lsp.buf.references, "References")
  map("n", "gi", vim.lsp.buf.implementation, "Implementation")
  map("n", "K", vim.lsp.buf.hover, "Hover")
  map("n", "<leader>la", vim.lsp.buf.code_action, "Code action")
  map("n", "<leader>lr", vim.lsp.buf.rename, "Rename")
  map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format")
  map("n", "<leader>ls", vim.lsp.buf.signature_help, "Signature help")

  -- Java-specific keymaps
  map("n", "<leader>jo", jdtls.organize_imports, "Organize imports")
  map("n", "<leader>jv", jdtls.extract_variable, "Extract variable")
  map("v", "<leader>jv", function() jdtls.extract_variable(true) end, "Extract variable")
  map("n", "<leader>jc", jdtls.extract_constant, "Extract constant")
  map("v", "<leader>jc", function() jdtls.extract_constant(true) end, "Extract constant")
  map("v", "<leader>jm", function() jdtls.extract_method(true) end, "Extract method")

  -- Test keymaps
  map("n", "<leader>jtc", jdtls.test_class, "Test class")
  map("n", "<leader>jtn", jdtls.test_nearest_method, "Test nearest method")

  -- Debug keymaps
  map("n", "<leader>jd", function()
    if jdtls.dap then
      jdtls.setup_dap({ hotcodereplace = "auto" })
      require("jdtls.dap").setup_dap_main_class_configs()
    end
  end, "Setup Java debug")

  -- Setup DAP after attach
  vim.defer_fn(function()
    if jdtls.dap then
      jdtls.setup_dap({ hotcodereplace = "auto" })
    end
  end, 2000)
end

-- Start jdtls
jdtls.start_or_attach(config)
