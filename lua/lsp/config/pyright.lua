-- local lsp_set_keymap = require("keybindings")
-- local util = require 'lspconfig/util'

-- local opts = {
--     on_attach = function(_, bufnr)
--         lsp_set_keymap.set_keymap(bufnr)
--     end,
--     cmd = { "pyright-langserver", "--stdio" },
--     filetypes = { "python" },
--     settings = {
--         python = {
--             analysis = {
--                 autoSearchPaths = true,
--                 diagnosticMode = "workspace",
--                 useLibraryCodeForTypes = true,
--                 typeCheckingMode = "off"
--             },
--         },
--     },
--     root_dir = function(fname)
--         local root_files = {
--             'pyproject.toml',
--             'setup.py',
--             'setup.cfg',
--             'requirements.txt',
--             'Pipfile',
--             'pyrightconfig.json',
--         }
--         return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
--     end,
-- }

local opts = {}



-- 查看目录等信息
return {
    on_setup = function(server)
        server:setup(opts)
    end,
}
