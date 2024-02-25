local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.g.mapleader = " "
vim.g.maplocalleader = "m"

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")


--require('plugins_old')
vim.opt.termguicolors = true

require("notify").setup({
    background_colour = "#000000",
})
vim.notify = require("notify")


vim.cmd([[
so ~/.config/nvim/legacy.vim
]])


require('nvimcmp')

require('mylsp')


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


local wk = require("which-key")
wk.register({
    g = {
        name = "Git",
        a = {"<Plug>(GitGutterStageHunk)", "Stage hunk"},
        u = {"<Plug>(GitGutterUndoHunk)", "Undo hunk"},
        s = {":Magit<CR>", "Open magit status"}
    }
}, {prefix = "<leader>"})


-- nnoremap <leader>e :Oil<CR>
wk.register({
    e = {":Oil<CR>", "Open directory browser"}
}, {prefix = "<leader>"})

