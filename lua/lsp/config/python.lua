local nvim_lsp = require("lspconfig")

local opts = {
    on_attach = function(client,bufnr)
        lvim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
    end,
    -- capabilities = capabilities,
    root_dir = nvim_lsp.util.root_pattern('.git'),
    init_options = {
        usePlaceholders = false,
    },
    single_file_support = true,
}


-- 查看目录等信息
return {
    on_setup = function(server)
        server:setup(opts)
    end,
}
