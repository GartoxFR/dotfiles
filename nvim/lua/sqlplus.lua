local Job = require('plenary.job')
if job == nil then
    job = Job:new({
        command = "sqlplus",
        args = {"-S", "system/oracle@//localhost:49161"},
        on_stdout = function(_, line) 
            vim.defer_fn(function() vim.api.nvim_buf_set_lines(17, -1, -1, false, {line}) end, 1)
            table.insert(results, line)
        end
    })
    job:start();
end

return job
