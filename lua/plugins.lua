local packer = require("packer")
packer.startup({
  function(use)
    -- Packer 可以管理自己本身
    use 'wbthomason/packer.nvim'
    use("folke/tokyonight.nvim")
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    -- bufferline安装
    use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
    -- 底部信息栏
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
    use("arkav/lualine-lsp-progress")
    -- 搜索插件
    use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }

    -- telescope extensions
    use "LinArcX/telescope-env.nvim"

    use("glepnir/dashboard-nvim")

    use("ahmedkhalf/project.nvim")
    -- 语法高亮插件
    use({ "nvim-treesitter/nvim-treesitter" })

    --------------------- LSP --------------------
    use({ "williamboman/nvim-lsp-installer"})
    -- Lspconfig
    use({ "neovim/nvim-lspconfig" })

    -- 补全插件
    -- 补全引擎
    -- use("hrsh7th/nvim-cmp")
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp'
        }
    }

    -- snippet 引擎
    use("hrsh7th/vim-vsnip")
    -- 补全源
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }

    -- 常见编程语言代码段
    use("rafamadriz/friendly-snippets")
    use("onsails/lspkind.nvim")
    use("tami5/lspsaga.nvim" ) -- 新增

    -- indent-blankline
    use("lukas-reineke/indent-blankline.nvim")

    -- 代码格式化
    -- use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
    use("mhartington/formatter.nvim")
    
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")

    -- easymotion
    use {
      'easymotion/vim-easymotion',
      config = function()
        -- 插件配置代码
      end
    }

    use 'preservim/tagbar'





    -- 你的插件列表...
  end,
  config = {
    -- 并发数限制
    max_jobs = 16,
    -- 浮动窗口打开安装列表
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end,
    },
  },
})


