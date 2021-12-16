-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- -- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
-- -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
-- local config = {
--   -- The command that starts the language server
--   -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--   cmd = {

--     -- 💀
--     'java', -- or '/path/to/java11_or_newer/bin/java'
--             -- depends on if `java` is in your $PATH env variable and if it points to the right version.

--     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--     '-Dosgi.bundles.defaultStartLevel=4',
--     '-Declipse.product=org.eclipse.jdt.ls.core.product',
--     '-Dlog.protocol=true',
--     '-Dlog.level=ALL',
--     '-Xms1g',
--     '--add-modules=ALL-SYSTEM',
--     '--add-opens', 'java.base/java.util=ALL-UNNAMED',
--     '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

--     -- 💀
--     -- '-jar', '/path/to/jdtls_install_location/plugins/org.eclipse.equinox.launcher_VERSION_NUMBER.jar',
--     -- '-jar', '/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
--     '-jar', '/home/daniel/.local/lib/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
--          -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
--          -- Must point to the                                                     Change this to
--          -- eclipse.jdt.ls installation                                           the actual version


--     -- 💀
--     -- '-configuration', '/usr/share/java/jdtls/config_linux',
--     '-configuration', '/home/daniel/.local/lib/jdtls/config_linux/',
--     -- '-configuration', '/path/to/jdtls_install_location/config_SYSTEM',
--                     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
--                     -- Must point to the                      Change to one of `linux`, `win` or `mac`
--                     -- eclipse.jdt.ls installation            Depending on your system.


--     -- 💀
--     -- See `data directory configuration` section in the README
--     -- '-data', '/path/to/unique/per/project/workspace/folder'
--     '-data', vim.fn.expand('~/.cache/jdtls-workspace') .. workspace_dir
--   },

--   -- 💀
--   -- This is the default if not provided, you can remove it. Or adjust as needed.
--   -- One dedicated LSP server & client will be started per unique root_dir
--   root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

--   -- Here you can configure eclipse.jdt.ls specific settings
--   -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--   -- for a list of options
--   settings = {
--     java = {
--     }
--   },

--   capabilities = capabilities
-- }
-- -- This starts a new client & server,
-- -- or attaches to an existing client & server depending on the `root_dir`.
-- require('jdtls').start_or_attach(config)

-- local opts = {
--   noremap = true,
--   silent = true
-- }

-- vim.api.nvim_set_keymap('n', '<leader>lg', '<cmd>lua vim.lsp.buf.formatting_sync(nil, 1000)<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>lA', '<cmd>lua require(\'jdtls\').code_action9)<CR>', { silent = true })

require'lspconfig'.jdtls.setup{}

local util = require 'lspconfig.util'
local handlers = require 'vim.lsp.handlers'

local sysname = vim.loop.os_uname().sysname
local env = {
  HOME = vim.loop.os_homedir(),
  JAVA_HOME = os.getenv 'JAVA_HOME',
  JDTLS_HOME = os.getenv 'JDTLS_HOME',
  WORKSPACE = os.getenv 'WORKSPACE',
}

local function get_java_executable()
  local executable = env.JAVA_HOME and util.path.join(env.JAVA_HOME, 'bin', 'java') or 'java'

  return sysname:match 'Windows' and executable .. '.exe' or executable
end

local function get_workspace_dir()
  return env.WORKSPACE and env.WORKSPACE or util.path.join(env.HOME, 'workspace')
end

local function get_jdtls_jar()
  return vim.fn.expand '$JDTLS_HOME/plugins/org.eclipse.equinox.launcher_*.jar'
end

local function get_jdtls_config()
  if sysname:match 'Linux' then
    return util.path.join(env.JDTLS_HOME, 'config_linux')
  elseif sysname:match 'Darwin' then
    return util.path.join(env.JDTLS_HOME, 'config_mac')
  elseif sysname:match 'Windows' then
    return util.path.join(env.JDTLS_HOME, 'config_win')
  else
    return util.path.join(env.JDTLS_HOME, 'config_linux')
  end
end

-- TextDocument version is reported as 0, override with nil so that
-- the client doesn't think the document is newer and refuses to update
-- See: https://github.com/eclipse/eclipse.jdt.ls/issues/1695
local function fix_zero_version(workspace_edit)
  if workspace_edit and workspace_edit.documentChanges then
    for _, change in pairs(workspace_edit.documentChanges) do
      local text_document = change.textDocument
      if text_document and text_document.version and text_document.version == 0 then
        text_document.version = nil
      end
    end
  end
  return workspace_edit
end

-- Compatibility shim added for breaking changes to the lsp handler signature in nvim-0.5.1
local function remap_arguments(err, result, ctx)
  if vim.fn.has 'nvim-0.5.1' == 1 then
    handlers[ctx.method](err, result, ctx)
  else
    handlers[ctx.method](err, ctx.method, result)
  end
end

local function on_textdocument_codeaction(err, actions, ctx)
  for _, action in ipairs(actions) do
    -- TODO: (steelsojka) Handle more than one edit?
    if action.command == 'java.apply.workspaceEdit' then -- 'action' is Command in java format
      action.edit = fix_zero_version(action.edit or action.arguments[1])
    elseif type(action.command) == 'table' and action.command.command == 'java.apply.workspaceEdit' then -- 'action' is CodeAction in java format
      action.edit = fix_zero_version(action.edit or action.command.arguments[1])
    end
  end

  remap_arguments(err, actions, ctx)
end

local function on_textdocument_rename(err, workspace_edit, ctx)
  remap_arguments(err, fix_zero_version(workspace_edit), ctx)
end

local function on_workspace_applyedit(err, workspace_edit, ctx)
  remap_arguments(err, fix_zero_version(workspace_edit), ctx)
end

-- Non-standard notification that can be used to display progress
local function on_language_status(_, result)
  local command = vim.api.nvim_command
  command 'echohl ModeMsg'
  command(string.format('echo "%s"', result.message))
  command 'echohl None'
end

local root_files = {
  -- Single-module projects
  {
    'build.xml', -- Ant
    'pom.xml', -- Maven
    'settings.gradle', -- Gradle
    'settings.gradle.kts', -- Gradle
  },
  -- Multi-module projects
  { 'build.gradle', 'build.gradle.kts' },
}

return {
  default_config = {
    cmd = {
      get_java_executable(),
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xms1g',
      '-Xmx2G',
      '--add-modules=ALL-SYSTEM',
      '--add-opens',
      'java.base/java.util=ALL-UNNAMED',
      '--add-opens',
      'java.base/java.lang=ALL-UNNAMED',
      '-jar',
      get_jdtls_jar(),
      '-configuration',
      get_jdtls_config(),
      '-data',
      get_workspace_dir(),
    },
    filetypes = { 'java' },
    root_dir = function(fname)
      for _, patterns in ipairs(root_files) do
        local root = util.root_pattern(unpack(patterns))(fname)
        if root then
          return root
        end
      end
    end,
    single_file_mode = true,
    init_options = {
      workspace = get_workspace_dir(),
      jvm_args = {},
      os_config = nil,
    },
    handlers = {
      -- Due to an invalid protocol implementation in the jdtls we have to conform these to be spec compliant.
      -- https://github.com/eclipse/eclipse.jdt.ls/issues/376
      ['textDocument/codeAction'] = util.compat_handler(on_textdocument_codeaction),
      ['textDocument/rename'] = util.compat_handler(on_textdocument_rename),
      ['workspace/applyEdit'] = util.compat_handler(on_workspace_applyedit),
      ['language/status'] = util.compat_handler(vim.schedule_wrap(on_language_status)),
    },
  },
  docs = {
    package_json = 'https://raw.githubusercontent.com/redhat-developer/vscode-java/master/package.json',
    description = [[
https://projects.eclipse.org/projects/eclipse.jdt.ls
Language server for Java.
IMPORTANT: If you want all the features jdtls has to offer, [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)
is highly recommended. If all you need is diagnostics, completion, imports, gotos and formatting and some code actions
you can keep reading here.
For manual installation you can download precompiled binaries from the
[official downloads site](http://download.eclipse.org/jdtls/snapshots/?d)
Due to the nature of java, settings cannot be inferred. Please set the following
environmental variables to match your installation. If you need per-project configuration
[direnv](https://github.com/direnv/direnv) is highly recommended.
```bash
# Mandatory:
# .bashrc
export JDTLS_HOME=/path/to/jdtls_root # Directory with the plugin and configs directories
# Optional:
export JAVA_HOME=/path/to/java_home # In case you don't have java in path or want to use a version in particular
export WORKSPACE=/path/to/workspace # Defaults to $HOME/workspace
```
```lua
  -- init.lua
  require'lspconfig'.jdtls.setup{}
```
For automatic installation you can use the following unofficial installers/launchers under your own risk:
  - [jdtls-launcher](https://github.com/eruizc-dev/jdtls-launcher) (Includes lombok support by default)
    ```lua
      -- init.lua
      require'lspconfig'.jdtls.setup{ cmd = { 'jdtls' } }
    ```
    ]],
    default_config = {
      root_dir = [[{
        -- Single-module projects
        {
          'build.xml', -- Ant
          'pom.xml', -- Maven
          'settings.gradle', -- Gradle
          'settings.gradle.kts', -- Gradle
        },
        -- Multi-module projects
        { 'build.gradle', 'build.gradle.kts' },
      } or vim.fn.getcwd()]],
    },
  },
}

