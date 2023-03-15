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

function escape(args)
	local ret = {}
	for _,a in pairs(args) do
		s = tostring(a)
		if s:match("[^A-Za-z0-9_/:=-]") then
			s = '"' .. s:gsub("'", "\\'"):gsub('"', '\\"') .. '"'
		end
		table.insert(ret,s)
	end
	return table.concat(ret, " ")
end

function xpath() 
    io.popen("tmux neww sh -c '/home/ewan/dotfiles/bin/xpath.sh " ..  escape({vim.api.nvim_get_current_line()}) .. "; read -s -n 1 -p \"Press any key to continue...\"'")
    
end

nnoremap("<F5>", build, {silent = true})

nnoremap("<leader>yf", function() io.popen("cat " .. vim.fn.expand("%") .. " | xclip -sel clip") end, {silent = true})

nnoremap("<leader>xp", xpath, {silent = true})

