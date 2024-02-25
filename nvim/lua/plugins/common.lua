return {
    {"tpope/vim-unimpaired"},
    { "kevinhwang91/nvim-bqf", ft = "qf"},
    { "nvim-tree/nvim-web-devicons", lazy = true },

    {"nvim-lua/plenary.nvim"},

    {"stevearc/overseer.nvim", event = "VeryLazy"},
    {"stevearc/dressing.nvim", event = "VeryLazy"},
    {"rcarriga/nvim-notify"},

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },

    "cdelledonne/vim-cmake",

    {"nvim-treesitter/nvim-treesitter", config = function()
        require('nvim-treesitter.configs').setup { 
            highlight = {
                enable = true,
                disable = function(lang, bufnr)
                    return false
                end
            },
            ensure_installed = { "c", "lua", "rust" },

            --	 Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            --	 Automatically install missing parsers when entering buffer
            auto_install = true,
        }

        local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
        parser_config.lalrpop = {
             install_info = {
                url = "~/dev/tree-sitter-lalrpop/",
                files = { "src/parser.c", "src/scanner.c" },
              },
        }
    end},

    "nvim-treesitter/nvim-treesitter-context",
    "tpope/vim-surround",
    {"tpope/vim-repeat", event = "VeryLazy"},

    {
	"numToStr/Comment.nvim", 
        config = function()
            require('Comment').setup()
        end
    },


    "nvim-lua/plenary.nvim",
    "ThePrimeagen/harpoon",

    "maxbrunsfeld/vim-yankstack",

    -- "akinsho/git-conflict.nvim",

    "jreybert/vimagit",
    "tpope/vim-fugitive",
    "airblade/vim-gitgutter",

    "MortenStabenau/matlab-vim",

    "tikhomirov/vim-glsl",


    -- "dhruvasagar/vim-table-mode",

    "aklt/plantuml-syntax",
    {
        "stevearc/aerial.nvim",
        opts = {},
    },

    {"kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async"},
    "kevinhwang91/promise-async",
    "dhruvasagar/vim-table-mode",
}
