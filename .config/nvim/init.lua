require('plugins')

vim.g.mapleader = ","

vim.cmd([[
    so ~/.config/nvim/legacy.vim
]])

require('lualine').setup()
require('nvim-autopairs').setup {}

require('nvimcmp')

require('mylsp')

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
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

require("keymap.harpoon")
