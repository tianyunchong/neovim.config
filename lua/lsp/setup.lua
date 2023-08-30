require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "jdtls",
        "clangd",
        "cmake",
        "pyright",
        "intelephense",
        "custom_elements_ls",
        "html",
        'jsonls',
    },
})

local M = {
  "lspconfig",
  lazy = false,
  dependencies = {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "SmiteshP/nvim-navic" },
  },
}


function M.on_attach(client, bufnr)
  local navic = require("nvim-navic")
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end


local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}
vim.diagnostic.config({
  virtual_text = false,
})



local lspconfig = require('lspconfig')
local stubs = { "amqp", "apache", "apcu", "bcmath", "blackfire", "bz2", "calendar", "cassandra", "com_dotnet", "Core", "couchbase", "crypto", "ctype", "cubrid", "curl", "date", "dba", "decimal", "dom", "ds", "enchant", "Ev", "event", "exif", "fann", "FFI", "ffmpeg", "fileinfo", "filter", "fpm", "ftp", "gd", "gearman", "geoip", "geos", "gettext", "gmagick", "gmp", "gnupg", "grpc", "hash", "http", "ibm_db2", "iconv", "igbinary", "imagick", "imap", "inotify", "interbase", "intl", "json", "judy", "ldap", "leveldb", "libevent", "libsodium", "libxml", "lua", "lzf", "mailparse", "mapscript", "mbstring", "mcrypt", "memcache", "memcached", "meminfo", "meta", "ming", "mongo", "mongodb", "mosquitto-php", "mqseries", "msgpack", "mssql", "mysql", "mysql_xdevapi", "mysqli", "ncurses", "newrelic", "oauth", "oci8", "odbc", "openssl", "parallel", "Parle", "pcntl", "pcov", "pcre", "pdflib", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "phpdbg", "posix", "pspell", "pthreads", "radius", "rar", "rdkafka", "readline", "recode", "redis", "Reflection", "regex", "rpminfo", "rrd", "SaxonC", "session", "shmop", "SimpleXML", "snmp", "soap", "sockets", "sodium", "solr", "SPL", "SplType", "SQLite", "sqlite3", "sqlsrv", "ssh2", "standard", "stats", "stomp", "suhosin", "superglobals", "svn", "sybase", "sync", "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", "uopz", "uv", "v8js", "wddx", "win32service", "winbinder", "wincache", "wordpress", "xcache", "xdebug", "xhprof", "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "xxtea", "yaf", "yaml", "yar", "zend", "Zend OPcache", "ZendCache", "ZendDebugger", "ZendUtils", "zip", "zlib", "zmq", "zookeeper" }
-- stylua: ignore end


require("mason").setup({
    ui = {
      border = {"┏", "━", "┓", "┃", "┛", "━", "┗", "┃"},
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
})

require("mason-lspconfig").setup_handlers({
  function (server_name)
    require("lspconfig")[server_name].setup{
        on_attach = M.on_attach,
        capabilities,
    }
  end,
  -- Next, you can provide targeted overrides for specific servers.
  ["lua_ls"] = function ()
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
    }
  }
  end,
  ["clangd"] = function ()
    lspconfig.clangd.setup {
      cmd = {
        "clangd",
        "--header-insertion=never",
        "--query-driver=/opt/homebrew/opt/llvm/bin/clang",
        "--all-scopes-completion",
        "--completion-style=detailed",
      }
    }
  end,
  ["html"] = function()
      lspconfig.html.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "html", "phtml" }
      })
  end,
  ["intelephense"] = function ()
    lspconfig.intelephense.setup {
        cmd = { 'intelephense', '--stdio' };
        filetypes = { 'php' };
        root_dir = function(fname)
          return vim.loop.cwd()
        end;
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        init_options = {
            builtInMethodTypes = true,
            -- licenceKey = vim.fn.expand("$HOME/.intelephense/license.txt"),
            storagePath = vim.fn.expand("$HOME/.intelephense"),
            globalStoragePath = vim.fn.expand("$HOME/.intelephense"),
        },
        settings = {
          intelephense = {
              stubs = stubs,
              environment = {
                  includePaths = { 
                    vim.fn.expand("$HOME/.intelephense/stubs"), 
                    vim.fn.expand("$HOME/.composer/vendor/phalcon"), 
                    vim.fn.expand("$HOME/.composer/vendor/phpstorm-stubs"),
                  },
                  phpVersion = "7.4",
              },
          },
        },
    } 
  end,
  ["jsonls"] = function(server_name)
      lspconfig.jsonls.setup({
        on_attach = M.on_attach,
        capabilities,
        commands = {
          Format = {
            function()
              vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
            end
          }
        }
      })
  end
})