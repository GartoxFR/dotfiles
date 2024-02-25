return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function() 

        local wk = require("which-key")
        local tr = require("trouble")
        local opts = {skip_groups = true, jump = true}
        wk.register({
            t = {
                name = "Trouble",
                l = {function() tr.toggle("document_diagnostics") end, "Open list"},
                n = {function() tr.next(opts) end, "Next diagnostic"},
                p = {function() tr.previous(opts) end, "Previous diagnostic"},
            }
        }, {prefix = "<leader>"})
        vim.keymap.set("n", "<leader>l", function() require("trouble").open('document_diagnostics') end)
    end
}
