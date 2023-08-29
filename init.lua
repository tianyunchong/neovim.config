require("basic")


-- 快捷键映射
require("keybindings")


-- Packer 插件管理
require("plugins")

-- 主题管理
require("colorscheme")

-- 插件配置
require("plugin-config.nvim-tree")



require("plugin-config.bufferline")


require("plugin-config.lualine")


require("plugin-config.telescope")

-- 自动安装语言解析
require("plugin-config.nvim-treesitter") -- （新增）


-- 内置LSP (新增)
require("lsp.setup")


require("lsp.cmp")

require("plugin-config.indent-blankline")

require("lsp.format")