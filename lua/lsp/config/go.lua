local nvim_lsp = require("lspconfig")

local opts = {
	on_attach = function(client,bufnr)
		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr,...)
		end

		require("keybindings").mapLSP(buf_set_keymap)
		vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
	end,
    -- capabilities = capabilities,
    root_dir = nvim_lsp.util.root_pattern('.git', 'go.mod','go.work'),
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
