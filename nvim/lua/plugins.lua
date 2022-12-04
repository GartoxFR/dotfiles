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
    use 'mfussenegger/nvim-jdtls'

    use 'p00f/clangd_extensions.nvim'

    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'arkav/lualine-lsp-progress'

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

    -- use 'akinsho/git-conflict.nvim'
    
    use 'jreybert/vimagit'
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'

    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use 'MortenStabenau/matlab-vim'

    use 'tikhomirov/vim-glsl'

     -- Unless you are still migrating, remove the deprecated commands from v1.x
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = { 
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }

    use 'simrat39/rust-tools.nvim'

    use 'dhruvasagar/vim-table-mode'

end)
