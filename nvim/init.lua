require('plugins')
vim.opt.termguicolors = true
require("notify").setup({
  background_colour = "#000000",
})
vim.notify = require("notify")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd([[
    so ~/.config/nvim/legacy.vim
]])

require('lualine').setup({
    options = {
        theme = "tokyonight"
    },
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
require('nvim-treesitter.configs').setup { highlight = {
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

require('tokyonight').setup({
    transparent = true
})
vim.g.tokyonight_dark_float = false
vim.g.tokyonight_transparent = vim.g.transparent_enabled

-- require("transparent").setup({
--   enable = false, -- boolean: enable transparent
--   extra_groups = { -- table/string: additional groups that should be cleared
--     -- In particular, when you set it to 'all', that means all available groups
--
--     -- example of akinsho/nvim-bufferline.lua
--     "BufferLineTabClose",
--     "BufferlineBufferSelected",
--     "BufferLineFill",
--     "BufferLineBackground",
--     "BufferLineSeparator",
--     "BufferLineIndicatorSelected",
--     "NormalFloat",
--     "NeoTreeNormal",
--     "NeoTreeNormalNC",
--     "TelescopeBorder",
--     "TelescopeNormal",
--   },
--   exclude = {}, -- table: groups you don't want to clear
-- })


-- require('neorg').setup {
--     load = {
--         ["core.defaults"] = {}, -- Loads default behaviour
--         ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
--         ["core.norg.dirman"] = { -- Manages Neorg workspaces
--             config = {
--                 workspaces = {
--                     notes = "~/notes",
--                 },
--             },
--         },
--     },
-- }


require('telescope_settings')

require("keymap.harpoon")
require("build")


require("toggleterm").setup {
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.3
        end
    end,
    open_mapping = '<C-t>',
}

require('overseer_settings')

require("oil").setup({
  -- Id is automatically added at the beginning, and name at the end
  -- See :help oil-columns
  columns = {
    -- "icon",
    "permissions",
    "size",
    "mtime",
  },
})

require('aerial').setup()

vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle<CR>')
