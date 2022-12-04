require('plugins')

vim.g.mapleader = ","

vim.cmd([[
    so ~/.config/nvim/legacy.vim
]])

require('lualine').setup({
    sections = {
        lualine_c = {
            'filename',
            'lsp_progress'
        }
    }
})
require('nvim-autopairs').setup {}

require('nvimcmp')

require('mylsp')

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        disable = function(lang, bufnr)
            return false
        end
    },
	ensure_installed = { "c", "lua", "rust" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	auto_install = true,
}

require('Comment').setup()

local ls = require('luasnip')

vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if (ls.expand_or_jumpable()) then
        ls.expand_or_jump()
    end
end)

vim.keymap.set({ "i", "s" }, "<C-h>", function()
    if (ls.jumpable(-1)) then
        ls.jump(-1);
    end
end)

require("neo-tree").setup({
    event_handlers = {
        {
            event = "file_opened",
            handler = function()
                print("test")
                require("neo-tree").close_all()
            end
        }
    }
})

require("keymap.harpoon")
require("build")
