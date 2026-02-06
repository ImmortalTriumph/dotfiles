local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
  return
end

local mason_path = vim.fn.stdpath("data") .. "/mason"
local jdtls_path = mason_path .. "/packages/jdtls"
local java_debug_path = mason_path .. "/packages/java-debug-adapter"
local java_test_path = mason_path .. "/packages/java-test"

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  root_dir = vim.fn.getcwd()
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

local os_config = "linux"
if vim.fn.has("mac") == 1 then
  os_config = "mac"
elseif vim.fn.has("win32") == 1 then
  os_config = "win"
end

local function get_installed_java_versions()
  local versions = {}
  local handle = io.popen("archlinux-java status 2>/dev/null")
  if handle then
    for line in handle:lines() do
      local version = line:match("^%s*([%w%-]+openjdk)%s*")
      if version then
        local is_default = line:match("%(default%)") ~= nil
        table.insert(versions, { name = version, default = is_default })
      end
    end
    handle:close()
  end
  return versions
end

local function build_runtimes()
  local runtimes = {}
  for _, v in ipairs(get_installed_java_versions()) do
    local java_ver = v.name:match("java%-(%d+)%-")
    if java_ver then
      table.insert(runtimes, {
        name = "JavaSE-" .. java_ver,
        path = "/usr/lib/jvm/" .. v.name,
        default = v.default,
      })
    end
  end
  return runtimes
end

local function get_java_home()
  local java_home = os.getenv("JAVA_HOME")
  if java_home then
    return java_home
  end
  local handle = io.popen("dirname $(dirname $(readlink -f $(which java)))")
  if handle then
    local result = handle:read("*a"):gsub("%s+", "")
    handle:close()
    return result
  end
  return nil
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local bundles = {}
local java_debug_bundle = vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true)
if java_debug_bundle ~= "" then
  table.insert(bundles, java_debug_bundle)
end

local java_test_bundles = vim.fn.glob(java_test_path .. "/extension/server/*.jar", true, true)
if java_test_bundles then
  vim.list_extend(bundles, java_test_bundles)
end

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
      eclipse = { downloadSources = true },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = build_runtimes(),
      },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
      inlayHints = { parameterNames = { enabled = "all" } },
      format = { enabled = true },
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
        importOrder = { "java", "javax", "com", "org" },
      },
      sources = {
        organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
      },
      codeGeneration = {
        toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
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

local function switch_java_version(version)
  vim.fn.jobstart(string.format("sudo archlinux-java set %s", version), {
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.notify("Switched to " .. version .. ". Restarting jdtls...", vim.log.levels.INFO)
        vim.cmd("LspStop jdtls")
        vim.defer_fn(function()
          config.settings.java.configuration.runtimes = build_runtimes()
          jdtls.start_or_attach(config)
        end, 500)
      else
        vim.notify("Failed to switch Java version (sudo required)", vim.log.levels.ERROR)
      end
    end,
    pty = true,
  })
end

local function pick_java_version()
  local ok_pickers, pickers = pcall(require, "telescope.pickers")
  local ok_finders, finders = pcall(require, "telescope.finders")
  local ok_conf, conf = pcall(require, "telescope.config")
  local ok_actions, actions = pcall(require, "telescope.actions")
  local ok_state, action_state = pcall(require, "telescope.actions.state")

  if not (ok_pickers and ok_finders and ok_conf and ok_actions and ok_state) then
    vim.notify("Telescope is required for Java version picker", vim.log.levels.ERROR)
    return
  end

  local versions = get_installed_java_versions()
  if #versions == 0 then
    vim.notify("No Java versions found via archlinux-java", vim.log.levels.WARN)
    return
  end

  pickers.new({}, {
    prompt_title = "Select Java Version",
    finder = finders.new_table({
      results = versions,
      entry_maker = function(entry)
        local display = entry.name
        if entry.default then
          display = display .. " (current)"
        end
        return { value = entry.name, display = display, ordinal = entry.name }
      end,
    }),
    sorter = conf.values.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          switch_java_version(selection.value)
        end
      end)
      return true
    end,
  }):find()
end

config.on_attach = function(client, bufnr)
  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  map("n", "gr", vim.lsp.buf.references, "References")
  map("n", "gi", vim.lsp.buf.implementation, "Implementation")
  map("n", "K", vim.lsp.buf.hover, "Hover")
  map("n", "<leader>la", vim.lsp.buf.code_action, "Code action")
  map("n", "<leader>lr", vim.lsp.buf.rename, "Rename")
  map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format")
  map("n", "<leader>ls", vim.lsp.buf.signature_help, "Signature help")

  map("n", "<leader>jo", jdtls.organize_imports, "Organize imports")
  map("n", "<leader>jv", jdtls.extract_variable, "Extract variable")
  map("v", "<leader>jv", function() jdtls.extract_variable(true) end, "Extract variable")
  map("n", "<leader>jc", jdtls.extract_constant, "Extract constant")
  map("v", "<leader>jc", function() jdtls.extract_constant(true) end, "Extract constant")
  map("v", "<leader>jm", function() jdtls.extract_method(true) end, "Extract method")
  map("n", "<leader>jJ", pick_java_version, "Switch Java version")

  map("n", "<leader>jtc", jdtls.test_class, "Test class")
  map("n", "<leader>jtn", jdtls.test_nearest_method, "Test nearest method")

  map("n", "<leader>jd", function()
    if jdtls.dap then
      jdtls.setup_dap({ hotcodereplace = "auto" })
      require("jdtls.dap").setup_dap_main_class_configs()
    end
  end, "Setup Java debug")

  vim.defer_fn(function()
    if jdtls.dap then
      jdtls.setup_dap({ hotcodereplace = "auto" })
    end
  end, 2000)
end

jdtls.start_or_attach(config)
