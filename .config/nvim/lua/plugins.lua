return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'morhetz/gruvbox'
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'kaicataldo/material.vim'
    use 'neovim/nvim-lspconfig'
    use 'ray-x/lsp_signature.nvim'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'windwp/nvim-autopairs'
    use 'cdelledonne/vim-cmake'
    use 'zefei/vim-colortuner'

    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-context'

    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'numToStr/Comment.nvim'

    use 'onsails/lspkind.nvim'

    use 'nvim-lua/plenary.nvim'
    use 'ThePrimeagen/harpoon'

    use 'maxbrunsfeld/vim-yankstack'
end)
