require('plugins')
vim.opt.termguicolors = true
require("notify").setup({
  background_colour = "#000000",
})
vim.notify = require("notify")

vim.g.mapleader = " "
vim.g.maplocalleader = "m"

vim.cmd([[
    so ~/.config/nvim/legacy.vim
]])

require('lualine').setup({
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
})
require('nvim-autopairs').setup {}

require('nvimcmp')

require('mylsp')

require('orgmode').setup{
    org_agenda_files = {'~/org/**/*'},
    org_default_notes_file = '~/org/refile.org',
    org_capture_templates = {
        t = {
            description = 'Simple task',
            template = '* TODO %?\n %u'
        },
        f = {
            description = 'Task in file',
            template = '* TODO %a %?\n %u'
        },
        e =  'Event',
        er = {
          description = 'recurring',
          template = '** %?\n',
          target = '~/org/calendar.org',
          headline = 'recurring'
        },
        eo = {
          description = 'one-time',
          template = '** %?\n',
          target = '~/org/calendar.org',
          headline = 'one-time'
        }
    }
}

require('orgmode').setup_ts_grammar()
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
require("snippets")

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

require('tokyonight').setup({
    transparent = true,
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
require('trouble_settings')

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
    "icon",
    -- "permissions",
    -- "size",
    -- "mtime",
  },
})

require('aerial').setup()

vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle<CR>')

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local total_lines = vim.api.nvim_buf_line_count(0)
    local folded_lines = endLnum - lnum
    local suffix = (' 󰁂 %d %d%%'):format(folded_lines, folded_lines / total_lines * 100)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    local rAllignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
    suffix = ("."):rep(rAllignAppndx) .. suffix
    table.insert(newVirtText, {suffix, 'Comment'})
    return newVirtText
end

require('ufo').setup({
    open_fold_hl_timeout = 150,
    close_fold_kinds = {'imports', 'comment'},
    fold_virt_text_handler = handler,
    preview = {
        win_config = {
            border = {'', '─', '', '', '', '─', '', ''},
            winhighlight = 'Normal:Folded',
            winblend = 0
        },
        mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>',
            jumpTop = '[',
            jumpBot = ']'
        }
    },
})

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
