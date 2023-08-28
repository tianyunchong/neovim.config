require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "jdtls",
        "clangd",
        "cmake",
        "pyright",
        "intelephense"
    },
})

local lspconfig = require('lspconfig')
local stubs = { "amqp", "apache", "apcu", "bcmath", "blackfire", "bz2", "calendar", "cassandra", "com_dotnet", "Core", "couchbase", "crypto", "ctype", "cubrid", "curl", "date", "dba", "decimal", "dom", "ds", "enchant", "Ev", "event", "exif", "fann", "FFI", "ffmpeg", "fileinfo", "filter", "fpm", "ftp", "gd", "gearman", "geoip", "geos", "gettext", "gmagick", "gmp", "gnupg", "grpc", "hash", "http", "ibm_db2", "iconv", "igbinary", "imagick", "imap", "inotify", "interbase", "intl", "json", "judy", "ldap", "leveldb", "libevent", "libsodium", "libxml", "lua", "lzf", "mailparse", "mapscript", "mbstring", "mcrypt", "memcache", "memcached", "meminfo", "meta", "ming", "mongo", "mongodb", "mosquitto-php", "mqseries", "msgpack", "mssql", "mysql", "mysql_xdevapi", "mysqli", "ncurses", "newrelic", "oauth", "oci8", "odbc", "openssl", "parallel", "Parle", "pcntl", "pcov", "pcre", "pdflib", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "phpdbg", "posix", "pspell", "pthreads", "radius", "rar", "rdkafka", "readline", "recode", "redis", "Reflection", "regex", "rpminfo", "rrd", "SaxonC", "session", "shmop", "SimpleXML", "snmp", "soap", "sockets", "sodium", "solr", "SPL", "SplType", "SQLite", "sqlite3", "sqlsrv", "ssh2", "standard", "stats", "stomp", "suhosin", "superglobals", "svn", "sybase", "sync", "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", "uopz", "uv", "v8js", "wddx", "win32service", "winbinder", "wincache", "wordpress", "xcache", "xdebug", "xhprof", "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "xxtea", "yaf", "yaml", "yar", "zend", "Zend OPcache", "ZendCache", "ZendDebugger", "ZendUtils", "zip", "zlib", "zmq", "zookeeper" }
-- stylua: ignore end

require("mason-lspconfig").setup_handlers({
  function (server_name)
    require("lspconfig")[server_name].setup{}
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
                  includePaths = { vim.fn.expand("$HOME/.intelephense/stubs") },
                  phpVersion = "7.4",
              },
          },
        },
    } 
  end,
})