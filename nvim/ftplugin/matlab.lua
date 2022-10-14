local opts = { noremap=true, silent=true }
-- Enable completion triggered by <c-x><c-o>
local bufnr = vim.api.nvim_get_current_buf()

vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F5>', '<cmd>MatlabRun<CR>', opts)
