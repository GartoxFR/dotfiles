return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
        opts = {
            options = {
                component_separators = { left = '|', right = '|'},
                section_separators = { left = '', right = ''},
                theme = "catppuccin"
            },
            sections = {
                lualine_c = {
                    'filename',
                    'lsp_progress'
                }
            }
        }
    }
}
