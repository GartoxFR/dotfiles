local nnoremap = require("keymap").nnoremap;

function build()
    if vim.bo.filetype == "c" or vim.bo.filetype == "cpp" then
        io.popen("tmux neww sh -c '/home/ewan/dotfiles/bin/build/build_cmake.sh " .. vim.fn.expand("%") .. " ; read -s -n 1 -p \"Press any key to continue...\"'")
    elseif vim.bo.filetype == "rs" then
        io.popen("tmux neww sh -c '/home/ewan/dotfiles/bin/build/build_cargo.sh ; read -s -n 1 -p \"Press any key to continue...\"'")
    else
        io.popen("tmux neww sh -c '/home/ewan/dotfiles/bin/build/build_default.sh " .. vim.fn.expand("%") .. "; read -s -n 1 -p \"Press any key to continue...\"'")
    end
    
end

nnoremap("<F5>", build, {silent = true})

nnoremap("<leader>yf", function() io.popen("cat " .. vim.fn.expand("%") .. " | xclip -sel clip") end, {silent = true})

