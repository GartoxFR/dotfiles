return {
    "neovim/nvim-lspconfig",
    "ray-x/lsp_signature.nvim",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lua",
    -- "mfussenegger/nvim-jdtls"

    "p00f/clangd_extensions.nvim",
    "simrat39/rust-tools.nvim",
    "arkav/lualine-lsp-progress",
    "onsails/lspkind.nvim",

    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        opts = {
            enable_autosnippets = true,
        },
    },
    "saadparwaiz1/cmp_luasnip",
}
