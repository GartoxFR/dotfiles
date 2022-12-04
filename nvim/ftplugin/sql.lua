local Job = require('plenary.job')
local bufname = "SQL Results"

local results = {}
vim.api.nvim_create_autocmd("BufHidden", {
    group = vim.api.nvim_create_augroup("sqlplus", { clear = true }),
    pattern = bufname,
    callback = function()
        context.job:send("EXIT\n")
        vim.defer_fn(function() 
            vim.api.nvim_buf_delete(context.buf, {force = true}) 
            context = nil
        end, 100)
    end
})
function try_init()
    if context == nil then
        context = {}
        local lastWin = vim.api.nvim_get_current_win()
        vim.cmd('split')
        vim.cmd('res 15')
        local win = vim.api.nvim_get_current_win()
        local buf = vim.api.nvim_create_buf(true, true)
        vim.api.nvim_buf_set_name(buf, bufname)
        vim.api.nvim_win_set_buf(win, buf)

        context.job = Job:new({
            command = "sqlplus",
            args = {"-S", "echorynski/RATIOBILLY@//if-Oracle11.insa-lyon.fr:1521/DB11"},
            cwd = vim.fn.getcwd(),
            on_stdout = function(_, line) 
                if not (line == nil or line == '') then
                    vim.defer_fn(function() vim.api.nvim_buf_set_lines(buf, -1, -1, false, {line}) end, 1)
                    table.insert(results, line)
                end
            end
        })
        context.job:start();

        -- context.job:send("SET PAGESIZE 50000\n")
        -- context.job:send("SET LINESIZE 30000\n")
        -- context.job:send("SET FEEDBACK OFF\n")
        -- context.job:send("set wrap off\n")

        context.job:send("set lines 256\n")
        context.job:send("set trimout on\n")
        context.job:send("set tab off\n")
        context.job:send("set pagesize 100\n")
        context.job:send("set colsep \" | \"\n")

        vim.cmd("wincmd k");
        context.buf = buf;
    end
end

function execute_file_current_file()
    try_init()
    vim.api.nvim_buf_set_lines(context.buf, 0, -1, false, {})
    context.job:send("@" .. vim.fn.expand("%") .. "\n")
end

vim.api.nvim_buf_create_user_command(vim.api.nvim_get_current_buf(), "SQLExecuteFile", execute_file_current_file, {})


local opts = { noremap=true, silent=true }
vim.api.nvim_buf_set_keymap(vim.api.nvim_get_current_buf(), 'n', '<F5>', "<cmd>SQLExecuteFile<cr>", opts)

